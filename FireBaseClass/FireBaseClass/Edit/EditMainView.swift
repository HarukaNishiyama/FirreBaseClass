//
//  EditMainView.swift
//  FireBaseClass
//
//  Created by haruka on 2020/08/06.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

protocol EditMainViewDelegate: NSObjectProtocol{
}

extension EditMainViewDelegate {
}

// MARK: - Property
class EditMainView: BaseView {
    @IBOutlet weak var editPhotoImage: UIImageView!
    @IBOutlet weak var editTextView: UITextView!
    weak var delegate: EditMainViewDelegate? = nil
}

// MARK: - Life cycle
extension EditMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Protocol
extension EditMainView {
}

// MARK: - method
extension EditMainView {
    func setTextView() {
        editTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        editTextView.layer.borderWidth = 0.5
    }
    func update(postModel: PostModel) {
        editTextView.text = postModel.description
    }
}
