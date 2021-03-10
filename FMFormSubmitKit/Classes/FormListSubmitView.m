//
//  FormListSubmitView.m
//  FormSubmitList
//
//  Created by 周发明 on 2020/4/17.
//  Copyright © 2020 周发明. All rights reserved.
//

#import "FormListSubmitView.h"


@interface FormListSubmitView ()

@end

@implementation FormListSubmitView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.handle = [[FormListHandle alloc] initWithTableView:self];
    }
    return self;
}

- (void)reloadData{
    [self.handle registerCell];
    [super reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:FormSubmitModelValueChangeNotiKey object:nil];
}

- (void)setHandle:(FormListHandle *)handle{
    _handle = handle;
    self.dataSource = handle;
    self.delegate = handle;
}

@end
