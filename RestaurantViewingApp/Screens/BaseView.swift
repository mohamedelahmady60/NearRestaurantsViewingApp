//
//  BaseView.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit

@IBDesignable class BaseView: UIView {
    
    //initialize the view with a frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    //initialize the view. Called by the storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    
    func configure (){
        
    }
    
}
