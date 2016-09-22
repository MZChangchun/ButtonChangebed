//
//  MZView.swift
//  SwiftTest
//
//  Created by Mr.Yang on 16/9/21.
//  Copyright © 2016年 MZ. All rights reserved.
//

import UIKit

let  phoneHeigh = UIScreen.main.bounds.size.height
let  phoneWidth = UIScreen.main.bounds.size.width
let  yeCol = UIColor.init(red: 222/255.0, green: 171/255.0, blue: 72/255.0, alpha: 1);
let  everyHeigh  = 5.0;
class MZView: UIView {
    
    var leftCenter = phoneHeigh / 3.0;
    var rightCenter = phoneHeigh / 3.0;
    
    var touHeigh = 0.0;
    var zhongHeigh = 0.0;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.normalCreateButton();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.normalCreateButton();
    }
    
    func normalCreateButton() {
        self.frame = UIScreen.main.bounds;
        self.backgroundColor = yeCol;
        
        for i in 0..<4 {
            let butt = UIButton.init();
            butt.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
            butt.center = CGPoint.init(x: (0 == i % 2) ? phoneWidth / 2 - 25 : phoneWidth / 2 + 25, y: phoneHeigh / 4 * 3 + 50.0 * CGFloat(i / 2));
            butt.tag = i + 100;
            butt.backgroundColor = UIColor.green;
            self.addSubview(butt);
            butt.addTarget(self, action: #selector(changeImage(butt:)), for: UIControlEvents.touchUpInside)
        }

    }
    
    func changeImage(butt : UIButton) {
        switch butt.tag {
        case 100:
            self.touHeigh += 1;
            if (2 == self.touHeigh) {
                self.touHeigh = 1;
            } else {
                leftCenter = phoneHeigh / 3.0 - CGFloat(touHeigh * everyHeigh);
                self.setNeedsDisplay();
            }
        
        case 101:
            self.zhongHeigh += 1;
            if (2 == self.zhongHeigh) {
                self.zhongHeigh = 1;
            } else {
                rightCenter = phoneHeigh / 3.0 - CGFloat(zhongHeigh * everyHeigh);
                self.setNeedsDisplay();
            }
            
        case 102:
            self.touHeigh -= 1;
            if (-2 == self.touHeigh) {
                self.touHeigh = -1;
            } else {
                leftCenter = phoneHeigh / 3.0 - CGFloat(touHeigh * everyHeigh);
                self.setNeedsDisplay();
            }
            
        case 103:
            self.zhongHeigh -= 1;
            if (-2 == self.zhongHeigh) {
                self.zhongHeigh = -1;
            } else {
                rightCenter = phoneHeigh / 3.0 - CGFloat(zhongHeigh * everyHeigh);
                self.setNeedsDisplay();
            }

        default: break
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.drawSiBianTopLeft(topLeftPoint: CGPoint.init(x: phoneWidth/4.0, y: leftCenter - 15),
                               topRightPoint: CGPoint.init(x: phoneWidth/2.0, y: rightCenter - 15),
                               bottomLeftPoint: CGPoint.init(x: phoneWidth/4.0, y: leftCenter + 15),
                               bottomRightPoint: CGPoint.init(x: phoneWidth/2.0, y: rightCenter + 15),
                               left: true);
        
        self.drawSiBianTopLeft(topLeftPoint: CGPoint.init(x: phoneWidth/2.0, y: rightCenter - 15),
                               topRightPoint: CGPoint.init(x: phoneWidth/4.0 * 3, y: phoneHeigh / 3.0 - 15),
                               bottomLeftPoint: CGPoint.init(x: phoneWidth/2.0, y: rightCenter + 15),
                               bottomRightPoint: CGPoint.init(x: phoneWidth/4.0 * 3, y: phoneHeigh / 3.0 + 15),
                               left: false);
        let path = UIBezierPath.init();
        path.move(to: CGPoint.init(x: phoneWidth/2.0, y: rightCenter - 15));
        path.addLine(to: CGPoint.init(x: phoneWidth/2.0, y: rightCenter + 15));
        
        let dash:[CGFloat] = [4,4];
        
        path.setLineDash(dash, count: 2, phase: 0)
        yeCol.setStroke();
        path.stroke();
        
    }
    func drawSiBianTopLeft(topLeftPoint:CGPoint, topRightPoint:CGPoint, bottomLeftPoint:CGPoint, bottomRightPoint:CGPoint, left:Bool) {
        let path = UIBezierPath.init();
        
        path.move(to: topLeftPoint);
        path.addLine(to: topRightPoint);
        path.addLine(to: bottomRightPoint);
        path.addLine(to: bottomLeftPoint);
        path.addLine(to: topLeftPoint);
        path.addLine(to: CGPoint.init(x: (topLeftPoint.x + topRightPoint.x) / 2.0, y: (topLeftPoint.y + topRightPoint.y) / 2.0));
        
        path.lineWidth = 30;
        path.lineCapStyle = CGLineCap(rawValue: Int32(1))!;
        path.lineJoinStyle = CGLineJoin(rawValue: Int32(1))!;
        
        UIColor.white.setStroke();
        UIColor.white.setFill();
        
        path.stroke();
        path.fill();
    }
}





























