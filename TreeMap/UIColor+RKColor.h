
#import <UIKit/UIKit.h>

@interface UIColor (RKColor)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;
@end
