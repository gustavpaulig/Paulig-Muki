//
//  Utilities.h
//  MukiCupAccess
//
//  Created by Nikita Mosiakov on 29/08/16.
//  Copyright © 2016 Muki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Utilities : NSObject

- (UIImage *)ditheringImage:(UIImage *)image contrastValue:(CGFloat)contrast;

- (UIImage *)cropImage:(UIImage *)originalImage rect:(CGRect)rect;
- (UIImage *)scaleAndCropImage:(UIImage *)originalImage size:(CGSize)targetSize;

- (NSData *)imageDataFromImage:(UIImage *)image;

@end
