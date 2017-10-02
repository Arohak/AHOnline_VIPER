//
//  FirebaseHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//import Firebase
//import FirebaseAuth
//import SwiftyJSON
//
//typealias CompletionBlockRadios = (_ radios: Array<RadioCollectionCellModelType>) -> Void
//typealias CompletionBlockRadio = (_ radio: RadioCollectionCellModelType) -> Void
//
struct FirebaseHelper {

//    static var ref: DatabaseReference!

    static let email       = Config.getFirebaseEmail()    // "radio@imusic.am"
    static let password    = Config.getFirebasePassword() // "Barev123"
    static let im_radio    = Config.getFirebaseRadio()    // "im-radio"

    static func configurate() {
//        FirebaseApp.configure()
//        ref = Database.database().reference()
    }
//
//    //MARK: - Radios -
//    static func observeRadios(completionBlock: @escaping CompletionBlockRadios) {
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//            if let _ = user {
//                self.ref.child(self.im_radio).observe(.value, with: { snapshot in
//                    let value = snapshot.value
//                    if let value = value {
//                        print(value)
//                        
//                        var temp = Array<RadioCollectionCellModelType>()
//                        for (i, item) in JSON(value).arrayValue.enumerated() {
//                            if i != 0 {
//                                let id      = item["radioId"].intValue
//                                let trackId = item["id"].intValue
//                                let artist  = item["artists"]["main"].arrayValue.first!["artist"].stringValue
//                                let title   = item["title"].stringValue
//                                let evantModel = RadioCollectionCellModel(id, trackId, artist, title)
//                                temp.append(evantModel)
//                            }
//                        }
//                        
//                        completionBlock(temp)
//                    }
//                })
//            }
//        }
//    }
}
