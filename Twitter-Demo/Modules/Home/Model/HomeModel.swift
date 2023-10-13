//
//  HomeModel.swift
//  Twitter-Demo
//
//  Created by MAC on 12/10/23.
//

import Foundation

struct HomeModel: Codable {
    let profileImage, name, handlerName: String?
    let isVerified: Bool?
    let postTime, postText, postImage, postVideo: String?
    let commentCount, retweetCount, likesCount, viewsCount: String?
}
