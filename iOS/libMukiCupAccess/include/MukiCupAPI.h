//
//  MukiCupAPI.h
//  MukiCupAccess
//
//  Created by Nikita Mosiakov on 29/08/16.
//  Copyright © 2016 Muki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageProperties.h"
#import "MukiCupError.h"
#import "DeviceInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MukiCupAPI : NSObject

+ (NSString * _Nullable)cupIdentifierFromSerialNumber:(NSString *)serialNumber error:(NSError **)error;

- (void)sendData:(NSData *)data toCup:(NSString *)cupID completion:(void(^_Nullable)(NSError * _Nullable error))completion;
- (void)sendImage:(UIImage *)image toCup:(NSString *)cupID completion:(void(^_Nullable)(NSError * _Nullable error))completion;
- (void)sendImage:(UIImage *)image toCup:(NSString *)cupID withImageProperties:(ImageProperties * _Nullable)properties completion:(void(^_Nullable)(NSError * _Nullable error))completion;

- (void)clearCupWithIdentifier:(NSString *)cupID completion:(void(^_Nullable)(NSError * _Nullable error))completion;

- (void)readDeviceInfoWithIdentifier:(NSString *)cupID completion:(void(^_Nullable)(DeviceInfo * _Nullable deviceInfo, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
