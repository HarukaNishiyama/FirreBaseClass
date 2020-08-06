//
//  HomeViewController.swift
//  FireBaseClass
//
//  Created by haruka on 2020/07/31.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

// MARK: - Property
class HomeViewController: BaseViewController {
    @IBOutlet weak var mainView: HomeMainView!
    @IBOutlet weak var topHeaderView: HeaderView!
    // 取得したデータを格納
    var postModels: [PostModel] = [PostModel]()
}

// MARK: - Life cycle
extension HomeViewController {
    override func loadView() {
        super.loadView()
        setHeaderDelegate()
        setHeaderDesign()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getModel()
    }
}

// MARK: - Protocol
extension HomeViewController: HeaderViewDelegate {
    // 右ボタン
    func touchedRightButton(_ sender: UIButton) {
        // 画面遷移
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
        animatorManager.navigationType = .slide_push
    }
    // 左ボタン
    func touchedLeftButton(_ sender: UIButton) {
        // 戻る
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
        animatorManager.navigationType = .slide_pop
    }
}
extension HomeViewController: HomeMainViewDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        let homeDetailVIewController = HomeDetailViewController()
        navigationController?.pushViewController(homeDetailVIewController, animated: true)
        homeDetailVIewController.postModel = postModels[indexPath.row]
        animatorManager.navigationType = .slide_push
    }
}

// MARK: - method
extension HomeViewController {
    func setHeaderDelegate() {
        topHeaderView.delegate = self
        mainView.delegate = self
    }
    func setHeaderDesign() {
        topHeaderView.setCenter(text: "Home")
        topHeaderView.setRight(text: "投稿")
        topHeaderView.setLeft(text: "編集")
    }
    // 取得したデータをpostModelsに渡す クロージャー
    func getModel() {
        PostModel.reads { (postModels) in
            self.postModels = postModels
            self.giveModel()
        }
    }
    func giveModel() {
        mainView.getModel(postModels: postModels)
    }
}
