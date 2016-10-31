//
//  MukiCupError.h
//  MukiCupAccess
//
//  Created by Nikita Mosiakov on 29/08/16.
//  Copyright © 2016 Muki. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const MukiCupErrorDomain;

NS_ENUM(NSInteger)
{
    MukiCupErrorUnknown = -1,
    
    MukiCupErrorDataLength = -2000,
    MukiCupErrorBadImage = -2001,
    
    MukiCupErrorCannotConnectToCup = -2100,
    
    MukiCupErrorBluetoothPoweredOff = -2200,
    MukiCupErrorBluetoothUnsupported = -2201,
    
    MukiCupErrorCupIdentifierNotFound = -2300,
    MukiCupErrorInvalidCupIdentifier = -2301
};