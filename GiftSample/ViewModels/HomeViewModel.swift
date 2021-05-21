//
//  HomeViewModel.swift
//  GiftSample
//
//  Created by Ceino on 20/05/21.
//

import Foundation

protocol HomeViewModelProtocol {
    func RecievedHomeResponse(error:Error?)
    func Brandsloaded()
    func FailedToRecieveBrandResponse(error:Error)
    func loadedNewBrands(error:Error?)
}
class HomeViewModel {
    
    var delegate:HomeViewModelProtocol?
    var categories = [Category]()
    var categoryIndex = 0
    var brands = [Brand](){
        didSet{
            delegate?.Brandsloaded()
        }
    }
    init() {
        self.loadHome { _ in
            
        }
    }
    func loadHome(handler:@escaping (String)->Void){
        let api = ServerApi()
        api.getHomeFeeds { (result) in
            switch result{
            
            case .success(let data):
                self.categories = data.categories
                self.brands = data.brands
                if self.categories.count>0 {
                    self.categories[0].brands = data.brands
                }
                self.delegate?.RecievedHomeResponse(error: nil)
                handler("Success")
            case .failure(let error):
                self.delegate?.RecievedHomeResponse(error: error)
                handler("Failure")
            }
        }
    }
    
    func loadBrands(){
        let category = categories[categoryIndex]
        if let brands = category.brands {
            self.brands = brands
            return
        }
        let api = ServerApi()
        print(category.id)
        api.getBrands(categoryId: category.id) { (result) in
            switch result{
            
            case .success(let data):
                self.brands = data.brands
                self.categories[self.categoryIndex].brands = data.brands
            case .failure(let error):
                self.delegate?.FailedToRecieveBrandResponse(error: error)
            }
        }
    }
    func loadMoreBrands(){
        let category = categories[categoryIndex]
        categories[categoryIndex].page = categories[categoryIndex].page+1
        print(categories[categoryIndex].page)
        let api = ServerApi()
        api.getBrands(categoryId: category.id,Page: category.page) { (result) in
            switch result{
            
            case .success(let data):
                self.brands.append(contentsOf: data.brands)
                self.categories[self.categoryIndex].brands?.append(contentsOf: data.brands)
                self.delegate?.loadedNewBrands(error: nil)
                
            case .failure(let error):
                self.delegate?.FailedToRecieveBrandResponse(error: error)
                self.delegate?.loadedNewBrands(error: error)
            }
            
        }
    }
    
}
