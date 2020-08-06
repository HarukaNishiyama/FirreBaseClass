//
//  HomeDetailViewController.swift
//  FireBaseClass
//
//  Created by haruka on 2020/08/05.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

// MARK: - Property
class HomeDetailViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var mainView: HomeDetailMainView!
    var postModel: PostModel = PostModel()
}

// MARK: - Life cycle
extension HomeDetailViewController {
    override func loadView() {
        super.loadView()
        setDelegate()
        setHeaderDesign()
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
extension HomeDetailViewController: HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        animatorManager.navigationType = .slide_pop
    }
    func touchedRightButton(_ sender: UIButton) {
        let editViewController = EditViewController()
        editViewController.postModel = postModel
        editViewController.modalPresentationStyle = .fullScreen
        present(editViewController, animated: true, completion: nil)
    }
}

// MARK: - method
extension HomeDetailViewController {
    func setDelegate() {
        headerView.delegate = self
    }
    func setHeaderDesign() {
        headerView.setLeft(text: "戻る")
        headerView.setCenter(text: "投稿詳細")
        headerView.setRight(text: "編集")
    }
    func giveModel() {
        mainView.getModel(postModel: postModel)
    }
}
