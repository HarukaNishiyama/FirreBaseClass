//
//  PostModel.swift
//  FireBaseClass
//
//  Created by haruka on 2020/08/03.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PostModel {
    fileprivate static let PATH: String = "post"
    var id: String = String()
    var image_path: String? //投稿画像のパス
    var description: String? //投稿文
}

extension PostModel {
    // モデル型を辞書型に変更する関数
    static func setParameter(request: PostModel) -> [String: Any] {
        var parameter: [String: Any] = [:]
        parameter["id"] = request.id
        parameter["image_path"] = request.image_path
        parameter["description"] = request.description
        return parameter
    }
    // 辞書型をモデル型に変更する関数
    static func parse(data: [String: Any]) -> PostModel {
        let model: PostModel = PostModel()
        if let id = data["id"] as? String {model.id = id}
        if let image_path = data["image_path"] as? String {model.image_path = image_path}
        if let description = data["description"] as? String {model.description = description}
        return model
    }
}

// @escaping → クロージャーを外でも使える

//MARK: - Create
extension PostModel {
    static func create(request: PostModel, success:@escaping () -> Void) {
        let dbRef = Database.database().reference().child(PATH).childByAutoId()
        if let key = dbRef.key {
            request.id = key
        }
        let paramerter = setParameter(request: request)
        dbRef.setValue(paramerter)
        success()
    }
}

//MARK: - Read
extension PostModel {
    static func reads(success: @escaping ([PostModel]) -> Void) {
        // インスタンス生成
        let dbRef = Database.database().reference().child(PATH)
        dbRef.observe(.value) { (snapshot) in
            var models: [PostModel] = [PostModel]()
            // スナップショットをitemに入れていく
            for item in (snapshot.children) {
                let snapshot = item as! DataSnapshot
                let data = snapshot.value as! [String: Any]
                let model: PostModel = parse(data: data)
                models.append(model)
            }
            success(models)
        }
    }
}

//MARK: - Update
extension PostModel {
    static func update(request: PostModel, success:@escaping () -> Void) {
        let id = request.id
        let dbRef = Database.database().reference().child(PATH).child(id)
        let parameter = setParameter(request: request)
        dbRef.updateChildValues(parameter) { (error, dbRef) in
            if error != nil {
                print("updateエラー：", error)
            } else {
                success()
            }
        }
    }
}

//MARK: - Delete
extension PostModel {
    
}
