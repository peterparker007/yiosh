//
//  TableViewCell.h
//  ZapFashion
//
//  Created by bhumesh on 7/4/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *btnSelection;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property BOOL isSelected;
@end
