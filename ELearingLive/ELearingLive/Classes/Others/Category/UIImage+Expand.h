//
//  UIlabel+JamesLabel.h
//  wwface
//
//  Created by James on 14/11/10.
//  Copyright (c) 2014年 fo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define JPEG_COMPRESSION_QUALITY 0.75f
#define PICTURE_LIMIT_SIZE_80 80
#define PICTURE_LIMIT_SIZE_160 160
#define PICTURE_LIMIT_SIZE_320 320
#define PICTURE_LIMIT_SIZE_640 640
#define PICTURE_LIMIT_SIZE_960 960
#define PICTURE_LIMIT_SIZE_1280 1280
#define PICTURE_LIMIT_SIZE_1920 1920

@interface UIImage (Expand)

+ (UIImage *)scaleImage:(UIImage *)image lessThanSize:(int)limitSize;

+ (UIImage *)scaleImageFromALAsset:(ALAsset *)asset lessThanSize:(int)limitSize;

+ (UIImage *)imageFromALAsset:(ALAsset *)asset;

+ (NSData *)scaleImageToData:(UIImage *)image lessThanSize:(int)limitSize;

+ (NSData *)imageToData:(UIImage *)image;

/**
 *  将图片的 imageOrientation 属性调整为 UIImageOrientationUp
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

-(UIImage*)transformWidth:(CGFloat)width
                   height:(CGFloat)height;

// 毛玻璃效果
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
