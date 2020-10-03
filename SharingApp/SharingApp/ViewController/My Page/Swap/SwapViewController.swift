//
//  SwapViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/10/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import Koloda
import CCZoomTransition

class SwapViewController: UIViewController {
    
    private var kolodaView: KolodaView = {
        let view = KolodaView()
        return view
    }()
    
    private let discardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.tintColor = .lightGray
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.tintColor = .lightGray
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private var numberOfCards = 5
    
    private lazy var dataSource: [UIImage] = {
        var array:[UIImage] = []
        for index in 0 ..< numberOfCards {
            array.append(UIImage(named: "\(index + 1)")!)
        }
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(kolodaView)
        view.addSubview(discardButton)
        view.addSubview(saveButton)
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        discardButton.addTarget(self, action: #selector(didTapDisCardButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        kolodaView.frame = CGRect(x: 10, y: 0, width: view.width - 20, height: view.width + 100)
        kolodaView.center.y = (view.height - 62) / 2
        
        let width = (view.width - 40)/2
        discardButton.frame = CGRect(x: 10, y: view.height - 62, width: width, height: 52)
        saveButton.frame = CGRect(x: view.width - (width + 10), y: view.height - 62, width: width, height: 52)
    }
    
    @objc private func didTapDisCardButton() {
        
    }
    
    @objc private func didTapSaveButton() {
        
    }
    
    var swapView = SwapView()
}

extension SwapViewController: KolodaViewDataSource, KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let swapView = SwapView()
        swapView.itemImageView.image = dataSource[index]
        self.swapView = swapView
        if index >= 2 {
            self.swapView.itemImageView.image = dataSource[index - 2]
        }
        print("viewForCardAt\(index)")
        return swapView
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool {
        return true
    }
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        print("did swip!")
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let vc = ProductDetailViewController(index: index)
        vc.cc_setZoomTransition(originalView: self.swapView.itemImageView)
        self.present(vc, animated: false, completion: nil)
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = kolodaView.currentCardIndex
        print("currentIndex\(kolodaView.currentCardIndex)")
        for i in 1 ... 5 {
            dataSource.append(UIImage(named: "\(i)")!)
        }
        kolodaView.insertCardAtIndexRange(position ..< position + 5, animated: true)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
}
