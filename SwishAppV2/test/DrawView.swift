//
//  DrawView.swift
//  PhotoEditing
//
//  Created by issd on 14/06/2018.
//  Copyright © 2018 issd. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var penSize: CGFloat!
    var bezierPath: UIBezierPath!
    var lastDot: CGPoint!
    var renderImg: UIImage!
    var penColor: UIColor!
    
    public var savedImage: UIImage!
    
    private func BezierPathSet(){
        bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = CGLineCap.round
        bezierPath.lineJoinStyle = CGLineJoin.round
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        penColor = UIColor.black
        penSize = 3
        BezierPathSet()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        penColor = UIColor.black
        penSize = 3
        BezierPathSet()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first
        lastDot = touch!.location(in: self)
    }
    func renderToImage() {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        if renderImg != nil {
            renderImg.draw(in: self.bounds)
        }
        
        bezierPath.lineWidth = penSize
        penColor.setFill()
        penColor.setStroke()
        bezierPath.stroke()
        
        renderImg = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first
        let newDot = touch!.location(in: self)
        
        bezierPath.move(to: lastDot)
        bezierPath.addLine(to: newDot)
        lastDot = newDot
        
        renderToImage()
        setNeedsDisplay()
        bezierPath.removeAllPoints()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setNeedsDisplay()
        bezierPath.removeAllPoints()
    }
    
    override func draw(_ rect: CGRect){
        super.draw(rect)
        
        if renderImg != nil {
            renderImg.draw(in: self.bounds)
        }
        
        bezierPath.lineWidth = penSize
        penColor.setFill()
        penColor.setStroke()
        bezierPath.stroke()
    }
    func embed(){
        
    }
    func clear() {
        renderImg = nil
        bezierPath.removeAllPoints()
        setNeedsDisplay()
        
    }

    func screenshot(){
        //Maybe the working code
        let view = self
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return}
        savedImage = image
        //save this as an image in the memory
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)        
    }

}
