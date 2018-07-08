//
//  IMGHomePresenter.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

/// Provide data for Home view and handles its events
class IMGHomePresenter {
    
    struct Container {
        let data: IMGContent.Item
        let display: IMGHomeViewDisplayItem
    }
    
    // MARK: Vars
    
    let coordinator: IMGHomeCoordinatorInput
    let imagesCache: IMGImageCacheService
    let contentManager: IMGContentService
    var items = [Container]()
    /// The query that is used to load currently presented content
    var currentQuery = IMGContent.Query.default
    
    // MARK: Initializer
    
    init(coordinator: IMGHomeCoordinatorInput,
         imagesCache: IMGImageCacheService = IMGImageCacheManager(),
         contentManager: IMGContentService = IMGContentManager()) {
        self.coordinator = coordinator
        self.imagesCache = imagesCache
        self.contentManager = contentManager
    }
    
    // MARK: Actions
    
    func load(query: IMGContent.Query = .default, complete: @escaping () -> Void) {
        currentQuery = query
        let _ =
        contentManager.search(query: query) {
            [weak self ] (result) in
            guard let sself = self else { return }
            switch result {
            case .success(let response):
                sself.items = response.hits.compactMap { Container(data: $0)}
                DispatchQueue.main.async(execute: complete)
            case .failure(let error):
                DispatchQueue.main.async {
                    sself.coordinator.showAlert(title: "Oops!", message: error.localizedDescription)
                }
            }
        }
    }
    
}

extension IMGHomePresenter: IMGHomeViewDatasource {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return items.count
    }
    
    func item(at index: IndexPath) -> IMGHomeViewDisplayItem {
        return items[index.item].display
    }
}

extension IMGHomePresenter: IMGHomeViewOutput {
    typealias View = IMGListViewInput & IMGLoadingIndicator
    
    func viewRequireData(_ view: View) {
        view.isLoading = true
        load {
            view.reloadData()
            view.isLoading = false
        }
    }
    
    func view(_ view: View, didSelectItemAt index: IndexPath) {
        coordinator.showDetails(for: items[index.item].data )
    }
    
    func view(_ view: View, willDisplayItemAt index: IndexPath) {
        // TODO: load next page if needed
    }
    
    func view(_ view: View, didSearch text: String?) {
        view.isLoading = true
        let query = IMGContent.Query(search: text, pageSize: nil, page: nil, category: nil, order: nil)
        load(query: query) {
            view.reloadData()
            view.isLoading = false
        }
    }
    
    func viewDidTapFilter(_ view: View) {
        coordinator.showFilter(currentQuery: currentQuery) {
            [weak self, weak view] (newQuery) in
            self?.load(query: newQuery, complete: {
                view?.reloadData()
            })
        }
    }
    
}

extension IMGHomePresenter.Container {
    init?(data: IMGContent.Item) {
        guard let url = URL(string: data.previewURL) else  { return nil }
        self.data = data
        self.display = IMGHomeViewDisplayItem(imageURL: url)
    }
}
