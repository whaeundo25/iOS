//
//  UserCell.swift
//  MVVM
//
//  Created by doeun kim on 1/6/24.
//

import UIKit
import Combine

class UserCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var cancellables: Set<AnyCancellable> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 화면이 준비되어 나올 때 호출 => cellForRowAt
    // 화면 밖으로 나갔다 화면에 다시 들어왔을 때 호출하는 부분
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }
    
}
