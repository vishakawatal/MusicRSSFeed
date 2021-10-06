//
//  CollectionViewCell.swift
//  MusicRSSFeed
//
//  Created by Vishaka Watal on 06/10/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumSubtitle: UILabel!
    @IBOutlet weak var albumName: UILabel!
    
    func contentSetupOnCollectionView(cellViewModel: CollectionViewCellVM) {
        self.albumImage.image = cellViewModel.albumImage
        self.albumName.text = cellViewModel.albumName
        self.albumSubtitle.text = cellViewModel.albumSubtitle
    }
}

