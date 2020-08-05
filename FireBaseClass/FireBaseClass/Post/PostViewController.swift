//
//  PostViewController.swift
//  FireBaseClass
//
//  Created by haruka on 2020/07/31.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

// MARK: - Property
class PostViewController: BaseViewController {
    @IBOutlet weak var postHeaderView: HeaderView!
    @IBOutlet weak var postMainVIew: PostMainView!
}

// MARK: - Life cycle
extension PostViewController {
    override func loadView() {
        super.loadView()
        postHeaderView.delegate = self
        setHeader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Protocol
extension PostViewController: HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        animatorManager.navigationType = .slide_pop
    }
    func touchedRightButton(_ sender: UIButton) {
        let postModel = PostModel()
        postModel.description = postMainVIew.photoTextField.text
        
        PostModel.create(request: postModel) {
            self.navigationController?.popViewController(animated: true)
            self.animatorManager.navigationType = .slide_pop
        }
    }
}

// MARK: - method
extension PostViewController {
    func setHeader() {
        postHeaderView.setCenter(text: "新規投稿")
        postHeaderView.setLeft(text: "キャンセル")
        postHeaderView.setRight(text: "投稿")
    }
}
