//
//  DeviceInfo.h
//  MukiCupAccess
//
//  Created by Nikita Mosiakov on 22.09.16.
//  Copyright © 2016 Muki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

@property (nonatomic) NSString *modelNumber;
@property (nonatomic) NSString *manufacturerName;
@property (nonatomic) NSString *hardwareVersion;
@property (nonatomic) NSString *firmwareVersion;

@end
