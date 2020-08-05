//
//  HomeMainView.swift
//  FireBaseClass
//
//  Created by haruka on 2020/07/31.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import PGFramework

protocol HomeMainViewDelegate: NSObjectProtocol{
    func didSelectRowAt(indexPath: IndexPath)
}

extension HomeMainViewDelegate {
}

// MARK: - Property
class HomeMainView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: HomeMainViewDelegate? = nil
    var postModels: [PostModel] = [PostModel]()
}

// MARK: - Life cycle
extension HomeMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setDelegate()
        loadTableViewCellFromXib(tableView: tableView, cellName: HomeMainViewCell.className)
    }
}

// MARK: - Protocol
extension HomeMainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeMainViewCell.className, for: indexPath) as? HomeMainViewCell else {
            return UITableViewCell()
        }
        cell.updateCell(postModel: postModels[indexPath.row])
        return cell
    }
}
extension HomeMainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectRowAt(indexPath: indexPath)
        }
    }
}
// MARK: - method
extension HomeMainView {
    func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func getModel(postModels: [PostModel]) {
        self.postModels = postModels
        tableView.reloadData()
    }
}
