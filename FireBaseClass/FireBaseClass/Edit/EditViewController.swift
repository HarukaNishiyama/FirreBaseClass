//
//  EditViewController.swift
//  FireBaseClass
//
//  Created by haruka on 2020/08/06.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

// MARK: - Property
class EditViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var mainView: EditMainView!
    var postModel: PostModel = PostModel()
}

// MARK: - Life cycle
extension EditViewController {
    override func loadView() {
        super.loadView()
        setDelegate()
        setDesign()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        giveModel()
    }
}

// MARK: - Protocol
extension EditViewController: HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func touchedRightButton(_ sender: UIButton) {
        postModel.description = mainView.editTextView.text
        PostModel.update(request: postModel) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - method
extension EditViewController {
    func setDelegate() {
        headerView.delegate = self
    }
    func setDesign() {
        headerView.setCenter(text: "投稿編集画面")
        headerView.setLeft(text: "戻る")
        headerView.setRight(text: "完了")
    }
    func giveModel() {
        mainView.update(postModel: postModel)
    }
}
