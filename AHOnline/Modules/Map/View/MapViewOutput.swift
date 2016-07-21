//
//  MapViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol MapViewOutput: DidSelectObjectProtocol, PresentViewControllerProtocol {

    func viewIsReady()
    func getNearestObjects(json: JSON)
}
