//
//  HomeVC + TableView.swift
//  Twitter-Demo
//
//  Created by MAC on 12/10/23.
//

import UIKit

extension HomeVC {
    //MARK: - CONFIGURE TABLE VIEW
    func configureTableView() {
        tblFeed.register(UINib(nibName: "FeedTableCell", bundle: nil), forCellReuseIdentifier: "FeedTableCell")
        tblFeed.dataSource = self
        tblFeed.delegate = self
        addHeaderRefresh(for: tblFeed)
    }
    
    // MARK: - ADD HEADER REFRESH
    func addHeaderRefresh(for table : UITableView) {
        refreshControl.addTarget(self, action: #selector(handleTopRefresh(_:)), for: .valueChanged )
        refreshControl.tintColor = UIColor.gray
        table.addSubview(refreshControl)
    }
    
    // MARK: - HANDLE TOP REFRESH
    @objc func handleTopRefresh(_ sender:UIRefreshControl) {
        sender.endRefreshing()
    }
    
    //MARK: - IS CELL VISIBLE
    func isCellVisible(indexPath: IndexPath) -> Bool {
        guard let visibleIndexPaths = tblFeed.indexPathsForVisibleRows else {
            return false
        }
        return visibleIndexPaths.contains(indexPath)
    }
}

//MARK: - TABLEVIEW DELEGATE & DATA-SOURCE
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as? FeedTableCell else { return  UITableViewCell() }
        cell.feedData = viewModel.arrFeed[indexPath.row]
        cell.commentClicked = {}
        cell.retweetClicked = {}
        cell.likeClicked = {}
        cell.viewsClicked = {}
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FeedTableCell {
            if self.isCellVisible(indexPath: indexPath) {
                cell.playVideo()
            } else {
                cell.pauseVideo()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FeedTableCell {
            cell.pauseVideo()
        }
    }
}
