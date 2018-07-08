//
//  IMGReusable.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

/** Describes type of item that can be cached by its reuseIdentifier and reused later */
protocol IMGReusable: class {
    static var reuseIdentifier: String { get }
}

// default reuseIdentifier is type name
extension IMGReusable {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

// Adding support of IMGReusable to most common UI classes

extension UITableViewCell: IMGReusable {}
extension UITableViewHeaderFooterView: IMGReusable {}

extension UITableView {
    func registerReusableView<T>(_ type: T.Type) where T: IMGReusable {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerReusableNib<T>(_ type: T.Type) where T: IMGReusable {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func retrieveReusableItem<T>() -> T where T: IMGReusable {
        if let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T {
            return cell
        }
        fatalError("reusable item of type \(T.self) was not registered with a tableView: \(self)")
    }
    
    func retrieveReusableItem<T>(for indexPath: IndexPath) -> T where T: IMGReusable {
        if let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T {
            return cell
        }
        fatalError("reusable item of type \(T.self) was not registered with a tableView: \(self)")
    }
    
    func registerReusableAccessoryView<T>(_ type: T.Type) where T: IMGReusable {
        register(type, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerReusableAccessoryNib<T>(_ type: T.Type) where T: IMGReusable {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    func retieveReuableAccessoryView<T>() -> T where T: IMGReusable {
        if let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T {
            return view
        }
        fatalError("reusable item of type \(T.self) was not registered with a tableView: \(self)")
    }
}

extension UICollectionReusableView: IMGReusable {}

extension UICollectionView {
    func registerReusableView<T>(_ type: T.Type) where T: IMGReusable {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerReusableNib<T>(_ type: T.Type) where T: IMGReusable {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func retrieveReusableItem<T>(for indexPath: IndexPath) -> T where T: IMGReusable {
        if let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T {
            return cell
        }
        fatalError("reusable item of type \(T.self) was not registered with a collectionView: \(self)")
    }
    
    func registerReusableSupNib<T>(_ type: T.Type, kind: String = UICollectionElementKindSectionHeader) where T: IMGReusable {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
    }
    
    func retieveReusableSupItem<T>(for indexPath: IndexPath, kind: String = UICollectionElementKindSectionHeader) -> T where T: IMGReusable {
        if let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T {
            return view
        }
        fatalError("reusable item of type \(T.self) was not registered with a tableView: \(self)")
    }
}
