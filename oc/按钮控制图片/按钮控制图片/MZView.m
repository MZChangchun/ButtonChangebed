//
//  MZView.m
//  按钮控制图片
//
//  Created by Mr.Yang on 16/9/19.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "MZView.h"

#define phoneHeigh [UIScreen mainScreen].bounds.size.height
#define phoneWidth [UIScreen mainScreen].bounds.size.width
#define yeCol [UIColor colorWithRed:222/255.0 green:171/255.0 blue:72/255.0 alpha:1]

#define everyHeigh 5.0f
@implementation MZView{
    
    int leftCenter;
    int rightCenter;
    
    int touHeigh;
    int zhongHeigh;
    
}
- (instancetype)init {
    self = [super init];
    if (self) {
        leftCenter = phoneHeigh / 3.0;
        rightCenter = phoneHeigh / 3.0;
        
        touHeigh = 0;
        zhongHeigh = 0;
        
        self.backgroundColor = yeCol;
        self.frame = [UIScreen mainScreen].bounds;
        
        for (int i = 0; i < 4; i++) {
            UIButton *butt1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            butt1.tag = i + 100;
            butt1.backgroundColor = [UIColor greenColor];
            [self addSubview:butt1];
            butt1.center = CGPointMake((0 ==i % 2) ? phoneWidth / 2.0 - 25 : phoneWidth / 2.0 + 25, phoneHeigh / 4 * 3.0 + 50 * (i / 2));
            [butt1 addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

//改变图形
- (void)changeImage:(UIButton *)but {
    switch (but.tag) {
        case 100:{
            touHeigh += 1;
            if (2 == touHeigh) {
                touHeigh = 1;
            } else {
                leftCenter = phoneHeigh / 3.0 - (touHeigh * everyHeigh);
                [self setNeedsDisplay];
            }
        }
            break;
        case 101:{
            zhongHeigh += 1;
            if (2 == zhongHeigh) {
                zhongHeigh = 1;
            } else {
                rightCenter = phoneHeigh / 3.0 - (zhongHeigh * everyHeigh);
                [self setNeedsDisplay];
            }
        }
            break;
        case 102:{
            touHeigh -= 1;
            if (-2 == touHeigh) {
                touHeigh = -1;
            } else {
                leftCenter = phoneHeigh / 3.0 - (touHeigh * everyHeigh);
                [self setNeedsDisplay];
            }
        }
            break;
        case 103:{
            zhongHeigh -= 1;
            if (-2 == zhongHeigh) {
                zhongHeigh = -1;
            } else {
                rightCenter = phoneHeigh / 3.0 - (zhongHeigh * everyHeigh);
                [self setNeedsDisplay];
            }
        }
            break;
            
        default:
            break;
    }
    NSLog(@"dasdsadsa");
}
-(void)drawRect:(CGRect)rect {
//    CGFloat lineWidth = 25.0f;
//    
//    CGColorRef color1 = [UIColor redColor].CGColor;
//    CGContextRef ctx1 = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(ctx1, color1);
//    CGContextSetLineWidth(ctx1, lineWidth);
//    CGContextMoveToPoint(ctx1, phoneWidth / 4.0, leftCenter);//开始的中间坐标
//    CGContextAddLineToPoint(ctx1, phoneWidth / 2.0, rightCenter);//结束的中间坐标
//    CGContextStrokePath(ctx1);
//    
//    
//    CGColorRef color = [UIColor redColor].CGColor;
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(ctx, color);
//    CGContextSetLineWidth(ctx, lineWidth);
//    CGContextMoveToPoint(ctx, phoneWidth / 2.0, rightCenter);//开始的中间坐标
//    CGContextAddLineToPoint(ctx, phoneWidth * 3.0 / 4.0, phoneHeigh / 3.0);//结束的中间坐标
//    CGContextStrokePath(ctx);
    //1.创建UIBezierPath

    [self drawSiBianTopLeft:CGPointMake(phoneWidth/4.0, leftCenter - 15)
                   topRight:CGPointMake(phoneWidth/2.0, rightCenter - 15)
                 bottomLeft:CGPointMake(phoneWidth/4.0, leftCenter + 15)
                bottomRight:CGPointMake(phoneWidth/2.0, rightCenter + 15)
                     isleft:1];
    
    [self drawSiBianTopLeft:CGPointMake(phoneWidth/2.0, rightCenter - 15)
                   topRight:CGPointMake(phoneWidth/4.0 * 3, phoneHeigh / 3.0 - 15)
                 bottomLeft:CGPointMake(phoneWidth/2.0, rightCenter + 15)
                bottomRight:CGPointMake(phoneWidth/4.0 * 3, phoneHeigh / 3.0 + 15)
                     isleft:0];
    
    //中间虚线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(phoneWidth/2.0, rightCenter - 15)];
    [path addLineToPoint:CGPointMake(phoneWidth/2.0, rightCenter + 15)];
    
    CGFloat dash[] = {4,4};
    
    /**
     *  设置路径线路的图案
     *
     *  @param pattern 线段和间隙的长度???  C类型数组
     *  @param count   图案的值??? pattern中数据个数
     *  @param phase   在该偏移开始绘制图案，在沿虚线图案点测量??? 起始位置
     */
    
    [path setLineDash:dash count:2 phase:0];
    [yeCol setStroke];
    [path stroke];
    
    //边线
    
}

- (void)drawSiBianTopLeft:(CGPoint)topLeftPoint topRight:(CGPoint)topRightPoint bottomLeft:(CGPoint)bottomLeftPoint bottomRight:(CGPoint)bottomRightPoint isleft:(BOOL)left{
    //1.创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2。设计路径
    [path moveToPoint:topLeftPoint];
    [path addLineToPoint:topRightPoint];
    [path addLineToPoint:bottomRightPoint];
    [path addLineToPoint:bottomLeftPoint];
    [path addLineToPoint:topLeftPoint];
    [path addLineToPoint:CGPointMake((topLeftPoint.x + topRightPoint.x) / 2.0, (topLeftPoint.y + topRightPoint.y) / 2.0)];
    //路径的其他设置
    path.lineWidth = 30;//粗细
    path.lineCapStyle = kCGLineCapRound;//线头样式
    path.lineJoinStyle = kCGLineJoinRound; //设置线头相交的部分
    //3.设计描边,填充
    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    //4.绘制
    [path stroke];
    [path fill];
}






























@end
