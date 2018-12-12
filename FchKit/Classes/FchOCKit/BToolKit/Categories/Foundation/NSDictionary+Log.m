//
//  NSDictionary+Log.m
//  Rail_hrb
//
//  Created by bai on 15/11/2.
//  Copyright © 2015年 bai.xianzhi. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

-(NSString *)descriptionWithLocale:(id)locale{
    NSArray *allKeys = [self allKeys];
       NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
        for (NSString *key in allKeys) {
             id value= self[key];
              [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
          }
        [str appendString:@"}"];
   
      return str;
}
@end
