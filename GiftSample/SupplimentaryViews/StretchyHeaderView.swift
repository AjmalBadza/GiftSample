//
//  StretchyTableHeaderView.swift
//  GiftSample
//
//  Created by Ceino on 20/05/21.
//

import Foundation
import UIKit
class StretchyHeaderView: UIView {
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    
    var containerView: UIView!
    var imageView: UIImageView!
    var label: UILabel!
    var captionLabel: UILabel!
    
    var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        
        setViewConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createViews() {
        
        containerView = UIView()
        self.addSubview(containerView)
        
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        containerView.addSubview(label)
        
        captionLabel = UILabel()
        captionLabel.text = ""
        captionLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        captionLabel.textColor = .white
        containerView.addSubview(captionLabel)
    }
    
    func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor,constant: -20),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        // captionLabel Constraints
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor,constant: 25).isActive = true
        captionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

    }
    // Strectching
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
