//
//  GofConstant.h
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#ifndef GofConstant_h
#define GofConstant_h

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

/**
 * 快速生成颜色
 */
// color
///< format：0xFFFFFF
#define k16RGBColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
///< format：22,22,22
#define kRGBColor(r, g, b) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue:(b) / 255.0  \
alpha:1])
///< format：22,22,22,0.5
#define kRGBAColor(r, g, b, a) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue:(b) / 255.0  \
alpha:(a)])

#define kEssentialColor k16RGBColor(0x46a0f0)

/**
 * 通用的空闭包类型，无参数，无返回值
 */
typedef void (^GofVoidBlock)(void);

/**
 * 常用的返回Bool类型的Block类型
 *
 * @param result 返回结果，BOOL类型，通常是判断成功与失败
 */
typedef void (^GofBoolBlock)(BOOL result);

/**
 * 常用的返回Bool类型和相应提示语的Block类型
 *
 * @param result 返回结果，BOOL类型，通常是判断成功与失败
 * @param errorMsg 返回提示语，通常是成功与失败对应的提示语
 */
typedef void (^GofBoolMsgBlock)(BOOL result, NSString *errorMsg);

/**
 * 常用的返回数组类型的Block类型
 *
 * @param resultList 数组，通常是接口返回数据源为一个数组时使用
 */
typedef void (^GofArrayBlock)(NSArray *resultList);

/**
 * 常用的返回数组类型和错误提示语的Block类型
 *
 * @param resultList 数组，通常是接口返回数据源为一个数组时使用
 * @param errorMsg 如果出现错误，可以返回对应的错误提示，否则置为nil即可
 */
typedef void (^GofArrayMsgBlock)(NSArray *resultList, NSString *errorMsg);

/**
 * 常用的返回字典类型的Block类型
 *
 * @param resultDict 结果字典，通常是接口返回数据源为一个字典时使用
 */
typedef void (^GofDictionaryBlock)(NSDictionary *resultDict);

/**
 * 常用的返回字典类型的Block类型
 *
 * @param resultDict 结果字典，通常是接口返回数据源为一个字典时使用
 * @param errorMsg 如果出现错误，可以返回对应的错误提示，否则置为nil即可
 */
typedef void (^GofDictionaryMsgBlock)(NSDictionary *resultDict, NSString *errorMsg);

/**
 * 常用的返回基本类型的Block类型
 *
 * @param resultNumber 返回的结果，通常是接口返回数据源为一个基本类型时使用
 */
typedef void (^GofNumberBlock)(NSNumber *resultNumber);

/**
 * 常用的返回基本类型的Block类型
 *
 * @param resultNumber 返回的结果，通常是接口返回数据源为一个基本类型时使用
 * @param errorMsg 如果出现错误，可以返回对应的错误提示，否则置为nil即可
 */
typedef void (^GofNumberMsgBlock)(NSNumber *resultNumber, NSString *errorMsg);

/**
 * 常用的返回NSInteger类型的Block类型
 *
 * @param resultNumber 返回的结果，通常是接口返回数据源为一个NSInteger类型时使用
 */
typedef void (^GofIntegerBlock)(NSInteger resultNumber);

/**
 * 常用的返回NSInteger类型的Block类型
 *
 * @param resultNumber 返回的结果，通常是接口返回数据源为一个NSInteger类型时使用
 * @param errorMsg 如果出现错误，可以返回对应的错误提示，否则置为nil即可
 */
typedef void (^GofIntegerMsgBlock)(NSInteger resultNumber, NSString *errorMsg);

/**
 * 常用的返回NSString类型的Block类型
 *
 * @param result 返回的结果，通常是接口返回数据源为一个NSString类型时使用
 */
typedef void (^GofStringBlock)(NSString *result);

/**
 * 常用的返回NSString类型的Block类型
 *
 * @param result 返回的结果，通常是接口返回数据源为一个NSString类型时使用
 * @param errorMsg 如果出现错误，可以返回对应的错误提示，否则置为nil即可
 */
typedef void (^GofStringMsgBlock)(NSString *result, NSString *errorMsg);

/**
 * 常用的返回id类型的Block类型
 *
 * @param result 返回的结果，通常是接口返回数据源为一个id类型时使用
 */
typedef void (^GofIdBlock)(id result);

/**
 * 常用的返回id类型的Block类型
 *
 * @param result 返回的结果，通常是接口返回数据源为一个id类型时使用
 * @param errorMsg 如果出现错误，可以返回对应的错误提示，否则置为nil即可
 */
typedef void (^GofIdMsgBlock)(id result, NSString *errorMsg);

#endif /* GofConstant_h */
