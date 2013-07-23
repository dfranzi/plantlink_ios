//
//  PLPlantDetailViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailViewController.h"

@interface PLPlantDetailViewController() {
@private
}

@end

@implementation PLPlantDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [plantTableView reloadData];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)dismissPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -
#pragma mark Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Cell_PlantsAll count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = Cell_PlantsAll[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *heights = @[[NSNumber numberWithInt:107],[NSNumber numberWithInt:127],[NSNumber numberWithInt:336],[NSNumber numberWithInt:123],[NSNumber numberWithInt:100],[NSNumber numberWithInt:55]];
    return [heights[indexPath.row] floatValue];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
