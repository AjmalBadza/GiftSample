//
//  HeaderView.swift
//  GiftSample
//
//  Created by Ceino on 20/05/21.
//

import UIKit

class HeaderView: UIView {
    var collectionView: UICollectionView!
    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        createViews()
        setViewConstraints()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func createViews(){
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.tag = 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        self.addSubview(collectionView)
        self.addSubview(titleLabel)
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    func setViewConstraints() {
        // UIView Constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor,constant: 0),
            self.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor,constant: 0),
            self.heightAnchor.constraint(equalTo: collectionView.heightAnchor,constant: 50)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor,constant: -20),
            self.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor,constant: 0),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 50),
            self.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 0),
        ])
    }
}
