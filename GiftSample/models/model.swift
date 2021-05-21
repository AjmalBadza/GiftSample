//
//  model.swift
//  GiftSample
//
//  Created by Ceino on 20/05/21.
//

import Foundation
struct ApiHome:Decodable{
    let brands:[Brand]
    let categories:[Category]
    
}
struct ApiBrands:Decodable{
    let brands:[Brand]
    enum CodingKeys: String, CodingKey {
        case brands
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        brands = try container.decode([Brand].self, forKey: .brands)
    }
}
struct Category:Decodable{
    let id:Int
    let name:String
    let image_large:String
    let image_small:String
    let title:String
    let caption:String
    var brands:[Brand]?
    var page:Int
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image_large
        case image_small
        case title
        case caption
        case brands
        case page
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.image_large = try container.decodeIfPresent(String.self, forKey: .image_large) ?? ""
        self.image_small = try container.decodeIfPresent(String.self, forKey: .image_small) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        self.page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 1
    }
}
struct Brand:Decodable{
    let id:Int
    let name:String
    let product_image:String
    let currency:String
    let short_tagline:String
    let redemption_tag:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case product_image
        case currency
        case short_tagline
        case redemption_tag
        
    }
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.product_image = try container.decodeIfPresent(String.self, forKey: .product_image) ?? ""
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        self.short_tagline = try container.decodeIfPresent(String.self, forKey: .short_tagline) ?? ""
        self.redemption_tag = try container.decodeIfPresent(String.self, forKey: .redemption_tag) ?? ""
        
    }
}
