//
//  TTMusicAlbumView.m
//  TikTok
//
//  Created by FaceBooks on 2019/1/23.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTMusicAlbumView.h"
@interface TTMusicAlbumView()
@property(nonatomic,strong)UIButton *album;
@property(nonatomic,strong)NSMutableArray<CALayer*>* noteLayers;
@property(nonatomic,strong)UIImageView *albumImageView;
@property(nonatomic,strong)CALayer *backgroudLayer;
@end
@implementation TTMusicAlbumView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 50, 50)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _noteLayers = [NSMutableArray arrayWithCapacity:0];
        
        _backgroudLayer = ({
            CALayer *iv = [CALayer layer];
            iv.frame = self.bounds;
            iv.contents = (id)[UIImage imageNamed:@"music_cover"].CGImage;
            [self.layer addSublayer:iv];
            iv;
        });
        
        _albumImageView = ({
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectZero];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.layer.cornerRadius = 15.0f;
            iv.clipsToBounds =YES;
            [self addSubview:iv];
            iv;
        });
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroudLayer.frame = self.bounds;
    [self.albumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30.0f, 30.0f));
    }];
}

-(void)setAlbumURL:(NSString *)albumURL{
    _albumURL = albumURL;
    [self.albumImageView sd_setImageWithURL:[NSURL URLWithString:albumURL] placeholderImage:[UIImage imageNamed:@"music_cover"]];
}

- (void)startAnimation:(CGFloat)rate {
     rate = rate <= 0 ? 15 : rate;
    [self resetView];
    
    [self startSwamAnimation:@"icon_home_musicnote1" delayTime:0.0f rate:rate];
    [self startSwamAnimation:@"icon_home_musicnote2" delayTime:1.0f rate:rate];
    [self startSwamAnimation:@"icon_home_musicnote1" delayTime:2.0f rate:rate];
    ///旋转动画
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = [NSNumber numberWithFloat:M_PI*2.0]; ///旋转角度
    rotation.duration = 4.0f; ///旋转时间
    rotation.cumulative = YES;
    rotation.repeatCount = MAXFLOAT;  ///无线重复
    [self.layer addAnimation:rotation forKey:@"rotation"];
}

-(void)startSwamAnimation:(NSString *)imageName delayTime:(NSTimeInterval)delayTime rate:(CGFloat)rate{
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
    animationGroup.duration = rate/4.0f;
    animationGroup.beginTime = CACurrentMediaTime() + delayTime;
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;  ///layer会一直保持着动画最后的状态
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];  ///动画的速度变化
    
    //bezier路径帧动画
    CAKeyframeAnimation * pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGFloat sideXLength = 40.0f;
    CGFloat sideYLength = 100.0f;
    
    CGPoint beginPoint = CGPointMake(CGRectGetMidX(self.bounds) - 5, CGRectGetMaxY(self.bounds));
    CGPoint endPoint = CGPointMake(beginPoint.x - sideXLength, beginPoint.y - sideYLength);
    NSInteger controlLength = 60;
    
    CGPoint controlPoint = CGPointMake(beginPoint.x - sideXLength/2.0f - controlLength, beginPoint.y - sideYLength/2.0f + controlLength);
    
    UIBezierPath *customPath = [UIBezierPath bezierPath];
    [customPath moveToPoint:beginPoint];
    [customPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    pathAnimation.path = customPath.CGPath;
    
    
    //旋转帧动画
    CAKeyframeAnimation * rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    [rotationAnimation setValues:@[
                                   [NSNumber numberWithFloat:0],
                                   [NSNumber numberWithFloat:M_PI * 0.10],
                                   [NSNumber numberWithFloat:M_PI * -0.10]]];
    //透明度帧动画
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [opacityAnimation setValues:@[
                                  [NSNumber numberWithFloat:0],
                                  [NSNumber numberWithFloat:0.2f],
                                  [NSNumber numberWithFloat:0.7f],
                                  [NSNumber numberWithFloat:0.2f],
                                  [NSNumber numberWithFloat:0]]];
    //缩放帧动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.fromValue = @(1.0f);
    scaleAnimation.toValue = @(2.0f);
    
    [animationGroup setAnimations:@[pathAnimation, scaleAnimation,  rotationAnimation,opacityAnimation]];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.opacity = 0.0f;
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:imageName].CGImage);
    layer.frame = CGRectMake(beginPoint.x, beginPoint.y, 10, 10);
    [self.layer addSublayer:layer];
    [_noteLayers addObject:layer];
    [layer addAnimation:animationGroup forKey:nil];
}


-(void)resetView{
    [_noteLayers enumerateObjectsUsingBlock:^(CALayer * noteLayer, NSUInteger idx, BOOL *stop) {
        [noteLayer removeFromSuperlayer];
    }];
    [self.layer removeAllAnimations];
}

@end
