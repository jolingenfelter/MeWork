//
//  ScrollAndCropImageView.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/8/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class ScrollAndCropImageView: UIScrollView {
    
    fileprivate var imageView: UIImageView?
    fileprivate var originalImage: UIImage?
    fileprivate var isFirstLoad = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    func customInit() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 15.0
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bouncesZoom = true
        self.decelerationRate = UIScrollViewDecelerationRateFast
        self.delegate = self
    }
    
    // Constraints myst be set on scrollView (or frame) in setup before this method is called
    func showImage(_ image: UIImage) {
        
        if self.imageView != nil {
            self.imageView?.removeFromSuperview()
            self.imageView = nil
        }
        
        self.imageView = UIImageView(image: image)
        configureForImageSize(image.size)
        self.addSubview(imageView!)

    }
    
    private func configureForImageSize(_ imageSize: CGSize) {
        self.contentSize = imageSize
        setZoomScale()
    }
    
    private func setZoomScale() {
        
        guard let imageView = imageView else {
            return
        }
        
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = self.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        self.minimumZoomScale = min(widthScale, heightScale)
        self.maximumZoomScale = 10.0
        self.contentOffset = CGPoint(x: imageViewSize.width/2, y: imageViewSize.height/2)
        self.zoomScale = self.minimumZoomScale
    }
    
    // MARK: - CropImage
    
    func cropImage(completion: (UIImage) -> ()) throws {
        
        guard let imageView = imageView else {
            return
        }
        
        let scale: CGFloat = 1/self.zoomScale
        let x: CGFloat = self.contentOffset.x * scale
        let y: CGFloat = self.contentOffset.y * scale
        let width: CGFloat = self.frame.size.width * scale
        let height: CGFloat = self.frame.size.height * scale
        let cropRect = CGRect(x: x, y: y, width: width, height: height)
        
        guard let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropRect) else {
            throw ImageCroppingError.unknownError
        }
        
        let newImage = UIImage(cgImage: croppedCGImage)
        showImage(newImage)
        completion(newImage)
    }
    
}

// MARK: - UIScrollViewDelegate

extension ScrollAndCropImageView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let imageViewSize = imageView!.frame.size
        let scrollViewSize = self.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
}
