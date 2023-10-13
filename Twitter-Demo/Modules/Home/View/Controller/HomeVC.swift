//
//  HomeVC.swift
//  Twitter-Demo
//
//  Created by MAC on 12/10/23.
//

import UIKit
import MXSegmentedControl

class HomeVC: UIViewController {
    //MARK: - OUTLET
    @IBOutlet weak var segmentControl: MXSegmentedControl!
    @IBOutlet weak var tblFeed: UITableView!
    
    //MARK: - PROPERTIES
    let refreshControl = UIRefreshControl()
    let viewModel = HomeViewModel()
    
    //MARK: - VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetUp()
    }
}

//MARK: - UI FUNCTION
extension HomeVC {
    func initialSetUp() {
        setUpNavigationBar()
        setupSegment()
        configure(with: viewModel)
        configureTableView()
    }
    
    func setUpNavigationBar() {
        setupTitleImage(image: UIImage(named:"ic_logo")!)
        setupLeftBarItem(image: UIImage(named:"ic_profile")!, completion: {()-> Void in })
    }
    
    func setupSegment() {
        segmentControl.font = .boldSystemFont(ofSize: 15)
        segmentControl.append(title: "For you")
        segmentControl.append(title: "Following")
        segmentControl.addTarget(self, action: #selector(changeIndex(segmentedControl:)), for: .valueChanged)
    }
}

// MARK: - VIEWMODEL CONFIGURATION FUNCTION
extension HomeVC {
    func configure(with viewModel: HomeViewModel) {
        viewModel.response = { [weak self] (success, message) in
            self?.tblFeed.reloadData()
        }
    }
}

//MARK: - ACTIONS
extension HomeVC {
    @objc func changeIndex(segmentedControl: MXSegmentedControl) {
        debugPrint("Segment \(segmentedControl.selectedIndex) is selected")
    }
}
