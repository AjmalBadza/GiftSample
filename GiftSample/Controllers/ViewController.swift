//
//  ViewController.swift
//  GiftSample
//

//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak var collectionView:UICollectionView?
    weak var headerView:StretchyHeaderView?
    weak var secondHeader:HeaderView?
    let homeViewModel=HomeViewModel()
    var load = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setupHeader()
        
    }
    
    fileprivate func setupHeader() {
        let header = StretchyHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: view.frame.height/3))
        self.tableView.tableHeaderView = header
        headerView = header
    }
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        
        cell.collectionView.delegate = self
        collectionView = cell.collectionView
        cell.collectionView.dataSource = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.homeViewModel.brands.count==0){
            return 200
        }
        return CGFloat(CGFloat(self.homeViewModel.brands.count)/2.0*(view.frame.width/2.0))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: view.frame.height/3.3))
        headerView.collectionView.delegate = self
        headerView.collectionView.dataSource = self
        self.secondHeader = headerView
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height/4
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as? StretchyHeaderView
        
        headerView?.scrollViewDidScroll(scrollView: scrollView)
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
            if !load {
                load = true
                print("here")
                self.homeViewModel.loadMoreBrands()
                
            }
            
        }
        
        
    }
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag==2){
            return homeViewModel.categories.count
        }
        return homeViewModel.brands.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView.tag==2){
            return CGSize(width: view.frame.width/1.5, height: view.frame.height/4-70.0)
        }
        return CGSize(width: view.frame.width/2.3, height: view.frame.width/2.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView.tag==2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionCell
            let category  = homeViewModel.categories[indexPath.item]
            cell.imageView.load(url: category.image_small,placeholder: nil)
            cell.nameLabel.text = category.name
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BrandCollectionCell
        let brand  = homeViewModel.brands[indexPath.item]
        cell.nameLabel.text = brand.name
        cell.currencyLabel.text = brand.currency
        cell.redLabel.text = " \(brand.redemption_tag) "
        if(brand.redemption_tag==""){
            cell.redLabel.layer.borderColor = UIColor.white.cgColor
        }else{
            cell.redLabel.layer.borderColor = UIColor.systemPink.cgColor
        }
        cell.tagLabel.text = brand.short_tagline
        cell.imageView.load(url: brand.product_image, placeholder: nil)
        //print(brand.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView.tag==2){
            
            self.homeViewModel.categoryIndex = indexPath.item
            
            self.headerView?.label.text = self.homeViewModel.categories[indexPath.item].name
            self.headerView?.imageView.load(url: self.homeViewModel.categories[indexPath.item].image_large, placeholder: nil)
            self.headerView?.captionLabel.text = self.homeViewModel.categories[indexPath.item].caption
            self.secondHeader?.titleLabel.text = self.homeViewModel.categories[indexPath.item].name
            self.homeViewModel.loadBrands()
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            activityIndicator.startAnimating()
        }
        
    }
    
    
    
}


extension ViewController:HomeViewModelProtocol{
    //protoco methods
    func RecievedHomeResponse(error: Error?) {
        
        guard error != nil else{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.headerView?.label.text = self.homeViewModel.categories.first?.title
                self.headerView?.imageView.load(url: self.homeViewModel.categories.first?.image_large ?? "", placeholder: nil)
                self.headerView?.captionLabel.text = self.homeViewModel.categories.first?.caption
                self.secondHeader?.titleLabel.text  = self.homeViewModel.categories.first?.name
                self.activityIndicator.stopAnimating()
            }
            DispatchQueue.main.asyncAfter(deadline:.now()+0.1) {
                self.load = false
                self.secondHeader?.titleLabel.text  = self.homeViewModel.categories.first?.name
                if(self.homeViewModel.categories.first != nil){
                    self.secondHeader?.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                }
                
            }
            
            return
        }
        
    }
    
    func Brandsloaded() {
        
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.collectionView?.reloadData()
            self.load = false
            self.tableView.endUpdates()
            self.activityIndicator.stopAnimating()
        }
        
        
    }
    
    func FailedToRecieveBrandResponse(error: Error) {
        
    }
    
    func loadedNewBrands(error: Error?) {
        
    }
}
