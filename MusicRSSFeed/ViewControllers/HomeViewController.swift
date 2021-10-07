//
//  HomeViewController.swift
//  MusicRSSFeed
//
//  Created by Vishaka Watal on 06/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingViewIndicator: UIActivityIndicatorView!
    
    var viewModel = HomeViewModel()
    var feedTypeListViewController: FeedTypeListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFeedTypeList" {
            feedTypeListViewController = segue.destination as? FeedTypeListViewController
            let popover = feedTypeListViewController?.popoverPresentationController
            popover?.delegate = self
            feedTypeListViewController?.delegate = self
        } 
    }
}

private extension HomeViewController {
    func loadDataSource(selectedFeedType: String = FeedTypeListViewController.kTopAlbums) {
        self.loadingViewIndicator.startAnimating()
        viewModel.loadDataSource (selectedFeedType: selectedFeedType) { sectionTitle in
            self.loadingViewIndicator.stopAnimating()
            self.title = sectionTitle
            self.collectionView.reloadData()
            self.loadImages()
        }
    }
    func loadImages() {
        viewModel.loadImagesFromAPIAndUpdateCellViewModels { index in
            let indexPathToReload = IndexPath.init(item: index, section: 0)
            self.collectionView.reloadItems(at: [indexPathToReload])
        }
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let cellViewModel = viewModel.dataSource[indexPath.row]
        cell.contentSetupOnCollectionView(cellViewModel: cellViewModel)
        
        return cell
    }
    
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.selectedCellViewModel = viewModel.dataSource[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension HomeViewController: FeedTypeListViewControllerDelegate {
    func didSelectedFeedType(selectedFeedType: String) {
        loadDataSource(selectedFeedType: selectedFeedType)
        feedTypeListViewController?.dismiss(animated: true, completion: nil)
    }
    
    func didDismissFeedTypeListPopover() {
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

