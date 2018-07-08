//
//  IMGDetailsViewController.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGDetailsViewController<Datasource, EventsHandler>: UITableViewController
where
    Datasource: IMGDetailsViewDatasource,
    EventsHandler: IMGDetailsViewOutput {
    
    // MARK: Vars
    
    let datasource: Datasource
    unowned let eventsHandler: EventsHandler
    var isDataRequsted = false
    
    // MARK: Initializer
    
    init(datasource: Datasource, eventsHandler: EventsHandler) {
        self.datasource = datasource
        self.eventsHandler = eventsHandler
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonAction))
        navigationItem.rightBarButtonItem = share
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isDataRequsted {
            isDataRequsted = true
            eventsHandler.viewRequireData(self)
            title = datasource.title
        }
    }
    
    // MARK: Actions
    
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        
        tableView.registerReusableNib(IMGDetailsTopCell.self)
        tableView.registerReusableNib(IMGDetailsInfoCell.self)
        tableView.registerReusableNib(IMGDetailsControlCell.self)
    }
    
    @objc func shareButtonAction() {
        eventsHandler.viewDidTapShare(self)
    }
    
    
    // MARK: Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.numberOfItems(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource.item(at: indexPath)
        
        switch item {
            
        case .header(let data):
            let cell: IMGDetailsTopCell = tableView.retrieveReusableItem()
            cell.setup(with: data, imageCache: datasource.imagesCache)
            return cell
        case .details(let data):
            let cell: IMGDetailsInfoCell = tableView.retrieveReusableItem()
            cell.setup(with: data)
            return cell
        case .action(let title):
            let cell: IMGDetailsControlCell = tableView.retrieveReusableItem()
            cell.setup(with: title)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventsHandler.view(self, didSelectItemAt: indexPath)
    }
}
