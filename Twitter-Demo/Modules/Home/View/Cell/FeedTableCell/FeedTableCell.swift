//
//  FeedTableCell.swift
//  Twitter-Demo
//
//  Created by MAC on 13/10/23.
//

import UIKit

class FeedTableCell: UITableViewCell {
    //MARK: - OUTLET
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgVerified: UIImageView!
    @IBOutlet weak var lblHandlerName: UILabel!
    @IBOutlet weak var btnOption: UIButton!
    @IBOutlet weak var lblTextPost: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var stackCommentContainer: UIStackView!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var stackRetweetContainer: UIStackView!
    @IBOutlet weak var lblRetweetCount: UILabel!
    @IBOutlet weak var stackLikeContainer: UIStackView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var stackViewContainer: UIStackView!
    @IBOutlet weak var lblViewCount: UILabel!
    @IBOutlet weak var stackUploadContainer: UIStackView!
    
    //MARK: - PROPERTIES
    var optionBtnClicked: (() -> Void)?
    var commentClicked: (() -> Void)?
    var retweetClicked: (() -> Void)?
    var likeClicked: (() -> Void)?
    var viewsClicked: (() -> Void)?
    
    //MARK: - FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        //add gesture
        addGesture()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - ADD GESTURE
    func addGesture() {
        //comment view
        let commentTap = UITapGestureRecognizer(target: self, action: #selector(handleCommentTap(_:)))
        stackCommentContainer.addGestureRecognizer(commentTap)
        
        //retweet view
        let retweetTap = UITapGestureRecognizer(target: self, action: #selector(handleRetweetTap(_:)))
        stackRetweetContainer.addGestureRecognizer(retweetTap)
        
        //Like view
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(handleLikeTap(_:)))
        stackLikeContainer.addGestureRecognizer(likeTap)
        
        //View view
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:)))
        stackViewContainer.addGestureRecognizer(viewTap)
    }
    
    //MARK: - GESTURE ACTIONS
    @objc func handleCommentTap(_ sender: UITapGestureRecognizer) {
        commentClicked?()
    }
    
    @objc func handleRetweetTap(_ sender: UITapGestureRecognizer) {
        retweetClicked?()
    }
    
    @objc func handleLikeTap(_ sender: UITapGestureRecognizer) {
        likeClicked?()
    }
    
    @objc func handleViewTap(_ sender: UITapGestureRecognizer) {
        viewsClicked?()
    }
    
    // MARK: - BUTTON ACTIONS
    @IBAction func btnOptionClicked(_ sender: UIButton) {
        optionBtnClicked?()
    }
}
