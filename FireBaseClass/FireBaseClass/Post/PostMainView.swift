//
//  PostMainView.swift
//  FireBaseClass
//
//  Created by haruka on 2020/07/31.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

protocol PostMainViewDelegate: NSObjectProtocol{
    func touchAddButton()
}

extension PostMainViewDelegate {
}

// MARK: - Property
class PostMainView: BaseView {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTextField: UITextField!
    weak var delegate: PostMainViewDelegate? = nil
    // Action
    @IBAction func touchAddButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchAddButton()
        }
    }
}

// MARK: - Life cycle
extension PostMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Protocol
extension PostMainView {
}

// MARK: - method
extension PostMainView {
}
