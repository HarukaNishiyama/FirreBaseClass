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
    weak var delegate: HomeDetailMainViewDelegate? = nil
}

// MARK: - Life cycle
extension HomeDetailMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Protocol
extension HomeDetailMainView {
}

// MARK: - method
extension HomeDetailMainView {
}
