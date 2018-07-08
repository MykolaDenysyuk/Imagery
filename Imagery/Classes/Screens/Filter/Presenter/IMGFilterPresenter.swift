//
//  IMGFilterPresenter.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation


class IMGFilterPresenter {
    
    enum Properties {
        case category, order
    }
    
    struct Container {
        let type: Properties
        var display: IMGFileCategoryItem
    }
    
    // MARK: Vars
    
    let coordinator: IMGFilterCoordinatorInput
    let lastQuery: IMGContent.Query
    var rows = [Container]()
    let defaultOrder = "popular"
    
    // MARK: Initializer
    
    init(coordinator: IMGFilterCoordinatorInput, lastQuery: IMGContent.Query) {
        self.coordinator = coordinator
        self.lastQuery = lastQuery
    }
    
    // MARK: Actions
    
    func prepareData() {
        let categories
            = Container(type: .category,
                        display: IMGFileCategoryItem(name: "Category", value: lastQuery.category ?? ""))
        let order
            = Container(type: .order,
                        display: IMGFileCategoryItem(name: "Order", value: lastQuery.order ?? defaultOrder))
        
        rows = [categories, order]
    }
    
    func availbleCategories() -> [String] {
        return "fashion, nature, backgrounds, science, education, people, feelings, religion, health, places, animals, industry, food, computer, sports, transportation, travel, buildings, business, music".components(separatedBy: ", ")
    }
    
    func availableOrders() -> [String] {
        return ["popular", "latest"]
    }
}

extension IMGFilterPresenter: IMGListViewDatasource {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return rows.count
    }
    
    func item(at index: IndexPath) -> IMGFileCategoryItem {
        return rows[index.row].display
    }
}

extension IMGFilterPresenter: IMGFilterViewOutput {
    func viewRequireData(_ view: IMGListViewInput) {
        prepareData()
        view.reloadData()
    }
    
    func view(_ view: IMGListViewInput, willDisplayItemAt index: IndexPath) {}
    
    func view(_ view: IMGListViewInput, didSelectItemAt index: IndexPath) {
        var row = rows[index.row]
        
        func showOptions(_ list: [String]) {
            let selected = list.index(of: row.display.value)
            coordinator.showOptions(list, lastSelected: selected) { (newIndex) in
                row.display.value = list[newIndex]
                self.rows[index.row] = row
                view.reloadData()
            }
        }
        
        switch row.type {
        case .category:
            showOptions(availbleCategories())
        case .order:
            showOptions(availableOrders())

        }
    }
    
    func cancelAction() {
        coordinator.close(newParameters: nil)
    }
    
    func applyAction() {
        let converter = FilterQuery(defaultOrder: defaultOrder, query: lastQuery)
        coordinator.close(newParameters: converter.merge(with: rows))
    }
}

extension IMGFilterPresenter {
    
    /// Merges current filter options with a given query
    struct FilterQuery {
        
        let defaultOrder: String
        let query: IMGContent.Query
        
        func merge(with rows: [Container]) -> IMGContent.Query {
            var newQuery = query
            for r in rows {
                switch r.type {
                case .category:
                    newQuery.category = r.display.value
                case .order:
                    newQuery.order = r.display.value == defaultOrder ? nil : r.display.value
                }
            }
            return newQuery
        }
    }
}
