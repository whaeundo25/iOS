//
//  UserViewModel.swift
//  MVVM
//
//  Created by doeun kim on 1/6/24.
//

import Foundation

// ObservableObject는 struct에서는 되지 않고 class에서만 가능하다
class UserViewModel: ObservableObject {
    // 변화가 일어나는지 여부를 알고 싶은 property 앞에 Published를 써 놓는다.
    @Published var users = [
        User(name: "kim", age: 22),
        User(name: "lim", age: 11),
        User(name: "lee", age: 44),
    ]
    
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
    
    func userAge(index: Int) -> String {
        return users[index].age.description
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
    func deleteUser(id: UUID) {
        if let selectedIndex = users.firstIndex(where: {user in user.id == id}) {
            users.remove(at: selectedIndex)
        }
    }
    
    
}


