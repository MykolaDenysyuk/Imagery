//
//  IMGDetailsPresenter.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

class IMGDetailsPresenter {
    
    // MARK: Vars
    
    let coordinator: IMGDetailsCoordinatorInput
    let item: IMGContent.Item
    let imagesCache: IMGImageCacheService
    var rows = [IMGDetailsViewRowType]()
    
    // MARK: Initializer
    
    init(coordinator: IMGDetailsCoordinatorInput,
         details: IMGContent.Item,
         imagesCache: IMGImageCacheService = IMGImageCacheManager()) {
        self.coordinator = coordinator
        self.item = details
        self.imagesCache = imagesCache
    }
    
    // MARK: Actions
    
    func prepareData() {
        rows.removeAll()
        
        let header = IMGDetailsViewRowType.Header(previewImagePath: URL(string: item.previewURL),
                                                  imagePath: URL(string: item.largeImageURL),
                                                  userImageUrl: URL(string: item.userImageURL),
                                                  user: item.user)
        rows.append(.header(header))
        
        let details = IMGDetailsViewRowType.Details(likes: "\(item.likes)",
                                                    favorites: "\(item.favorites)",
                                                    downloads: "\(item.downloads)",
                                                    tags: item.tags)
        rows.append(.details(details))
        
        rows.append(.action("Open in Browser"))
    }
}

extension IMGDetailsPresenter: IMGDetailsViewDatasource {
    var title: String {
        return item.user
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return rows.count
    }
    
    func item(at index: IndexPath) -> IMGDetailsViewRowType {
        return rows[index.row]
    }
}

extension IMGDetailsPresenter: IMGDetailsViewOutput {
    typealias View = IMGListViewInput
    
    func viewDidTapShare(_ view: View) {
        if let url = URL(string: item.pageURL) {
            coordinator.showExport(url: url)
        }
        else {
            coordinator.showAlert(title: "Oops!", message: "Page can't be opened - \(item.pageURL)")
        }
    }
    
    func viewRequireData(_ view: View) {
        prepareData()
        view.reloadData()
    }
    
    func view(_ view: View, willDisplayItemAt index: IndexPath) {}
    
    func view(_ view: View, didSelectItemAt index: IndexPath) {
        let row = self.item(at: index)
        
        switch row {
        case .action:
            if let url = URL(string: item.pageURL) {
                coordinator.openInBrowser(url: url)
            }
            else {
                coordinator.showAlert(title: "Oops!", message: "Page can't be opened - \(item.pageURL)")
            }
        default:
            break
        }
    }
    
    
}
