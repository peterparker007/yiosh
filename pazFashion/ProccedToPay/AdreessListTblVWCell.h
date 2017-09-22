//
//  AdreessListTblVWCell.h
//  ZapFashion
//
//  Created by bhumesh on 7/28/17.
//  Copyright © 2017 bhumesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdreessListTblVWCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextView *txtVW;
@property (strong, nonatomic) IBOutlet UIButton *btnSelection;
@property BOOL isSelected;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@end
