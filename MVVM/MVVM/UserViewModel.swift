//
//  UserViewModel.swift
//  MVVM
//
//  Created by doeun kim on 1/6/24.
//

import Foundation
import Combine

// ObservableObject는 struct에서는 되지 않고 class에서만 가능하다
class UserViewModel: ObservableObject {
    // 변화가 일어나는지 여부를 알고 싶은 property 앞에 Published를 써 놓는다.
    @Published var users = [
        User(name: "kim", age: 22),
        User(name: "lim", age: 11),
        User(name: "lee", age: 44),
    ]
    
    var cancellables: Set<AnyCancellable> = []
    
    // Read
    var count: Int {
        users.count
    }
    
    func user(index: Int) -> User {
        return users[index]
    }
    
    func userName(index: Int) -> String {
        return users[index].name
    }
    
    func userName2(index: Int, completion: @escaping (String) -> Void) {
        // 테이블 뷰가 없어졌다 화면에 나올 때 화면에 sink가 계속 축적되는 문제가 있음
        //ex) 화면을 움직이지 않은 상태에서 이름을 수정했을때 현재 있는 셀 개수*2만큼 호출됨 => 셀에서 별도의 해제를 위한 코드 필요
        $users.sink { users in
            completion(users[index].name)
        }.store(in: &cancellables)
    }
    
    func userName3(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $users
            .filter{$0.count > index}
            .sink { users in
            completion(users[index].name)
        }.store(in: &store)
    }
    
    func userAge(index: Int) -> String {
        return users[index].age.description
    }
    
    func userAge2(index: Int, completion: @escaping (String) -> Void) {
        // sink의 return의 AnyCancellable를 변수로 잘 잡아주어 메모리를 해제해야 함.
        $users.sink { users in
            completion(users[index].age.description)
        }.store(in: &cancellables)
    }
    
    func userAge3(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        // sink의 return의 AnyCancellable를 변수로 잘 잡아주어 메모리를 해제해야 함.
        $users
            .filter{$0.count > index}
            .sink { users in
            completion(users[index].age.description)
        }.store(in: &store)
    }
    
    // Create
    func createUser(name: String, age: Int) {
        let newUser = User(name: name, age: age)
        self.users.append(newUser)
    }
    
    // Update
    func updateUser(id: UUID, name: String, age: Int){
        if let selectedIndex = users.firstIndex(where: { user in user.id == id }) {
            users[selectedIndex].name = name
            users[selectedIndex].age = age
        }
    }
    
    // Delete
    // 변경 전 삭제 시 index out of range가 발생한 이유
    // 데이터만 삭제하고 바인딩이 연결괸 셀은 삭제되지 않고 살아있기 때문에 잘못된 인덱스 접근이 이루어지게 되었음.
    func deleteUser(id: UUID) {
        if let selectedIndex = users.firstIndex(where: {user in user.id == id}) {
            // 바인딩 된 것을 해제해준다.
            cancellables.removeAll()
            users.remove(at: selectedIndex)
        }
    }
    
    
}


