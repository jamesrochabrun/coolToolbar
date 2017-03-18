//
//  ViewController.swift
//  CoolToolBar
//
//  Created by James Rochabrun on 3/18/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    var toggle = false
    let buttonSize: CGFloat = 60.0
    let profileSize: CGFloat = 100.0
    
    let mainSpace: CGFloat = 115
    let ySpace: CGFloat = 70
    let xSpace: CGFloat = 85
    
    var  normalStateConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var activeStateconstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    lazy var mainButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .blue
        b.layer.cornerRadius = 50
        b.layer.masksToBounds = true
        b.setImage(#imageLiteral(resourceName: "profile"), for: .normal)
        b.addTarget(self, action: #selector(showTools), for: .touchUpInside)
        return b
    }()
    
    let zoomOutbutton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(#imageLiteral(resourceName: "zooomOut"), for: .normal)
        b.alpha = 0
        return b
    }()
    
    let zoomInbutton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(#imageLiteral(resourceName: "zoomIn"), for: .normal)
        b.alpha = 0
        return b
    }()
    
    let glassesButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(#imageLiteral(resourceName: "3dIcon"), for: .normal)
        b.alpha = 0
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        
    }
    
    func setUpViews() {
        view.addSubview(zoomInbutton)
        view.addSubview(zoomOutbutton)
        view.addSubview(glassesButton)
        view.addSubview(mainButton)
        
        mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainButton.widthAnchor.constraint(equalToConstant: profileSize).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: profileSize).isActive = true
        mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -buttonSize).isActive = true
        
        //normalState anchors
        let zoomOutHeight = zoomOutbutton.heightAnchor.constraint(equalToConstant: buttonSize)
        let zoomOutWidth = zoomOutbutton.widthAnchor.constraint(equalToConstant: buttonSize)
        let zoomOutCenterX = zoomOutbutton.centerXAnchor.constraint(equalTo: mainButton.centerXAnchor)
        let zoomOutCenterY = zoomOutbutton.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor)
        
        let zoomInHeight = zoomInbutton.heightAnchor.constraint(equalToConstant: buttonSize)
        let zoomInWidth = zoomInbutton.widthAnchor.constraint(equalToConstant: buttonSize)
        let zoomInCenterX = zoomInbutton.centerXAnchor.constraint(equalTo: mainButton.centerXAnchor)
        let zoomInCenterY = zoomInbutton.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor)
        
        let glassesHeight = glassesButton.heightAnchor.constraint(equalToConstant: buttonSize)
        let glassesWidth = glassesButton.widthAnchor.constraint(equalToConstant: buttonSize)
        let glassesX = glassesButton.centerXAnchor.constraint(equalTo: mainButton.centerXAnchor)
        let glasseY = glassesButton.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor)
        
        normalStateConstraints.append(contentsOf: [zoomOutHeight, zoomOutWidth, zoomOutCenterX, zoomOutCenterY, zoomInHeight, zoomInWidth, zoomInCenterX, zoomInCenterY, glassesHeight, glassesWidth, glassesX, glasseY])
        NSLayoutConstraint.activate(normalStateConstraints)
        
        //active state anchors, not activated until mainButton toggles
        let glassesHeightactive = glassesButton.heightAnchor.constraint(equalToConstant: buttonSize)
        let glassesWidthactive = glassesButton.widthAnchor.constraint(equalToConstant: buttonSize)
        let glassesXactive = glassesButton.centerXAnchor.constraint(equalTo: mainButton.centerXAnchor)
        let glasseYactive = glassesButton.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor, constant: -mainSpace)
        
        let zoomInHeightactive = zoomInbutton.heightAnchor.constraint(equalToConstant: buttonSize)
        let zoomInWidthactive = zoomInbutton.widthAnchor.constraint(equalToConstant: buttonSize)
        let zoomInCenterXactive = zoomInbutton.centerXAnchor.constraint(equalTo: mainButton.centerXAnchor, constant: -xSpace)
        let zoomInCenterYactive = zoomInbutton.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor, constant: -ySpace)
        
        let zoomOutHeightactive = zoomOutbutton.heightAnchor.constraint(equalToConstant: buttonSize)
        let zoomOutWidthactive = zoomOutbutton.widthAnchor.constraint(equalToConstant: buttonSize)
        let zoomOutCenterXactive = zoomOutbutton.centerXAnchor.constraint(equalTo: mainButton.centerXAnchor, constant: xSpace)
        let zoomOutCenterYactive = zoomOutbutton.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor, constant: -ySpace)
        
        activeStateconstraints.append(contentsOf: [zoomOutHeightactive, zoomOutWidthactive, zoomOutCenterXactive, zoomOutCenterYactive, zoomInHeightactive, zoomInWidthactive, zoomInCenterXactive, zoomInCenterYactive, glassesHeightactive, glassesWidthactive, glassesXactive, glasseYactive])
    }
    
    func showTools() {
        
        toggle = !toggle
        
        if toggle {
            NSLayoutConstraint.deactivate(normalStateConstraints)
            NSLayoutConstraint.activate(activeStateconstraints)
            UIView.animate(withDuration: 0.3, animations: {
                self.zoomInbutton.alpha = 1.0
                self.zoomOutbutton.alpha = 1.0
                self.glassesButton.alpha = 1.0
                self.view.layoutIfNeeded()
            })
            
        } else {
            NSLayoutConstraint.deactivate(activeStateconstraints)
            NSLayoutConstraint.activate(normalStateConstraints)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.zoomInbutton.alpha = 0
                self.zoomOutbutton.alpha = 0
                self.glassesButton.alpha = 0
                self.view.layoutIfNeeded()
            })
            
        }
    }
}

