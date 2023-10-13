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
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as? FeedTableCell else { return  UITableViewCell() }
       
        return cell
    }
}
