//
//  ViewController.m
//  MukiCoreTestApp
//
//  Created by Nikita Mosiakov on 29/08/16.
//  Copyright © 2016 Muki. All rights reserved.
//

#import "ViewController.h"

#import "MukiCupAPI.h"
#import "Utilities.h"

#define MAX_CUP_WIDTH       176.0f
#define MAX_CUP_HEIGHT      264.0f
#define CUP_IMAGE_SIZE CGSizeMake(MAX_CUP_WIDTH, MAX_CUP_HEIGHT)

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contrastLabel;
@property (weak, nonatomic) IBOutlet UILabel *startPointLabel;

@property (weak, nonatomic) IBOutlet UISlider *contrastSlider;

@property (weak, nonatomic) IBOutlet UITextField *cupIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointXTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointYTextField;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) MukiCupAPI *cupAPI;
@property (nonatomic) Utilities *utilities;

@end

@implementation ViewController

////===================================================================
#pragma mark -
#pragma mark - UIViewController life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.utilities = [Utilities new];
    self.contrastLabel.text = [NSString stringWithFormat:@"Contrast value: %f", self.contrastSlider.value];
}

////===================================================================
#pragma mark -
#pragma mark - IBAction

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    self.contrastLabel.text = [NSString stringWithFormat:@"Contrast value: %f", sender.value];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)dismiss:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)sendData:(id)sender
{
    NSString *cupIdentifier = [self cupIdentifierFromSN];
    self.cupAPI = [MukiCupAPI new];
    NSData *data = [NSData new];
    [self.cupAPI sendData:data toCup:cupIdentifier completion:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)sendImage:(id)sender
{
    NSString *cupIdentifier = [self cupIdentifierFromSN];
    self.cupAPI = [MukiCupAPI new];
    UIImage *image = [UIImage imageNamed:@"img"];
    
    CGFloat contrastValue = 3.0;
    UIImage *resultedImage = [self.utilities scaleAndCropImage:image size:CUP_IMAGE_SIZE];
    resultedImage = [self.utilities ditheringImage:resultedImage contrastValue:contrastValue];
    
    self.imageView.image = resultedImage;
    
    [self.cupAPI sendImage:image toCup:cupIdentifier completion:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)sendImageWithOptions:(id)sender
{
    NSString *cupIdentifier = [self cupIdentifierFromSN];
    self.cupAPI = [MukiCupAPI new];
    
    ImageProperties *imageProperties = [ImageProperties new];
    
    CGPoint point = CGPointMake(self.pointXTextField.text.floatValue, self.pointYTextField.text.floatValue);
    CGFloat contrast = self.contrastSlider.value;
    imageProperties.contrast = contrast;
    imageProperties.startPoint = point;

    UIImage *image = [UIImage imageNamed:@"img"];
    
    CGRect rect = CGRectMake(point.x, point.y, MAX_CUP_WIDTH, MAX_CUP_HEIGHT);
    UIImage *resultedImage = [self.utilities cropImage:image rect:rect];
    resultedImage = [self.utilities ditheringImage:resultedImage contrastValue:contrast];
    self.imageView.image = resultedImage;
    
    [self.cupAPI sendImage:image toCup:cupIdentifier withImageProperties:imageProperties completion:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)clear:(id)sender
{
    NSString *cupIdentifier = [self cupIdentifierFromSN];
    self.cupAPI = [MukiCupAPI new];
    [self.cupAPI clearCupWithIdentifier:cupIdentifier completion:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)readDeviceInfo:(id)sender
{
    NSString *cupIdentifier = [self cupIdentifierFromSN];
    self.cupAPI = [MukiCupAPI new];
    [self.cupAPI readDeviceInfoWithIdentifier:cupIdentifier completion:^(DeviceInfo * _Nullable deviceInfo, NSError * _Nullable error) {
        NSLog(@"%@", error);
        if (deviceInfo) {
            NSLog(@"%@", deviceInfo.description);
        }
    }];
}


////===================================================================
#pragma mark -
#pragma mark - Private methods

- (NSString *)cupIdentifierFromSN
{
    NSError *error;
    NSString *cupID = [MukiCupAPI cupIdentifierFromSerialNumber:self.cupIDTextField.text error:&error];
    NSLog(@"%@", error);
    return cupID;
}

@end
