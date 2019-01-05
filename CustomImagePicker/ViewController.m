//
//  ViewController.m
//  CustomImagePicker
//
//  Created by Pulkit Rohilla on 12/04/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionShowImage:(id)sender {
    
    NSArray *options = [NSArray arrayWithObjects:@"Choose from library",@"Take photo", nil];
    
    CustomImagePicker *picker = [self.storyboard instantiateViewControllerWithIdentifier:@"ImagePicker"];
    picker.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.2f];
    picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    picker.arrayOptions = options;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

@end
