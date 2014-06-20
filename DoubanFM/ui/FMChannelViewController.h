//
//  FMChannelViewController.h
//  DoubanFM
//
//  Created by nirvawolf on 19/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMApiRequestDelegate.h"

@interface FMChannelViewController : UIViewController<FMApiRequestDelegate,UITableViewDataSource,UITableViewDelegate>

@end
