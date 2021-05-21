//
//  Cells.swift
//  GiftSample
//
//  Created by Ceino on 20/05/21.
//

import Foundation
import UIKit



class BrandCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        redLabel.layer.borderColor = UIColor.white.cgColor
        redLabel.layer.borderWidth = 0.5
        redLabel.layer.cornerRadius = 4
        redLabel.layer.masksToBounds = true
    }
    
}

extension UIImageView {
    // Loads image from web asynchronosly and caches it
    func load(url: String, placeholder: UIImage?, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }

                }
            }).resume()
        }
    }
}
