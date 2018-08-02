//
//  ApplicationAppearance.swift
//  ImageCacheDemo
//
//  Created by Abhinay on 02/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class ApplicationAppearence
{
    static func initialAppearance()
    {
        UIApplication.shared.statusBarStyle = .lightContent
        
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 27.0)]
        
    }
}
