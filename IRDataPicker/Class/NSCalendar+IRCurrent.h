//
//  NSCalendar+IRCurrent.h
//  IRDataPicker
//
//  Created by Phil on 2019/7/11.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (IRCurrent)
@property (nonatomic, strong) NSDateComponents *currentComponents;
@end

NS_ASSUME_NONNULL_END
