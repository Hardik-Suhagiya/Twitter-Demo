//
//  UIViewController + Extension.swift
//  Twitter-Demo
//
//  Created by MAC on 13/10/23.
//

import Foundation
import UIKit

extension UIViewController {
    //MARK: -  PROPERTIES
    typealias CompletionHandler = () -> Void
    
    //MARK: - FUNCTIIONS
    func setupLeftBarItem(image: UIImage, width: CGFloat = 40, height: CGFloat = 40, completion: @escaping CompletionHandler) {
        
        let action = UIAction(title: "") { action in
            completion()
        }
        let button = UIButton(type: .custom,primaryAction: action)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = height / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
        
    }
}
