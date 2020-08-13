//
//  HomeMainViewCell.swift
//  FireBaseClass
//
//  Created by haruka on 2020/08/03.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

protocol HomeMainViewCellDelegate: NSObjectProtocol{
}

extension HomeMainViewCellDelegate {
}

// MARK: - Property
class HomeMainViewCell: BaseTableViewCell {
    // アイコン
    @IBOutlet weak var userIcon: UIImageView!
    // 写真
    @IBOutlet weak var photoImage: UIImageView!
    //　名前
    @IBOutlet weak var userNameLabel: UILabel!
    // 投稿文
    @IBOutlet weak var postLable: UILabel!
    weak var delegate: HomeMainViewCellDelegate? = nil
}

// MARK: - Life cycle
extension HomeMainViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        setUserIcon()
    }
}

// MARK: - Protocol
extension HomeMainViewCell {
}

// MARK: - method
extension HomeMainViewCell {
    func setUserIcon() {
        userIcon.layer.cornerRadius = userIcon.frame.width / 2
    }
    func updateCell(postModel: PostModel) {
        postLable.text = postModel.description
        guard let image_path = postModel.image_paths?[0] else {
            return
        }
        if let url = URL(string: image_path) {
            photoImage.af_setImage(withURL: url)
        }
    }
}
