//
//  UIImage+ScaleImage.m
//  AcneTreatment
//
//  Created by Facebook on 2018/8/3.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIImage+ScaleImage.h"

@implementation UIImage (ScaleImage)

+(nullable UIImage *)imageWithColor:(UIColor *)color{
     return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+(nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    return [UIImage imageWithColor:color size:size cornerRadius:0.0f];
}

+(nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    if (radius > 0.0f && radius <= size.width && radius <= size.height) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
        [color setFill];
        [path fill];
    } else {
        CGContextSetFillColorWithColor(ctx, color.CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    }
    CGContextRestoreGState(ctx);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(nullable UIImage *)imageWithRGB:(int)color alpha:(float)alpha{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[self colorWithRGB:color alpha:alpha] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}


+(nullable UIImage *)resizableImageWithSourceImage:(nonnull UIImage *)image{
    UIImage *newImage=[image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height*0.5, image.size.width*0.5, image.size.height*0.5-1, image.size.width*0.5-1) resizingMode:UIImageResizingModeTile];
    //Methd 2
  // UIImage *newImage = [image  stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    return newImage;

}
+(nullable UIImage *)reduceImage:(nullable UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage * newImage= [UIImage imageWithData:imageData];
    
    return newImage;
}
+(nullable UIImage *)resizableAndReduceImageWithSourceImage:(nullable UIImage *)sourceImage percent:(float)percent
{

    NSData *imageData = UIImageJPEGRepresentation(sourceImage, percent);
    UIImage *redouceImage = [UIImage imageWithData:imageData];
    UIImage *newImage=[redouceImage resizableImageWithCapInsets:UIEdgeInsetsMake(redouceImage.size.height*0.5, redouceImage.size.width*0.5, redouceImage.size.height*0.5-1, redouceImage.size.width*0.5-1) resizingMode:UIImageResizingModeTile];
    return newImage;
}
+(nullable UIImage *)scaleFromImage:(nullable UIImage *)image scaledToSize:(CGSize)newSize
{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if ((width <= newSize.width && height <= newSize.height) || (width == 0 || height == 0))
    {
        return image;
    }
    CGFloat widthFactor = newSize.width/width;
    CGFloat heightFactor = newSize.height/height;
    CGFloat scaleFactor = 0.0;
    if (widthFactor > heightFactor)
    {
        scaleFactor = widthFactor;
    }else
    {
        scaleFactor = heightFactor;
    }
    CGFloat scaleWidth = width * scaleFactor;
    CGFloat scaleHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaleWidth, scaleHeight);
    UIGraphicsBeginImageContext(targetSize);
    [image drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(nullable __kindof UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage =self;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaleWidth = targetWidth;
    CGFloat scaleHeight = targetHeight;
    CGPoint thumbnailPoint =CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor;
        }else
        {
            scaleFactor = heightFactor;

        }
        scaleWidth = width *scaleFactor ;
        scaleHeight = height * scaleFactor;
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaleHeight) * 0.5;
        }else if(widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaleWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaleWidth;
    thumbnailRect.size.height = scaleHeight;
    [sourceImage drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil)
    {
        NSLog(@"Image could not scale!");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
+(nullable  __kindof UIImage *)SourceImage:(nullable UIImage *)sourceImage targetSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(nullable __kindof UIImage *)imageWithGif:(nullable NSString *)resource
{
    NSString *path =[[NSBundle mainBundle] pathForResource:resource ofType:@"gif"];
    NSData *data =[NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage saka_animatedGIFWithData:data];
    return image;
}
+ (UIImage *)saka_animatedGIFWithData:(NSData *)data
{
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *staticImage;
    
    if (count <= 1) {
        staticImage = [[UIImage alloc] initWithData:data];
    } else {
        NSMutableArray *images =[NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i =0; i <count; i ++)
        {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            duration +=[UIImage frameDurationAtIndex:i Source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        staticImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return staticImage;
}
+(CGFloat)frameDurationAtIndex:(NSInteger)index Source:(CGImageSourceRef)source
{
    CGFloat frameDuration = 0.1f;
    CFDictionaryRef frame = CGImageSourceCopyPropertiesAtIndex(source, index, NULL);
    NSDictionary *frameProperties =(__bridge NSDictionary *)(frame);
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(frame);
    return frameDuration;
}
+(UIImage *)GetWaterPrintedImageWithBackImage:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale
{
    //说明，在最后UIImageView转UIImage的时候，View属性的size会压缩成1倍像素的size,所以本方法内涉及到Size的地方需要乘以2或3，才能保证最后的清晰度
    
    //默认制作X2像素，也可改成3或其它
    CGFloat clear = 2;
    
    UIImageView *backIMGV = [[UIImageView alloc]init];
    backIMGV.backgroundColor = [UIColor clearColor];
    backIMGV.frame = CGRectMake(0,
                                0,
                                backImage.size.width*clear,
                                backImage.size.height*clear);
    backIMGV.contentMode = UIViewContentModeScaleAspectFill;
    backIMGV.image = backImage;
    
    UIImageView *waterIMGV = [[UIImageView alloc]init];
    waterIMGV.backgroundColor = [UIColor clearColor];
    waterIMGV.frame = CGRectMake(waterRect.origin.x*clear,
                                 waterRect.origin.y*clear,
                                 waterRect.size.width*clear,
                                 waterRect.size.height*clear);
    if (waterScale) {
        waterIMGV.contentMode = UIViewContentModeScaleToFill;
    }else{
        waterIMGV.contentMode = UIViewContentModeScaleAspectFill;
    }
    waterIMGV.alpha = alpha;
    waterIMGV.image = waterImage;
    
    [backIMGV addSubview:waterIMGV];
    
    UIImage *outImage = [self imageWithUIView:backIMGV];
    
    return outImage;
}

+(UIImage *)imageWithUIView:(UIView *)view{
    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
}

+(UIImage *)setGaussianBlur:(UIImage *)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:img];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:8.0] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (UIImage *)xzSizeImage:(UIImageView *)currentImageView xzSizeRefresh:(UIImage *)image
{
    //要加载的图片取其宽和高中较小的那个值
    CGFloat widthAndH = (image.size.height>image.size.width)?image.size.width:image.size.height;
    
    CGRect rect;
    
    //要加载图片的UIImageView宽和高中较大的那个值 然后按照等比例去截取图片使其被压缩时不变形
    if (currentImageView.frame.size.height > currentImageView.frame.size.width) {
        
        rect = CGRectMake(0, 0, currentImageView.frame.size.width*widthAndH/currentImageView.frame.size.height, widthAndH);
        
    }else{
        
        rect = CGRectMake(0, 0, widthAndH, currentImageView.frame.size.height*widthAndH/currentImageView.frame.size.width);
        
    }
    
    UIImage *imageRegresh = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
    
    UIImage *xzSizeImage;
    
    //要判断将要压缩的图片的尺寸大小是不是大于我们想要的那个尺寸 在做相应处理
    if (widthAndH>currentImageView.frame.size.width*2 && widthAndH>currentImageView.frame.size.height*2) {
        
        CGSize size = CGSizeMake(currentImageView.frame.size.width*2, currentImageView.frame.size.height*2);
        
        xzSizeImage = [self reSizeImage:imageRegresh toSize:size];
        
    }else{
        
        xzSizeImage = imageRegresh;
        
    }
    
    return xzSizeImage;
}
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

@end
