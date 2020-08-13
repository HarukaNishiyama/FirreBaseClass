//
//  PostModel.swift
//  FireBaseClass
//
//  Created by haruka on 2020/08/03.
//  Copyright © 2020 testAPP-team. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class PostModel {
    fileprivate static let PATH: String = "post"
    var id: String = String()
    var image_paths: String? //投稿画像のパス
    var description: String? //投稿文
}

extension PostModel {
    // モデル型を辞書型に変更する関数
    static func setParameter(request: PostModel) -> [String: Any] {
        var parameter: [String: Any] = [:]
        parameter["id"] = request.id
        parameter["image_paths"] = request.image_paths
        parameter["description"] = request.description
        return parameter
    }
    // 辞書型をモデル型に変更する関数
    static func parse(data: [String: Any]) -> PostModel {
        let model: PostModel = PostModel()
        if let id = data["id"] as? String {model.id = id}
        if let image_paths = data["image_paths"] as? String {model.image_paths = image_paths}
        if let description = data["description"] as? String {model.description = description}
        return model
    }
}

// @escaping → クロージャーを外でも使える
// dbRefを作成・読み込み・更新・削除する処理

//MARK: - Create
extension PostModel {
//    static func create(request: PostModel, success:@escaping () -> Void) {
//        let dbRef = Database.database().reference().child(PATH).childByAutoId()
//        if let key = dbRef.key {
//            request.id = key
//        }
//        let paramerter = setParameter(request: request)
//        dbRef.setValue(paramerter)
//        success()
//    }
    static func create(request: PostModel, images: [UIImage]?=nil, success:@escaping () -> Void) {
        let dbRef = Database.database().reference().child(PATH).childByAutoId()
        if let key = dbRef.key {
            request.id = key
        }
        var paramerter = setParameter(request: request)
        if let images = images {
            uploadPhoto(photoName: request.id, image: images, success: { (downloadPath) in
                paramerter["image_paths"] = downloadPath
                dbRef.setValue(paramerter)
                success()
            }) {
                print("写真アップロードエラー")
            }
        } else {
            dbRef.setValue(paramerter)
            success()
        }
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
    static func readAt(id: String, success:@escaping (PostModel) -> Void, failure: @escaping () -> Void) {
        let dbRef = Database.database().reference().child(PATH).child(id)
        dbRef.observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else {
                failure()
                return
            }
            let model: PostModel = parse(data: data)
            success(model)
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
    static func delete(id: String, success:@escaping () -> Void) {
        let dbRef = Database.database().reference().child(PATH).child(id)
        dbRef.removeValue { (error, dbRef) in
            if error != nil {
                print("Deleteエラー", error)
            } else {
                success()
            }
        }
    }
}

// MARK: - Photo
extension PostModel {
    static func uploadPhoto(photoName: String, image: [UIImage]?, success: @escaping ([String]) -> Void, failure: @escaping () -> Void) -> Void{
        let group = DispatchGroup()
        let queue = DispatchQueue(label: ".photo")
        guard let images = image else {return}
        var num = 1
        var paths: [String] = []
        images.forEach { (image) in
            group.enter()
            queue.async {
                guard let data = image.jpegData(compressionQuality: 0.05), data.count < 4000000 else {
                    group.leave()
                    return failure()
                }
                let fileRef = Storage.storage().reference().child("images/" + photoName + num.description)
                num += 1
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                fileRef.putData(data, metadata: metaData) { (meta, error) in
                    fileRef.downloadURL { (url, error) in
                        if let _ = error {
                            return
                        } else {
                            paths.append(url?.description ?? "")
                            group.leave()
                        }
                    }
                }
            }
        }
        group.notify(queue: .main) {
            success(paths)
        }
    }
}
