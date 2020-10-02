//
//  CategoryView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/28.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import PinterestSegment

protocol CategoryViewDelegate: AnyObject {
    func didTapCategoryButton(category: String)
}

class CategoryView: UIView {
    
    private var posts = [Post]()
    private var sortedPosts = [Post]()
    private var selectedPosts = [Post]()
    private var postCategories = [String]()
    private var segmentTitles = [PinterestSegment.TitleElement]()
    public weak var delegate: CategoryViewDelegate?
    
    private let segmentControl: PinterestSegment = {
        var style = PinterestSegmentStyle()
        style.indicatorColor = .lightGray
        style.titlePendingHorizontal = 15
        style.titlePendingVertical = 15
        style.titleMargin = 15
        style.normalTitleColor = .lightGray
        style.selectedTitleColor = .white
        style.titleFont = UIFont.systemFont(ofSize: 14)
        let segmentControl = PinterestSegment(frame: .zero,
                                              segmentStyle: style,
                                              titles: [])
        return segmentControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(segmentControl)
        
        fetchPost()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        segmentControl.frame = bounds
    }
    
    private func fetchPost() {
        DatabaseManeger.shared.getPostData { [weak self](result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let data):
                guard let postDates = data as? [String: Any] else { return }
                postDates.forEach { (key, value) in
                    guard let postDate = value as? [String: Any] else { return }
                    let post = Post(dictionary: postDate)
                    `self`.posts.append(post)
                }
                
                `self`.sortedPosts.append(contentsOf: `self`.posts.sorted {$0.uploadedDate > $1.uploadedDate})
                
                `self`.postCategories.append("All")
                `self`.segmentTitles.append(PinterestSegment.TitleElement(title: "All"))
                for sortedPost in `self`.sortedPosts {
                    `self`.postCategories.append(sortedPost.category)
                    `self`.segmentTitles.append(PinterestSegment.TitleElement(title: sortedPost.category))
                }
                DispatchQueue.main.async {
                    `self`.segmentControl.setRichTextTitles(`self`.segmentTitles)
                    `self`.segmentControl.valueChange = { index in
                        let category = `self`.postCategories[index]
                        `self`.delegate?.didTapCategoryButton(category: category)
                    }
                }
            case .failure(let error):
                print("failed to fetch data: \(error)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
