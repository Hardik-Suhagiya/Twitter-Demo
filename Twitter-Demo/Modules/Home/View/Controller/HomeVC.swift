//
//  HomeVC.swift
//  Twitter-Demo
//
//  Created by MAC on 12/10/23.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - OUTLET
    @IBOutlet weak var tblFeed: UITableView!
    
    //MARK: - PROPERTIES
    let refreshControl = UIRefreshControl()
    
    //MARK: - VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetUp()
    }
}

//MARK: - UI FUNCTION
extension HomeVC {
    private func initialSetUp() {
        setUpNavigationBar()
        configureTableView()
    }
    
    private func setUpNavigationBar() {
        setupTitleImage(image: UIImage(named:"ic_logo")!)
        setupLeftBarItem(image: UIImage(named:"ic_profile")!, completion: {()-> Void in
            
        })
    }
}
