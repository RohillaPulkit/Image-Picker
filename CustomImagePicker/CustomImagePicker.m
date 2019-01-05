//
//  CustomImagePicker.m
//  CustomImagePicker
//
//  Created by Pulkit Rohilla on 12/04/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "CustomImagePicker.h"
#import "ImagePickerCell.h"
#import "GalleryCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation CustomImagePicker{
    
    NSMutableArray *imageArray;
    
    int selectedIndex;
}

@synthesize arrayOptions;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backgroundQueue = dispatch_queue_create("com.CustomImagePicker", NULL);

    selectedIndex = 0;
    
    // Do any additional setup after loading the view.
    imageArray = [NSMutableArray new];
    
    dispatch_async(backgroundQueue, ^{
        
        [self loadGalleryImages];
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self adjustTableHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrayOptions.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 100;
    }
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //cellGalleryIdentifier
        GalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellGalleryIdentifier"];
        cell.arrayImages = imageArray;
        [cell reloadGallery];
        
        return cell;
    }
    else
    {
        ImagePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIndentifier"];
        
        cell.lblTitle.text = [arrayOptions objectAtIndex:indexPath.row-1];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor clearColor];
        [cell setSelectedBackgroundView:bgColorView];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    selectedIndex = (int)indexPath.row;
    NSLog(@"%li",indexPath.row);
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return NO;
    }
    
    return YES;
}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove seperator inset
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    // Prevent the cell from inheriting the Table View's margin settings
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    
//    // Explictly set your cell's layout margins
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

#pragma mark - GalleryCellDelegate

-(void)didChangeSelectedIndexes:(NSArray *)indexes
{
    self.arraySelectedImageIndexes = indexes;

}

#pragma mark - UIBarButton

- (IBAction)actionCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionDone:(id)sender {

    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate didDoneWithIndex:selectedIndex];
        
    }];
}


#pragma mark - OtherMethods

-(void)adjustTableHeight{
    
    _constraintTableHeight.constant = 44*arrayOptions.count+100;

}

-(void)loadGalleryImages{
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        // Within the group enumeration block, filter to enumerate just photos.
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        
        // Chooses the photo at the last index
        [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
            // The end of the enumeration is signaled by asset == nil.
            if (alAsset && imageArray.count < 5) {
            
                UIImage *photo =  [UIImage imageWithCGImage:[[alAsset defaultRepresentation] fullScreenImage]];
                UIImage *thumbnail =  [UIImage imageWithCGImage:[alAsset thumbnail]];
                
                NSDictionary *imageDict = @{@"photo":photo,
                                            @"thumbnail":thumbnail};
                
                [imageArray addObject:imageDict];
                
            }
            else{
                
                *stop = YES;
                *innerStop = YES;
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                });

            }
        }];
        
    } failureBlock: ^(NSError *error) {
        // Typically you should handle an error more gracefully than this.
        NSLog(@"No groups");
    }];
}

@end
