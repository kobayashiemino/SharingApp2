//
//  SelectCategoryView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/13.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol SelectCategoryViewDelegate: AnyObject {
    func selectCategory(text: String)
}

class SelectCategoryView: UIViewController {
    
    private var categories = [String]()
    private var selectedCategory: String?
    
    public var delegate: SelectCategoryViewDelegate?
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SelectCategoryViewCell.self, forCellReuseIdentifier: SelectCategoryViewCell.identifier)
        return tableView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private let addCategoryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .systemPink
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        backgroundView.addSubview(cancelButton)
        backgroundView.addSubview(addCategoryButton)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        addCategoryButton.addTarget(self, action: #selector(disTapAddCategoryButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundView.frame = view.bounds
        tableView.frame = CGRect(x: 0,
                                 y: 50,
                                 width: view.width,
                                 height: view.height - 100)
        
        cancelButton.frame = CGRect(x: view.width - 50,
                                    y: 0,
                                    width: 50,
                                    height: 50)
        addCategoryButton.frame = CGRect(x: (view.width - 50) / 2,
                                         y: view.height - 60,
                                         width: 50,
                                         height: 50)
    }
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func disTapAddCategoryButton() {
        let alert = UIAlertController(title: "Category", message: "add new category", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
            guard let `self` = self else { return }
            guard let text = alert.textFields?.first?.text else { return }
            `self`.categories.append(text)
            `self`.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension SelectCategoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectCategoryViewCell.identifier, for: indexPath) as! SelectCategoryViewCell
        cell.configure(data: categories[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCategory = categories[indexPath.row]
        delegate?.selectCategory(text: selectedCategory)
        
        dismiss(animated: true, completion: nil)
    }
}

extension SelectCategoryView: SelectCategoryViewCellDelegate {
    func didTapRemoveButton(indexpath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexpath], with: .automatic)
        self.categories.remove(at: indexpath.row)
        tableView.endUpdates()
    }
}
