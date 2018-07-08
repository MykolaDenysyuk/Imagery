//
//  IMGFilterCoordinator.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

struct IMGFilterCoordinatorData {
    let query: IMGContent.Query
    let callback: (IMGContent.Query) -> Void
}

class IMGFilterCoordinator: IMGCoordinator, IMGFilterCoordinatorInput {

    // MARK: Vars
    
    weak var rootController: UIViewController?
    var data: IMGFilterCoordinatorData?
    
    // MARK: Actions
    
    func start(from presenting: UIViewController, with data: IMGFilterCoordinatorData) {
        self.data = data
        let presenter = IMGFilterPresenter(coordinator: self, lastQuery: data.query)
        let controller = IMGFilterViewController(datasource: presenter, eventsHandler: presenter)
        
        presenting.show(controller, sender: nil)
        rootController = controller
    }
    
    func close(newParameters: IMGContent.Query?) {
        let root = rootControllerOrFail()
        
        if let query = newParameters {
            data?.callback(query)
        }
        
        if let navigation = root.navigationController {
            navigation.popViewController(animated: true)
        }
        else {
            root.dismiss(animated: true, completion: nil)
        }
    }
    
    func showOptions(_ list: [String], lastSelected: Int?, complete: @escaping (Int) -> Void) {
        let optionsController = IMGFilterOptionsViewController(list: list, selected: lastSelected, complete: complete)
        rootControllerOrFail().show(optionsController, sender: nil)
    }
    
    
}

