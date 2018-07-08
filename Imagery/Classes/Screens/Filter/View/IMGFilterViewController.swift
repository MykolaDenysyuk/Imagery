//
//  IMGFilterViewController.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

/// The main controller of Filter module.
/// It presents filtering categories and their current values
class IMGFilterViewController<Datasource, EventsHandler>: UITableViewController
where
    Datasource: IMGListViewDatasource, Datasource.Element == IMGFileCategoryItem,
    EventsHandler: IMGFilterViewOutput
{

    // MARK: Vars
    
    let datasource: Datasource
    let eventsHandler: EventsHandler
    private var isDataRequested = false
    
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
        tableView.rowHeight = 60
        setupTopBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isDataRequested {
            isDataRequested = true
            eventsHandler.viewRequireData(self)
        }
    }
    
    // MARK: Actions
    
    func setupTopBar() {
        title = "Filter"
        let cancel
            = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(cancelAction))
        let apply
            = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(applyAction))
        
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = apply
    }
    
    @objc func cancelAction() {
        eventsHandler.cancelAction()
    }
    
    @objc func applyAction() {
        eventsHandler.applyAction()
    }
    
    // MARK: Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.numberOfItems(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell"
        
        let cell: UITableViewCell = {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
                return cell
            }
            else {
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
                cell.textLabel?.font = .imgBoldText(size: 18)
                cell.textLabel?.textColor = .darkGray
                cell.detailTextLabel?.font = .imgRegularText(size: 17)
                cell.detailTextLabel?.textColor = .darkGray
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .gray
                return cell
            }
        }()
        
        let row = datasource.item(at: indexPath)
        
        cell.textLabel?.text = row.name
        cell.detailTextLabel?.text = row.value
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventsHandler.view(self, didSelectItemAt: indexPath)
    }
}
