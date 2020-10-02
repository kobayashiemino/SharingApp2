//
//  SuggestViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/27.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class SuggestViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SuggestTableViewCell.self, forCellReuseIdentifier: SuggestTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        print("view.bounds\(view.bounds)")
    }
}

extension SuggestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestTableViewCell.identifier, for: indexPath) as! SuggestTableViewCell
        
        let suggestTest = Suggest(dictionary: ["title": "テスト", "detail": "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト"])
        cell.configure(suggest: suggestTest)
        return cell
    }
}
