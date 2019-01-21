//
//  UIImage+ScaleImage.h
//  AcneTreatment
//
//  Created by Facebook on 2018/8/3.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (ScaleImage)
/**
 *  将颜色转换成图片
 */
+(nullable UIImage *)imageWithColor:(UIColor *)color;
/**
 *  将颜色转换成图片 RGB
 */
+(nullable UIImage *)imageWithRGB:(int)color alpha:(float)alpha;
/**
 *  图片拉伸,适应空间,不改变像素
 */
+(nullable UIImage *)resizableImageWithSourceImage:(nonnull UIImage *)image;
/**
 *  压缩体积,像素不变
 */
+(nullable UIImage *)reduceImage:(nullable UIImage *)image percent:(float)percent;
/**
 *  图片压缩后再拉伸
 */
+(nullable UIImage *)resizableAndReduceImageWithSourceImage:(nullable UIImage *)sourceImage percent:(float)percent;
/**
 *   压缩到指定尺寸,较为清晰.
 */
+(nullable UIImage *)scaleFromImage:(nullable UIImage *)image scaledToSize:(CGSize)newSize;
/**
 *  压缩到指定尺寸,等比例压缩
 */
-(nullable __kindof UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
/**
 *  压缩到指定尺寸
 */
+(nullable  __kindof UIImage *)SourceImage:(nullable UIImage *)sourceImage targetSize:(CGSize)newSize;
/**
 *  加载Gif图片
 *
 *  @param resource bundle地址
 *
 *  @return 返回要加载的Gif图片
 */
+(nullable __kindof UIImage *)imageWithGif:(nullable NSString *)resource;

/**
 *  生成带水印的图片
 */
+(nullable __kindof UIImage *)GetWaterPrintedImageWithBackImage:(nullable __kindof UIImage *)backImage
                                andWaterImage:(nullable __kindof UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale;
/**
 *Fiter 方法设置高斯模糊
 */
+(nullable __kindof UIImage *)setGaussianBlur:(nullable __kindof UIImage *)img;
/**
 *设置高斯模糊
 */
+ (nullable __kindof UIImage *)boxblurImage:(nullable __kindof UIImage *)image withBlurNumber:(CGFloat)blur;
/**
 *防止图片压缩拉伸变形
 */
+ (nullable __kindof UIImage *)xzSizeImage:(nullable __kindof UIImageView *)currentImageView xzSizeRefresh:(nullable __kindof UIImage *)image;

+ ( nullable __kindof UIImage *)reSizeImage:(nullable __kindof UIImage *)image toSize:(CGSize)reSize;
@end
