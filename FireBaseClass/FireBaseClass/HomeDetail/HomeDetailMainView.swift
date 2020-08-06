//
//  HomeDetailMainView.swift
//  FireBaseClass
//
//  Created by haruka on 2020/08/05.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

protocol HomeDetailMainViewDelegate: NSObjectProtocol{
}

extension HomeDetailMainViewDelegate {
}

// MARK: - Property
class HomeDetailMainView: BaseView {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var discriptionLabel: UILabel!
    weak var delegate: HomeDetailMainViewDelegate? = nil
}

// MARK: - Life cycle
extension HomeDetailMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
        imageDesign()
    }
}

// MARK: - Protocol
extension HomeDetailMainView {
}

// MARK: - method
extension HomeDetailMainView {
    func imageDesign() {
        iconImage.layer.cornerRadius = iconImage.frame.width / 2
    }
    func getModel(postModel: PostModel) {
        discriptionLabel.text = postModel.description
    }
}
