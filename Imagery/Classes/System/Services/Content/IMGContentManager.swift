//
//  IMGContentManager.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGContentManager: IMGContentService {
    
    // MARK: Vars
    
    let path = "https://pixabay.com/api/"
    let apiKey = "9492559-625668cdcc00d87f92fb7a635"
    let network: IMGNetworkService
    let requestFactory = RequestFactory()
    let responseHandler = ResponseHandler()
    
    // MARK: Vars
    
    init(network: IMGNetworkService = IMGNetworkManager()) {
        self.network = network
    }
    
    // MARK: Actions
    
    func search(query: IMGContent.Query,
                onComplete: @escaping IMGContentCompletion) -> IMGCancelable? {
        let parameters = requestFactory.createQueryParameters(apiKey: apiKey,
                                                                query: query)
        return network.get(from: path, parameters: parameters) {
            [weak self] result in
            guard let sself = self else { return }
            onComplete(sself.responseHandler.handle(response: result))
        }
    }
    
    
}
