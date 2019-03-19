//
//  ChurchTableViewCell.h
//  ScriptorSprint2
//
//  Created by Jower Garcia on 3/16/19.
//  Copyright © 2019 Adrian Garcia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChurchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end

NS_ASSUME_NONNULL_END
