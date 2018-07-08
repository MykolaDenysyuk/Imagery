//
//  IMGHomeViewController.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGHomeViewController<Datasource, EventsHandler>: UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout, IMGLoadingIndicator
where
    Datasource: IMGHomeViewDatasource,
EventsHandler: IMGHomeViewOutput{
    
    // MARK: Vars
    
    let itemRatio: CGFloat = 3/4
    let datasource: Datasource
    unowned let eventsHandler: EventsHandler
    private var isDataRequested = false
    /// indicates when any loading in progress
    lazy var loadingOverlay = IMGHomeLoadingOverlay()
    var isLoading: Bool = false {
        didSet {
            loadingOverlay.isLoading = isLoading
            if isLoading {
                loadingOverlay.frame = view.frame
                view.addSubview(loadingOverlay)
            }
            else {
                loadingOverlay.removeFromSuperview()
            }
        }
    }
    
    // MARK: Initializer
    
    init(datasource: Datasource, eventsHandler: EventsHandler) {
        self.datasource = datasource
        self.eventsHandler = eventsHandler
        
        // setup collection view
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(collectionViewLayout: layout)
        
        collectionView?.registerReusableNib(IMGHomeItemCell.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isDataRequested {
            isDataRequested = true
            eventsHandler.viewRequireData(self)
        }
    }
    
    // MARK: Actions
    
    func setupTopView() {
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterButtonAction))
        navigationItem.rightBarButtonItem = filterButton
        
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.delegate = self
        navigationItem.titleView = search
    }
    
    @objc func filterButtonAction() {
        eventsHandler.viewDidTapFilter(self)
    }
    
    // MARK: Collection view
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let desiredWidth = collectionView.frame.width / 2
        let desiredHeight = desiredWidth * itemRatio
        return CGSize(width: desiredWidth, height: desiredHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = datasource.item(at: indexPath)
        let cell: IMGHomeItemCell = collectionView.retrieveReusableItem(for: indexPath)
        cell.setup(item: item, imagesCache: datasource.imagesCache)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        eventsHandler.view(self, willDisplayItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventsHandler.view(self, didSelectItemAt: indexPath)
    }

    // MARK: Search bar
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        eventsHandler.view(self, didSearch: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        eventsHandler.view(self, didSearch: searchBar.text)
    }
}
