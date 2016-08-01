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
        return DBManager.getUser()
    }
}

//MARK: - extension for HomeInteractorInput -
extension HomeInteractor: HomeInteractorInput {
    
    func createUser() {
        if let user = user {
            _ = APIManager.getUser("\(user.id)")
                .subscribe(onNext: { result in
                    if result != nil {
                        let userInfo = UserInfo(data: result["data"])
                        DBManager.updateUser(userInfo)
                        
                        self.output.createUserIsReady(user)
                    }
                })
        } else {
            _ = APIManager.createUser()
                .subscribe(onNext: { result in
                    if result != nil {
                        let user = User(data: result["data"])
                        DBManager.storeUser(user)
                        
                        self.output.createUserIsReady(user)
                    }
                })
        }
    }
    
    func getRestaurantsHome() {
        _ = APIManager.getRestaurantsHome()
            .subscribe(onNext: { result in
                if result != nil {
                    let home = Home(data: result["data"])
                    self.output.homeDataIsReady(home)
                }
            })
    }
    
    func getObject(id: Int) {
        _ = APIManager.getObject("\(id)")
            .subscribe(onNext: { result in
                if result != nil {
                    let object = AHObject(data: result["data"])
                    self.output.objectDataIsReady(object)
                }
            })
    }
}