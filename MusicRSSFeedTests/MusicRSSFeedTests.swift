//
//  MusicRSSFeedTests.swift
//  MusicRSSFeedTests
//
//  Created by Vishaka Watal on 05/10/21.
//

import XCTest
@testable import MusicRSSFeed

class MusicRSSFeedTests: XCTestCase {
    var viewModel = HomeViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoadDataSource() throws {
        viewModel.loadDataSource(selectedFeedType: FeedTypeListViewController.kTopAlbums) { sectionTitle in
            XCTAssertNotNil(sectionTitle)
        }
    }
    
    func testLoadImagesFromAPIAndUpdateCellViewModels() throws {
        viewModel.loadImagesFromAPIAndUpdateCellViewModels { index in
            XCTAssertNotNil(index)
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
