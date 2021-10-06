//
//  MusicFeed.swift
//  MusicRSSFeed
//
//  Created by Vishaka Watal on 06/10/21.
//

import Foundation

struct Feed: Codable {
    let feed: RssFeed
}

struct RssFeed: Codable {
    let title: String
    let results: [Result]
}

struct Result: Codable {
    let artistName: String
    let releaseDate: String
    let name: String
    let kind: String
    let copyright: String
    let artistId: String
    var contentAdvisoryRating: String?
    let artistUrl: String
    let artworkUrl100: String
    let url: String
    let genres: [Genre]
}

struct Genre: Codable {
    let genreId: String
    let name: String
    let url: String
}

