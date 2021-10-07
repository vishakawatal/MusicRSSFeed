//
//  DetailViewController.swift
//  MusicRSSFeed
//
//  Created by Vishaka Watal on 06/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var albumnImageView: UIImageView!
    @IBOutlet weak var albumnName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var copyRight: UILabel!
    @IBOutlet weak var appleMusicButton: UIButton!
    
    
    var selectedCellViewModel: CollectionViewCellVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumnImageView.layer.cornerRadius = (self.albumnImageView.frame.size.width/2)
        loadDisplayContent()
    }
}

private extension DetailViewController {
    func loadDisplayContent() {
        self.albumnImageView.image = selectedCellViewModel?.albumImage
        self.albumnName.text = selectedCellViewModel?.albumName
        self.artistName.text = selectedCellViewModel?.albumSubtitle
        self.releaseDate.text = selectedCellViewModel?.releaseDate
        self.copyRight.text = selectedCellViewModel?.copyRight
    }
}

