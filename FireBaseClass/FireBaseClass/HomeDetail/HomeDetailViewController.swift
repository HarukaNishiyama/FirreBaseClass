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
}

// MARK: - Life cycle
extension HomeDetailViewController {
    override func loadView() {
        super.loadView()
        setDelegate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Protocol
extension HomeDetailViewController: HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        animatorManager.navigationType = .slide_push
    }
}

// MARK: - method
extension HomeDetailViewController {
    func setDelegate() {
        headerView.delegate = self
    }
    func setHeaderDesign() {
        headerView.setLeft(text: "戻る")
        headerView.setRight(text: "詳細画面")
    }
}
