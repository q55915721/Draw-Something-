//
//  Canvas.swift
//  Draw Something with CGContext and Canvas View
//
//  Created by 洪森達 on 2019/1/28.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit


struct Line {
    let strokeColor:UIColor
    let strokeWidth:CGFloat
    var points:[CGPoint]
}


class Canvas : UIView {

    
    
    var strokeColor = UIColor.black
    var strokeWidth:CGFloat = 1
    
    
    
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
        
    }
    
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
     
        
        lines.forEach { (line) in
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.butt)
            context.setStrokeColor(line.strokeColor.cgColor)
            
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                }else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    
   fileprivate var lines = [Line]()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(strokeColor: strokeColor, strokeWidth: CGFloat(strokeWidth), points: []))
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else {return}
        
        
        guard var line = lines.popLast() else {return}
        
        line.points.append(point)
        
        lines.append(line)
        
        setNeedsDisplay()
        
        
        
    }
    
    
    
}
