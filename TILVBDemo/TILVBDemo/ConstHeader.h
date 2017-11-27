//
//  ConstHeader.h
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/27.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#ifndef ConstHeader_h
#define ConstHeader_h

#define ShowAppId       @"1400027849"
#define ShowAccountType @"11656"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

/******************** default *****************************/
static const int kDefaultCellHeight = 44;
static const int kDefaultMargin = 8;

/******************** color ******************************/
#define RGBOF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define kColorGray       RGBOF(0xF0E0F0)
#define kColorRed        RGBOF(0xF4515E)
#define kColorLightGray  RGBOF(0xF3F3F3)
#define kColorWhite      [UIColor whiteColor]
#define kColorBlack      [UIColor blackColor]

/******************** font ********************************/
#define kAppLargeTextFont       [UIFont systemFontOfSize:17]
#define kAppMiddleTextFont      [UIFont systemFontOfSize:15]
#define kAppSmallTextFont       [UIFont systemFontOfSize:13]



/******************** role string **********************/
#define kSxbRole_HostHD     @"HD"
#define kSxbRole_HostSD     @"SD"
#define kSxbRole_HostLD     @"LD"

/******************** local param **********************/
#define kLoginParam         @"kLoginParam"
#define kLoginIdentifier    @"kLoginIdentifier"
#define kLoginPassward      @"kLoginPassward"

#endif /* ConstHeader_h */
