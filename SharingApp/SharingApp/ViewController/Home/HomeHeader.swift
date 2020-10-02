//
//  SideMenuTableViewHeaderCollectionReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/04.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import PinterestSegment

protocol HomeHeaderDelegate: AnyObject {
    func didTapCategoryCell(category: String)
}

class HomeHeader: UICollectionReusableView {
    
    static let identifier = "SideMenuTableViewHeader"
    
    private var segmentTitles = [PinterestSegment.TitleElement]()
    private var posts = [Post]()
    private var sortedPosts = [Post]()
    
    public var delegate: HomeHeaderDelegate?
    
    private let pinterestSegment: PinterestSegment = {
        var style = PinterestSegmentStyle()
        style.indicatorColor = .lightGray
        style.titlePendingHorizontal = 14
        style.titlePendingVertical = 14
        style.titleMargin = 15
        style.selectedTitleColor = .white
        style.normalTitleColor = .lightGray
        let segmentControl = PinterestSegment(frame: .zero,
                                              segmentStyle: style,
                                              titles: [])
        return segmentControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pinterestSegment)
    }
    
    override func layoutSubviews() {
        
        let segWidth = width - 6
        pinterestSegment.frame = CGRect(x: (width - segWidth) / 2 ,
                                      y: (height - 50) / 2,
                                      width: segWidth,
                                      height: 50)
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
                    `self`.pinterestSegment.setRichTextTitles(`self`.segmentTitles)
                    `self`.pinterestSegment.valueChange = { index in
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
