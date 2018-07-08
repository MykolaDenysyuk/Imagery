//
//  IMGFilterOptionsViewController.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

/// Represents list of options for filter's category
/// NOTE:
/// To follow general architectural solution this controller has to have
/// its own Presenter. But for sake of simplicty the controller is left to
/// handle events by its own
class IMGFilterOptionsViewController: UITableViewController {


    // MARK: Vars
    
    let list: [String]
    private var selected: Int?
    let complete: (Int) -> Void
    
    // MARK: Initializer
    
    
    /// Initialize options controller
    ///
    /// - Parameters:
    ///   - list: list of options
    ///   - selected: current selected option
    ///   - complete: closure is called when any value is selected
    init(list: [String], selected: Int?, complete: @escaping (Int) -> Void) {
        self.list = list
        self.selected = selected
        self.complete = complete
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem = cancel
    }
    
    // MARK: Actions
    
    @objc func cancelAction() {
        close()
    }
    
    func close() {
        if let navigation = self.navigationController {
            navigationController?.popViewController(animated: true)
        }
        else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Table
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell"
        
        let cell: UITableViewCell = {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
                return cell
            }
            else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
                cell.textLabel?.font = UIFont.imgRegularText(size: 18)
                cell.textLabel?.textColor = .darkGray
                cell.tintColor = .darkGray
                return cell
            }
        }()
        
        let title = list[indexPath.row]
        cell.textLabel?.text = title
        cell.accessoryType = indexPath.row == selected ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        complete(indexPath.row)
        close()
    }
}
