//
//  ObjectDetail.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectDetail {
    
    var object: AHObject!
    var objectCategories = [ObjectCategory]()
    
    init(object: AHObject, objectCategories: [ObjectCategory]) {
        self.object             = object
        self.objectCategories   = objectCategories
    }
}