//
//  TweetHandleSearchTable+SearchController.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//
import UIKit
import DZNEmptyDataSet

extension TweetHandleSearchTableViewController: UISearchBarDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func initializeSearchController() {
        tweethandleSearchController = UISearchController(searchResultsController: nil)
        tweethandleSearchController?.hidesNavigationBarDuringPresentation = true
        tweethandleSearchController?.dimsBackgroundDuringPresentation = true
        tweethandleSearchController?.searchBar.delegate = self
        tweethandleSearchController?.searchBar.placeholder = "@search"
        self.tableView.tableHeaderView = tweethandleSearchController?.searchBar
        
        hidesSearchBar()
    }
    
    func hidesSearchBar() {
        self.tableView.setContentOffset(CGPoint(x:0,y:44.0), animated: true)
        
    }
    
    //Search Bar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       SessionManager.shared.tweets = []
        handle = searchBar.text!
       APIManager.loadData(handle: handle) { (error) in
            if error != nil {
            
            }
            else{
                self.tweetDataSource = SessionManager.shared.tweets
                self.tableView.reloadData()
            }
        }
    }
    
    //Empty Set methods
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "Notfound")
    }
}
