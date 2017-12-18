
#import "RKTreeMapSingleModule.h"

#define RKRandomColor RKColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define RKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface RKTreeMapSingleModule()
@property(nonatomic, weak) UILabel *stockNameLabel;
@end

@implementation RKTreeMapSingleModule
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        CGFloat scale = [[UIScreen mainScreen] scale];
        CGFloat width = scale > 0.0 ? 1.0 / scale : 0.5;
        [self.layer setBorderWidth:width];
        self.layer.borderColor = [[UIColor colorWithHexString:@"#191919"]CGColor];
        self.backgroundColor = RKRandomColor;
        
        UILabel *stockNameLabel = [[UILabel alloc] init];
        stockNameLabel.textColor = [UIColor whiteColor];
        stockNameLabel.textAlignment = NSTextAlignmentCenter;
        stockNameLabel.font = [UIFont systemFontOfSize:18];
        stockNameLabel.adjustsFontSizeToFitWidth = YES;
        stockNameLabel.minimumScaleFactor = 0.1;
        stockNameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self addSubview:stockNameLabel];
        self.stockNameLabel = stockNameLabel;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    self.stockNameLabel.text = text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"-------第%ld个module被点击了---------",(long)self.index);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     self.stockNameLabel.frame = CGRectMake(0, self.height/2.0 - 10, self.width, 20);
}

@end
