//
//  CustomImagePicker.h
//  CustomImagePicker
//
//  Created by Pulkit Rohilla on 12/04/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCell.h"

@class CustomImagePicker;

@protocol CustomImagePickerDelegate <NSObject>

-(CustomImagePicker *)didDoneWithIndex:(int)index;

@end

static dispatch_queue_t backgroundQueue;

@interface CustomImagePicker : UIViewController <UITableViewDelegate, UITableViewDataSource, GalleryDelegate>

@property (assign) id <CustomImagePickerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTableHeight;

@property (strong, nonatomic) NSArray *arrayOptions;
@property (strong, nonatomic) NSArray *arraySelectedImageIndexes;

- (IBAction)actionCancel:(id)sender;
- (IBAction)actionDone:(id)sender;

@end
