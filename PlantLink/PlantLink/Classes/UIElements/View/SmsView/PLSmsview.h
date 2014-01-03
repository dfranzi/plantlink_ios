//
//  PLSmsView.h
//  PlantLink
//
//  Created by Robert Maciej Pieta on 1/1/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SmsViewDelegate <NSObject>
@required
-(void)trashPushed:(NSDictionary*)smsDict;
@end

@interface PLSmsView : UIView
@property(nonatomic, strong) id <SmsViewDelegate> delegate;
@property(nonatomic, strong) NSDictionary *dict;

@end
