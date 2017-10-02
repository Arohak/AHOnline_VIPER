//
//  HomeInteractor.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HomeInteractor -
class HomeInteractor {

    weak var output: HomeInteractorOutput!
    
    var user: User? {
        return DBHelper.getUser()
    }
}

//MARK: - extension for HomeInteractorInput -
extension HomeInteractor: HomeInteractorInput {
    
    func createUser() {
        if let user = user {
            _ = UserEndpoint.getUser("\(user.id)")
                .subscribe(onNext: { result in
                    if let result = result {
                        let userInfo = UserInfo(data: result["data"])
                        DBHelper.updateUser(userInfo: userInfo)
                        
                        self.output.createUserIsReady(user: user)
                    }
                })
        } else {
            _ = UserEndpoint.createUser()
                .subscribe(onNext: { result in
                    if let result = result {
                        let user = User(data: result["data"])
                        DBHelper.storeUser(user: user)
                        
                        self.output.createUserIsReady(user: user)
                    }
                })
        }
    }
    
    func getRestaurantsHome() {
        _ = MainEndpoint.getFeeds(false)
            .subscribe(onNext: { result in
                if let result = result {
                    let home = Home(data: result["data"])
                    self.output.homeDataIsReady(home: home)
                }
            })
    }
    
    func getObject(id: Int) {
        _ = ObjectEndpoint.getObject("\(id)")
            .subscribe(onNext: { result in
                if let result = result {
                    let object = AHObject(data: result["data"])
                    self.output.objectDataIsReady(object: object)
                }
            })
    }
}
