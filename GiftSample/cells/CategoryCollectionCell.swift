//
//  CategoryCollectionCell.swift
//  GiftSample
//

//

import Foundation
import UIKit
class CategoryCollectionCell: UICollectionViewCell {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var selectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    override var isSelected: Bool{
        didSet{
            //selection
            selectView.isHidden = isSelected ? false : true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSelected = false
        setUpViews()
    }
    func setUpViews(){
        
        // UIView Constraints
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(selectView)
        
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            self.contentView.heightAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            self.contentView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
        ])
        NSLayoutConstraint.activate([
            self.selectView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.selectView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: -7),
            self.selectView.heightAnchor.constraint(equalToConstant: 14),
            self.selectView.widthAnchor.constraint(equalToConstant: 14)
            
        ])
        
        contentView.clipsToBounds = true
        selectView.transform = CGAffineTransform(rotationAngle: .pi/4)
       
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
