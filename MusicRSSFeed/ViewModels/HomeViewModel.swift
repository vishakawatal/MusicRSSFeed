//
//  HomeViewModel.swift
//  MusicRSSFeed
//
//  Created by Vishaka Watal on 06/10/21.
//

import Foundation
import UIKit

class HomeViewModel {
    
    var resultModels = [Result]()
    let urlSessionHelper = UrlSessionHelper()
    var sectionTitle = ""
    var dataSource = [CollectionViewCellVM]()
    
    init() {
        
    }
    
    private func getTopAlbumns(selectedFeedType: String, completion: @escaping () -> Void) {
        urlSessionHelper.getFeeds(selectedFeedType: selectedFeedType) { [weak self] results, sectionTitle, errorMessage in
            if let resultsFromAPI = results {
                self?.resultModels = resultsFromAPI
                self?.sectionTitle = sectionTitle
            } else {
                print(errorMessage)
            }
            completion()
        }
    }
    
    func loadDataSource(selectedFeedType: String, completion: @escaping (String) -> Void) {
        getTopAlbumns(selectedFeedType: selectedFeedType) {
            self.dataSource = [CollectionViewCellVM]()
            for result in self.resultModels {
                let cellViewModel = CollectionViewCellVM(albumName: result.name, albumSubtitle: result.artistName, albumImage: nil, imageUrl: result.artworkUrl100, copyRight: result.copyright, releaseDate: result.releaseDate, appleMusicUrl: result.artistUrl)
                self.dataSource.append(cellViewModel)
            }
            completion(self.sectionTitle)
        }
    }
    
    func loadImagesFromAPIAndUpdateCellViewModels(completion: @escaping (Int) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            for (index, cellViewModel) in self.dataSource.enumerated() {
                guard let url = URL(string: cellViewModel.imageUrl) else {
                    continue
                }
                let data = try? Data(contentsOf: url)
                if let imageData = data, let image = UIImage(data: imageData) {
                    let cellViewModel = CollectionViewCellVM(albumName: cellViewModel.albumName, albumSubtitle: cellViewModel.albumSubtitle, albumImage: image, imageUrl: cellViewModel.imageUrl, copyRight: cellViewModel.copyRight, releaseDate: cellViewModel.releaseDate, appleMusicUrl: cellViewModel.appleMusicUrl)
                    self.dataSource[index] = cellViewModel
                    DispatchQueue.main.async {
                        completion(index)
                    }
                }
            }
        }
    }
}

