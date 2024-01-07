//
//  ViewController.swift
//  MVVM
//
//  Created by doeun kim on 1/6/24.
//

// 바인딩 - closure, notification, observableObject, rx => 옵저버 패턴

import UIKit
import Combine

class UserViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    
    var viewModel = UserViewModel()
    var selectedUUID = UUID()
    // 메모리 해제를 위해 사용하는 부분
    var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    @IBAction func create(_ sender: Any) {
        let name = nameField.text ?? ""
        let age = Int(ageField.text ?? "") ?? 0
        
        viewModel.createUser(name: name, age: age)
        
        tableView.reloadData()
    }
    
    @IBAction func edit(_ sender: Any) {
        let name = nameField.text ?? ""
        let age = Int(ageField.text ?? "") ?? 0
        
        viewModel.updateUser(id: selectedUUID, name: name, age: age)
        
        // tableView의 func들을 다시 호출해 주는 역할
//        tableView.reloadData()
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        viewModel.deleteUser(id: selectedUUID)
        
        tableView.reloadData()
    }
    
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
//        cell.nameLabel.text = model.info[indexPath.row].name
//        cell.ageLabel.text = model.info[indexPath.row].age.description
        
//        cell.nameLabel.text = viewModel.user(index: indexPath.row).name
//        cell.ageLabel.text = viewModel.user(index: indexPath.row).age.description
        
//        cell.nameLabel.text = viewModel.userName(index: indexPath.row)
//        cell.ageLabel.text = viewModel.userAge(index: indexPath.row)
        
        //sink는 바인딩하는 것을 의미함
        //viewModel의 users 부분이 바뀌게 되면 자동적으로 클로저 안에 있는 내용이 실행된다.
//        viewModel.$users.sink { users in
//            cell.nameLabel.text = users[indexPath.row].name
//        }.store(in: &cancellables)
        
//        // cell과 바로 연결하는 방법
//        viewModel.$users.sink { users in
//            cell.nameLabel.text = users[indexPath.row].name
//        }.store(in: &cell.cancellables)
        
//        viewModel.userName2(index: indexPath.row) { name in
//            cell.nameLabel.text = name
//        }
//        
//        viewModel.userAge2(index: indexPath.row) { age in
//            cell.ageLabel.text = age
//        }
        
        // 테이블 뷰가 화면 밖으로 나갔다 돌아왔을 때 여러번 실행되지 않도록 개선된 코드
        viewModel.userName3(index: indexPath.row, store: &cell.cancellables) { name in
            cell.nameLabel.text = name
        }
        
        viewModel.userAge3(index: indexPath.row, store: &cell.cancellables) { age in
            cell.ageLabel.text = age
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUUID = viewModel.user(index: indexPath.row).id
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
}


