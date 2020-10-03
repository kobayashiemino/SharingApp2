//
//  SwapViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/10/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import Koloda

class SwapViewController: UIViewController {
    
    private var kolodaView: KolodaView = {
        let view = KolodaView()
        return view
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
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        kolodaView.frame = CGRect(x: 20, y: 20, width: view.width - 40, height: view.width)
    }
}

extension SwapViewController: KolodaViewDataSource, KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image:dataSource[index])
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
        print("did select!")
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
