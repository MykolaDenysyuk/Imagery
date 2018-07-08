//
//  IMGListView.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit


/// General interface for any view that presents list of items
protocol IMGListViewInput {
    func reloadData()
}

extension UITableViewController: IMGListViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}

extension UICollectionViewController: IMGListViewInput {
    func reloadData() {
        collectionView?.reloadData()
    }
}

/// Encapsulate enough methods to fill list view
protocol IMGListViewDatasource {
    associatedtype Element
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at index: IndexPath) -> Element
}

/// All general events produced by list view
protocol IMGListViewOutput: class {
    associatedtype View = IMGListViewInput
    
    /// Called when view is ready to show data
    func viewRequireData(_ view: View)
    /// Called before list view displays item at the given index
    func view(_ view: View, willDisplayItemAt index: IndexPath)
    /// Called when user selects an item at index on the view
    func view(_ view: View, didSelectItemAt index: IndexPath)
}
