//
//  TweetHandleSearchTableViewController.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit
import Kingfisher

class TweetHandleSearchTableViewController: UITableViewController {

    var tweethandleSearchController:UISearchController?
    var tweetDataSource:[Tweet] = SessionManager.shared.tweets
    var handle = "@FlohNetwork"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(TweetHandleSearchTableViewController.reloadData), for: .valueChanged)
        
        self.tableView.refreshControl = refreshControl
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 190
        
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        initializeSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetDataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCard", for: indexPath) as! TweetCardTableViewCell
        let tweet = tweetDataSource[indexPath.row]
        cell.configureCell(tweet: tweet)
        return cell
    }
    
    
    //Pagination
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentLarger = (scrollView.contentSize.height > scrollView.frame.size.height)
        let viewableHeight = contentLarger ? scrollView.frame.size.height : scrollView.contentSize.height
        let atBottom = (scrollView.contentOffset.y >= scrollView.contentSize.height - viewableHeight + 50)
        if atBottom && !tableView.isLoadingFooterShowing() {
            tableView.showLoadingFooter()
            APIManager.loadNextData(handle: handle, completionHandle: { (error) in
                self.tweetDataSource = SessionManager.shared.tweets
                self.tableView.reloadData()
                self.tableView.hideLoadingFooter()
            })
        }
        
    }
    
    
    //Reload Data from API
    
    func reloadData() {
        SessionManager.shared.tweets = []
        APIManager.loadData(handle: handle) { (error) in
            self.refreshControl?.endRefreshing()
            if error != nil {
                
            }
            else{
                self.tweetDataSource = SessionManager.shared.tweets
                self.tableView.reloadData()
            }
        }
    }
    
}
