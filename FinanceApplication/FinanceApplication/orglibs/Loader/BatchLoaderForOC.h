//
//  BatchLoaderForOC.h
//  BatchLoaderTest
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FileInfo.h"

typedef void (^LoadCompletionHandler)(UIImage*);//定义block结构
//@interface FileInfo: NSObject
//
//
//@end

//typedef struct {
//__unsafe_unretained NSString * url;
//__unsafe_unretained UIImage * image;
//}FileInfo;

@interface BatchLoaderForOC : NSObject

+(void)loadFile:(NSString*)url _:(LoadCompletionHandler)callBack;
+(void)loadFile:(NSString*)url target:(id)target andSelection:(SEL)action;

@end
