//
//  PostViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SafariServices
import ViewAnimator
import TPKeyboardAvoiding
import UITextView_Placeholder
import ImagePicker
import AVFoundation
import DKImagePickerController

class PostViewController: UIViewController {
    
    private var images = [UIImage]()
    
    private let scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView()
        return scrollView
    }()
    
    private let itemImageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.isHidden = true
        return scrollView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let pageControl: UIPageControl = {
        let pagecontrol = UIPageControl()
        pagecontrol.isHidden = true
        pagecontrol.currentPageIndicatorTintColor = .systemPink
        pagecontrol.pageIndicatorTintColor = .systemGray
        return pagecontrol
    }()
    
//    private let itemImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemPink
//        imageView.isUserInteractionEnabled = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
    
    private let cancelImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("change Picture", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private let rankButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rosette"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tintColor = .lightGray
        return button
    }()
    
    private let titleTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "TITLE"
        textField.title = "put item name"
        textField.textColor = .lightGray
        textField.lineColor = .lightGray
        textField.tintColor = .systemIndigo
        textField.selectedLineColor = .systemIndigo
        textField.selectedTitleColor = .systemIndigo
        return textField
    }()
    
    private let urlTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "URL"
        textField.title = "paste item's url"
        textField.textColor = .lightGray
        textField.lineColor = .lightGray
        textField.tintColor = .systemIndigo
        textField.selectedLineColor = .systemIndigo
        textField.selectedTitleColor = .systemIndigo
        return textField
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("select category", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        return button
    }()
    
    private var category: String?
    
    private let urlButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private let captionTextView: UITextView = {
        let textView = UITextView()
        textView.tintColor = .lightGray
        textView.placeholder = "type your message"
        textView.font = UIFont(name: "Arial", size: 14)
        textView.backgroundColor = .init(white: 0.5, alpha: 0.1)
        return textView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("cancel", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private var selectRankPopup: SelectRankPopup = {
        let popup = SelectRankPopup(frame: (CGRect(x: 100, y: 100, width: 100, height: 100)))
        popup.alpha = 0
        popup.layer.cornerRadius = 5
        return popup
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.alpha = 0
        return effectView
    }()
    
    public static let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // medium: 2017/08/13
        formatter.dateStyle = .medium
        // medium: 16:36:46
        formatter.timeStyle = .medium
        formatter.locale = .current
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        addSubViews()
        selectRankPopup.delegate = self
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(itemImageScrollView)
        scrollView.addSubview(pageControl)
        itemImageScrollView.addSubview(photoImageView)
//        scrollView.addSubview(itemImageView)
        itemImageScrollView.addSubview(addImageButton)
        scrollView.addSubview(rankButton)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(urlTextField)
        scrollView.addSubview(categoryButton)
        urlTextField.addSubview(urlButton)
        scrollView.addSubview(captionTextView)
        scrollView.addSubview(cancelButton)
        scrollView.addSubview(submitButton)
        scrollView.addSubview(blurEffectView)
        scrollView.addSubview(selectRankPopup)
        
        itemImageScrollView.delegate = self
        
        titleTextField.delegate = self
        urlTextField.delegate = self
        
        addImageButton.addTarget(self, action: #selector(didTapAddImageButton), for: .touchUpInside)
        rankButton.addTarget(self, action: #selector(didTapRankButton), for: .touchUpInside)
        urlButton.addTarget(self, action: #selector(didTapUrlButton), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(didTapCategoryButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        itemImageScrollView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: view.width,
                                           height: view.width - 90)
        photoImageView.frame = itemImageScrollView.bounds
        pageControl.frame = CGRect(x: (view.width - view.width / 3) / 2,
                                   y: itemImageScrollView.bottom,
                                   width: view.width / 3,
                                   height: 20)
        itemImageScrollView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: view.width,
                                     height: view.width - 90)
        cancelImageButton.frame = CGRect(x: view.width - 160,
                                         y: itemImageScrollView.height - 67,
                                         width: 150,
                                         height: 52)
        cancelImageButton.layer.cornerRadius = 10
        addImageButton.frame = CGRect(x: (itemImageScrollView.width - 100) / 2,
                                      y: (itemImageScrollView.height - 100) / 2,
                                      width: 100,
                                      height: 100)
        addImageButton.layer.cornerRadius = addImageButton.width / 2
        titleTextField.frame = CGRect(x: 10,
                                      y: itemImageScrollView.bottom + 10,
                                      width: view.width - 90,
                                      height: 52)
        rankButton.frame = CGRect(x: titleTextField.right + 20,
                                  y: itemImageScrollView.bottom + 10,
                                  width: 52, height: 52)
        rankButton.layer.cornerRadius = rankButton.width / 2
        urlTextField.frame = CGRect(x: 10,
                                    y: titleTextField.bottom + 10,
                                    width: view.width - 20,
                                    height: 52)
        urlButton.frame = CGRect(x: view.width - 62,
                                 y: 0,
                                 width: 52,
                                 height: 52)
        urlButton.center.y = urlTextField.height / 2
        categoryButton.frame = CGRect(x: 10,
                                      y: urlTextField.bottom + 15,
                                      width: view.width - 20,
                                      height: 52)
        categoryButton.layer.cornerRadius = 10
        captionTextView.frame = CGRect(x: 10,
                                       y: categoryButton.bottom + 15,
                                       width: view.width - 20,
                                       height: view.height - 77 - (categoryButton.bottom + 15))
        cancelButton.frame = CGRect(x: 10,
                                    y: captionTextView.bottom + 15,
                                    width: (view.width / 2) - 15,
                                    height: 52)
        cancelButton.layer.cornerRadius = 10
        submitButton.frame =  CGRect(x: (view.width / 2) + 5,
                                     y: captionTextView.bottom + 15,
                                     width: (view.width / 2) - 15,
                                     height: 52)
        submitButton.layer.cornerRadius = 10
        blurEffectView.frame = view.bounds
        selectRankPopup.frame = view.bounds
    }
    
    @objc private func didTapAddImageButton() {
        let alert = UIAlertController(title: "Image", message: "share your image", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "take photo", style: .default, handler: { (_) in
            self.takePhoto()
        }))
        alert.addAction(UIAlertAction(title: "select from Album", style: .default, handler: { (_) in
            self.selectFromAlbum()
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapCategoryButton() {
        let vc = SelectCategoryView()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapNewCategoryButton() {
        let alert = UIAlertController(title: "category", message: "select Category", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
            guard let `self` = self else { return }
            guard let text = alert.textFields?.first?.text else { return }
            `self`.categoryButton.setTitle(text, for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    private func takePhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.mediaTypes = ["public.image", "public.movie"]
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    private func selectFromAlbum() {
        
        let pickerController = DKImagePickerController()
        pickerController.allowMultipleTypes = true
        pickerController.didCancel = {
            pickerController.dismiss(animated: true, completion: nil)
        }
        pickerController.didSelectAssets = { [weak self] (assets: [DKAsset]) in
            
            guard let `self` = self else { return }
            
            `self`.images = []
            
            for asset in assets {
                
                if asset.type == .photo {
                    asset.fetchFullScreenImage { (image, _) in
                        guard let image = image else { return }
                        `self`.images.append(image)
                        `self`.showSelectedImage()
                    }
                } else if asset.type == .video {
                    asset.fetchAVAsset { (video, _) in
                        guard let video = video as? AVURLAsset else { return }
                        let image = AVAssetImageGenerator(asset: AVURLAsset(url: video.url))
                        let thumbnail = try! image.copyCGImage(at: .zero,
                                                               actualTime: nil)
                        let thumbnailUIimage = UIImage(cgImage: thumbnail,
                                                       scale: 0,
                                                       orientation: .up)
                        `self`.images.append(thumbnailUIimage)
                        `self`.showSelectedImage()
                    }
                }
            }
        }
        self.present(pickerController, animated: true, completion: nil)
        //        let vc = UIImagePickerController()
//        vc.sourceType = .photoLibrary
//        vc.mediaTypes = ["public.image", "public.movie"]
//        vc.delegate = self
//        vc.allowsEditing = true
//        present(vc, animated: true, completion: nil)
        
//        ImagePicker
//        let imagePickerController = ImagePickerController()
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func showSelectedImage() {
        pageControl.isHidden = false
        pageControl.numberOfPages = images.count
        
        itemImageScrollView.contentSize = CGSize(width: view.width * CGFloat(images.count),
                                                 height: itemImageScrollView.height)
        itemImageScrollView.isPagingEnabled = true
        
        for x in 0..<images.count {
            let eachView = UIImageView()
            eachView.frame = CGRect(x: CGFloat(x) * view.width,
                                                y: 0,
                                                width: view.width,
                                                height: itemImageScrollView.height)
            eachView.image = images[x]
            eachView.contentMode = .scaleAspectFill
            eachView.clipsToBounds = true
            itemImageScrollView.addSubview(eachView)
        }
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * view.width, y: 0),
                                    animated: true)
    }
    
    @objc internal func didTapRankButton() {
        
        selectRankPopup.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
            self.selectRankPopup.alpha = 1
            self.selectRankPopup.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func didTapUrlButton() {
        let urlString = "https://www.google.com/webhp?hl=ja&sa=X&ved=0ahUKEwjE67_UsNPrAhUIG6YKHaMkAuIQPAgI"
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapSubmitButton() {
        
        submitButton.isEnabled = false
        
        let fileName = createFileName()
        var uploadDatas = [Data]()
        
        if let image = photoImageView.image {
            guard let imageData = image.pngData() else { return }
            StorageManeger.shared.uploadPostPhoto(with: imageData, fileName: fileName) { [weak self] result in
                
                guard let `self` = self else { return }
                
                switch result {
                case .success(let urlString):
                    `self`.saveToDatabase(urlString: urlString, urlStrings: nil)
                case .failure(let error):
                    print("error:\(error)")
                }
            }
        } else {
            for image in images {
                guard let imageData = image.pngData() else { return }
                uploadDatas.append(imageData)
            }
            StorageManeger.shared.uploadPhotos(with: uploadDatas, fileName: fileName) { result in
                switch result {
                case .success(let datas):
                    print("datasdatas:\(datas)")
                    guard let datas = datas as? [String] else { return }
                    `self`.saveToDatabase(urlString: nil, urlStrings: datas)
                case .failure(let error):
                    print("failed to fetch datas \(error)")
                }
            }
        }
    }
    
    private func saveToDatabase(urlString: String?, urlStrings: [String]?) {
        
        guard let title = titleTextField.text else { return }
        guard let itemSiteURL = urlTextField.text else { return }
        guard let caption = captionTextView.text else { return }
        guard let category = self.category else { return }
        let uploadedDate = PostViewController.dataFormatter.string(from: Date())
        
        var uploadDates = [String]()
        if let urlString = urlString {
            uploadDates.append(urlString)
        } else if let urlStrings = urlStrings {
            uploadDates.append(contentsOf: urlStrings)
        }
        
        let values = ["title": title,
                      "itemSiteURL": itemSiteURL,
                      "imageURL": uploadDates,
                      "caption": caption,
                      "uploadedDate": uploadedDate,
                      "category": category] as [String : Any]
        
        DatabaseManeger.shared.postUpdate(values: values) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(_):
                `self`.submitButton.isEnabled = false
                `self`.dismiss(animated: true, completion: nil)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func createFileName() -> String {
        
        guard let title = titleTextField.text else { return "" }
        let dateString = Self.dataFormatter.string(from: Date())
        let fileName = "\(title)_\(dateString)"
        
        return fileName
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension PostViewController: SelectRankPopupDelegate {
    func didSelectRankButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
            self.selectRankPopup.alpha = 0
        }
    }
}

extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            urlTextField.becomeFirstResponder()
        } else if textField == urlTextField {
            captionTextView.becomeFirstResponder()
        }
        return true
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        addImageButton.removeFromSuperview()
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImageView.image = image
        } else if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            let video = AVURLAsset(url: url)
            let videoImage = AVAssetImageGenerator(asset: video)
            let thumbnail = try! videoImage.copyCGImage(at: .zero, actualTime: nil)
            photoImageView.image = UIImage(cgImage: thumbnail,
                                          scale: 0,
                                          orientation: .right)
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        photoImageView.addSubview(cancelImageButton)
    }
}

extension PostViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: SelectCategoryViewDelegate {
    func selectCategory(text: String) {
        categoryButton.setTitle("CATEGORY: \(text)", for: .normal)
        self.category = text
    }
}

extension PostViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x / scrollView.width)))
    }
}
