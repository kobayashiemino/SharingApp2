//
//  SideMenuTableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol SideMenuTableViewDelegate: AnyObject {
    func didSelectMenuItem(menuItem: String)
}

class SideMenuTableView: UITableViewController {
    
    private var menuItems: [String]
    private let cellId = "cellId"
    public weak var delegate: SideMenuTableViewDelegate?

    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: SideMenuCell.identifier)
        tableView.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as! SideMenuCell
        cell.categoryLabel.text = menuItems[indexPath.row]
        if indexPath.row == 0 {
            cell.categoryLabel.textAlignment = .center
            cell.cancelButton.isHidden = true
        }
        cell.cancelButton.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
        cell.cancelButton.indexPath = indexPath
        return cell
    }
    
    @objc private func didTapCancelButton(_ sender: CustomButton) {
        
        guard let indexPath = sender.indexPath else { return }
        tableView.beginUpdates()
        self.menuItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            let alert = UIAlertController(title: "new category",
                                          message: "add your new category",
                                          preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { (_) in
                                            guard let textField = alert.textFields?.first?.text else { return }
                                            self.menuItems.insert(textField, at: 1)
                                            self.tableView.beginUpdates()
                                            self.tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                                            self.tableView.endUpdates()
            }))
            alert.addAction(UIAlertAction(title: "cancel",
                                          style: .cancel,
                                          handler: nil))
            present(alert, animated: true, completion: nil)
            
        } else {
            
            let selectedItem = menuItems[indexPath.row]
            delegate?.didSelectMenuItem(menuItem: selectedItem)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.menuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
