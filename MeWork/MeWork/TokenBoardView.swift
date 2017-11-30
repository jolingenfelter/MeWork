//
//  TokenBoardView.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/27/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class TokenBoardView: UIView {

    let tokenNumber: Int
    let tokenImage: UIImage
    
    // MARK: - TokenButtons
    
    lazy public var token1: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token2: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token3: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token4: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token5: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token6: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token7: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token8: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token9: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy public var token10: UIButton = {
        let button = UIButton()
        button.imageView?.frame = button.frame
        button.imageView?.image = tokenImage
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Views to layout buttons
    
    lazy private var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token1)
        
        return view
    }()
    
    lazy private var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token2)
        
        return view
    }()
    
    lazy private var view3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token3)
        
        return view
    }()
    
    lazy private var view4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token4)
        
        return view
    }()
    
    lazy private var view5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token5)
        
        return view
    }()
    
    lazy private var view6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token6)
        
        return view
    }()
    
    lazy private var view7: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token7)
        
        return view
    }()
    
    lazy private var view8: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token8)
        
        return view
    }()
    
    lazy private var view9: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token9)
        
        return view
    }()
    
    lazy private var view10: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(token10)
        
        return view
    }()
    
    // MARK: - StackViews
   
    lazy private var stackView1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [self.view1, self.view2, self.view3, self.view4, self.view5])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        
        return view
    }()
    
    lazy private var stackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [self.view6, self.view7, self.view8, self.view9, self.view10])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        
        return view
    }()
    
    
    
    public init(tokenNumber: Int, tokenImage: UIImage, frame: CGRect) {
        self.tokenNumber = tokenNumber
        self.tokenImage = tokenImage
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(view1)
        self.addSubview(view2)
        self.addSubview(view3)
        self.addSubview(view4)
        self.addSubview(view5)
        self.addSubview(view6)
        self.addSubview(view7)
        self.addSubview(view8)
        self.addSubview(view9)
        self.addSubview(view10)
        
        setupStackViews()
        
    }
    
}

private extension TokenBoardView {
    
    func setup(button: UIButton, inView view: UIView) {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
            ])
    }
    
    func setupStackViews() {
        
        setup(button: token1, inView: view1)
        setup(button: token2, inView: view2)
        setup(button: token3, inView: view3)
        setup(button: token4, inView: view4)
        setup(button: token5, inView: view5)
        
        if tokenNumber <= 5 {
            
            self.addSubview(stackView1)
            
            NSLayoutConstraint.activate([
                stackView1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                stackView1.topAnchor.constraint(equalTo: self.topAnchor),
                stackView1.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                stackView1.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4
                )])
            
        } else {
            
            setup(button: token6, inView: view6)
            setup(button: token7, inView: view7)
            setup(button: token8, inView: view8)
            setup(button: token9, inView: view9)
            setup(button: token10, inView: view10)
            
            self.addSubview(stackView1)
            self.addSubview(stackView2)
            
            NSLayoutConstraint.activate([
                stackView1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                stackView1.trailingAnchor.constraint(equalTo: self.centerXAnchor),
                stackView1.topAnchor.constraint(equalTo: self.topAnchor),
                stackView1.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])
            
            NSLayoutConstraint.activate([
                stackView2.leadingAnchor.constraint(equalTo: self.centerXAnchor),
                stackView2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                stackView2.topAnchor.constraint(equalTo: self.topAnchor),
                stackView2.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])
            
        }
    }
}
