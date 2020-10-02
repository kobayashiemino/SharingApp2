//
//  SearchViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/06.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

struct SearchResult {
    var image: UIImage?
    var text: String
}

class SearchViewController: UIViewController {
    
    private var datas = [SearchResult]()
    private var filterdDatas = [SearchResult]()
    private var noResultFound = false
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .white
        searchBar.tintColor = .systemGray
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        view.addSubview(tableView)
        tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.tableHeaderView = createHeaderView()
        tableView.separatorStyle = .none
        
        setupData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 60))
        let items:[String] = ["ALL", "NORMAL", "SDGs"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.frame = CGRect(x: 10, y: 10, width: headerView.width - 20, height: 40)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColor = .systemGray
        headerView.addSubview(segmentControl)
        return headerView
    }
    
    private func setupData() {
        datas.append(SearchResult(image: UIImage(systemName: "rosette"), text:"あ"))
        datas.append(SearchResult(image: UIImage(systemName: "rosette"), text:"あい"))
        datas.append(SearchResult(image: UIImage(systemName: "rosette"), text:"あいう"))
        datas.append(SearchResult(image: UIImage(systemName: "rosette"), text:"あいうえ"))
        datas.append(SearchResult(image: UIImage(systemName: "rosette"), text:"あいうえお"))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !filterdDatas.isEmpty {
            return filterdDatas.count
        }
        return noResultFound ? 0 : datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as! SearchViewCell
        
        if !filterdDatas.isEmpty {
            cell.didSearch(image: filterdDatas[indexPath.row].image!, text: filterdDatas[indexPath.row].text)
        } else {
            cell.didSearch(image: datas[indexPath.row].image!, text: datas[indexPath.row].text)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController :UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterdDatas.removeAll()
        
        for data in datas {
            if data.text.lowercased().contains(searchText.lowercased()) {
                filterdDatas.append(data)
            } else {
                noResultFound = true
            }
        }
        tableView.reloadData()
    }
}
