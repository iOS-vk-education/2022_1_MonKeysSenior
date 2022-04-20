//
//  ProfileController.swift
//  Drip
//
//  Created by Maksongold on 18.04.2022.
//

import UIKit


final class ProfileController: UIViewController {
//    private let model = FeedModel()
    private let profileView = ProfileView()
    private var _startCenter = CGPoint();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.layer.cornerRadius = 12;
        view.frame = CGRect(x:0, y:0 ,width: view.frame.width, height: view.frame.height)
        
        view.addSubview(profileView)
        profileView.frame = CGRect(x: 24, y:96, width: 350, height: 575)
        
        
    }
}

