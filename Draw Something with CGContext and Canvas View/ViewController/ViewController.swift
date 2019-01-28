//
//  ViewController.swift
//  Draw Something with CGContext and Canvas View
//
//  Created by 洪森達 on 2019/1/28.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    let canvas = Canvas()
    
    override func loadView() {
        
        view = canvas
        
    }
    
    lazy var undo = createButton(selector: #selector(handleUndo), name: "undo")
    lazy var clear = createButton(selector: #selector(handleClear), name: "Clear")
    
    let blueButton:UIButton = {
        let btn = UIButton()
            btn.backgroundColor = .blue
            btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return btn
    }()
    
    
    let yellowButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .yellow
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return btn
    }()
    
    
    let redButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(handleColor), for: .touchUpInside)
        return btn
    }()
    
    let slider:UISlider = {
        let sl = UISlider()
            sl.minimumValue = 1
            sl.maximumValue = 10
        sl.addTarget(self, action: #selector(handleStrokeWith), for: .valueChanged)
        sl.translatesAutoresizingMaskIntoConstraints = false
        return sl
    }()
    
    @objc fileprivate func handleStrokeWith(){
        
        canvas.strokeWidth = CGFloat(slider.value)
    }
    
    
    @objc fileprivate func handleColor(button:UIButton){
        
        canvas.strokeColor = button.backgroundColor ?? .black
        
    }
    
    
    @objc fileprivate func handleUndo(){
    
        canvas.undo()
    }
    
    
    @objc fileprivate func handleClear(){
        canvas.clear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = UIColor(white: 0.95, alpha: 1)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        
        let colorStack = UIStackView(arrangedSubviews: [blueButton,yellowButton,redButton])
        
        colorStack.distribution = .fillEqually
        
        slider.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [undo,clear,colorStack,slider])
            stackView.spacing = 16
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-16).isActive = true
        
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
  
    fileprivate func createButton(selector:Selector,name:String)->UIButton {
        
        let btn = UIButton(type: .system)
            btn.setTitle(name, for: .normal)
            btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
        
    }


}

