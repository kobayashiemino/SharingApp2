//
//  MyPageCategoryReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import PinterestSegment

protocol MyPageCategoryReusableViewDelegate: AnyObject {
    func didTapCategoryCell(category: String)
}

class MyPageCategoryReusableView: UICollectionReusableView {
    
    static let identifier = "MyPageCategoryReusableView"
    
    private var categories = [Post]()
    
    weak var delegate: MyPageCategoryReusableViewDelegate?
    
    private let myPageProfileReusableView = MyPageProfileReusableView()
    
    private let segmentControl: PinterestSegment = {
        var segmentControl =  PinterestSegment()
        var style = PinterestSegmentStyle()
        style.indicatorColor = .white
        style.titleMargin = 15
        style.titlePendingVertical = 14
        style.titlePendingHorizontal = 14
        style.titleFont = UIFont.systemFont(ofSize: 14)
        style.normalTitleColor = .white
        segmentControl = PinterestSegment(frame: .zero,
                                          segmentStyle: style,
                                          titles: [])
        return segmentControl
    }()
    
    private var segmentTitles = [PinterestSegment.TitleElement]()
    private var posts = [Post]()
    private var sortedPosts = [Post]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        myPageProfileReusableView.colorDelegate = self

        addSubview(segmentControl)
        fetchPosts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentControl.frame = bounds
    }
    
    private func fetchPosts() {
        self.segmentTitles = []
        DatabaseManeger.shared.getPostData { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let data):
                guard let postInfos = data as? [String: Any] else { return }
                postInfos.forEach { (key, value) in
                    guard let dictionary = value as? [String: Any] else { return }
                    let post = Post(dictionary: dictionary)
                    `self`.posts.append(post)
                }
                
                `self`.sortedPosts = `self`.posts.sorted {$0.uploadedDate > $1.uploadedDate}
                for sortedPost in `self`.sortedPosts {
                    `self`.segmentTitles.append(PinterestSegment.TitleElement(title: sortedPost.category))
                }
                
                DispatchQueue.main.async {
                    `self`.segmentControl.setRichTextTitles(`self`.segmentTitles)
                    `self`.segmentControl.valueChange = { index in
                        let selectedIndex = `self`.sortedPosts[index]
                        let selectedCategory = selectedIndex.category
                        `self`.delegate?.didTapCategoryCell(category: selectedCategory)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
//    
//    public func reloadData() {
//        fetchPosts()
//    }
}

extension MyPageCategoryReusableView: MyPageProfileReusableViewColorDelegate {
    func setColor(color: UIColor) {
        backgroundColor = color
        segmentControl.selectedTitleColor = color
    }
}
