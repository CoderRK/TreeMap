
#import "RKTreeMapView.h"
#import "RKTreeMapSingleModule.h"

@interface RKTreeMapView()

@end

@implementation RKTreeMapView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (RKTreeMapSingleModule *)setupModuleAtIndex:(NSInteger)index rect:(CGRect)rect
{
    RKTreeMapSingleModule *module = [[RKTreeMapSingleModule alloc] initWithFrame:rect];
    [self updateModule:module index:index];
    return module;
}

- (void)updateModule:(RKTreeMapSingleModule *)module index:(NSInteger)index
{
    module.index = index;
    module.text = self.textArray[index];
}

- (void)assembleModuleWithModules:(NSArray *)modules rect:(CGRect)rect size:(CGSize)size depth:(NSInteger)depth isCreated:(BOOL)isCreated
{
    if (modules.count <=1 )
    {
        NSInteger index = [[[modules objectAtIndex:0] valueForKey:@"index"] integerValue];
        if (isCreated || index >= self.subviews.count)
        {
            RKTreeMapSingleModule *module = [self setupModuleAtIndex:index rect:rect];
            module.index = index;
            [self addSubview:module];
        }
        else
        {
            RKTreeMapSingleModule *module = [self.subviews objectAtIndex:index];
            module.frame = rect;
            [self updateModule:module index:index];
            [module layoutSubviews];
        }
        return;
    }
    
    CGFloat sum = 0.0;
    for (NSDictionary *dict in modules)
    {
        sum += fabs([[dict objectForKey:@"value"] floatValue]);
    }
    
    CGFloat halfValue = sum/2.0;
    NSInteger flag = modules.count-1;
    sum = 0.0;
    for (NSInteger i=0;i<modules.count;i++)
    {
        if (sum>halfValue)
        {
            flag = i;
            break;
        }
        sum += fabs([[[modules objectAtIndex:i] objectForKey:@"value" ] floatValue]);
    }
    if (flag<1)flag=1;
    
    NSArray *preArray = [modules subarrayWithRange:NSMakeRange(0, flag)];
    NSArray *lastArray = [modules subarrayWithRange:NSMakeRange(flag, modules.count-flag)];
    CGFloat preSum = 0.0;
    for (NSDictionary *dict in preArray)
    {
        preSum += fabs([[dict objectForKey:@"value"] floatValue]);
    }
    CGFloat lastSum = 0.0;
    for (NSDictionary *dict in lastArray)
    {
        lastSum += fabs([[dict objectForKey:@"value"] floatValue]);
    }
    
    CGFloat preRate = (preSum + lastSum) > 0.0 ? (preSum/(preSum + lastSum)):0.5;
    CGRect preRect, lastRect;
    CGFloat preWidth, preHeight, lastWidth, lastHeight;
    BOOL horizontal = (size.width > size.height);//水平方向布局
    if (horizontal)
    {
        preWidth = ceil(size.width * preRate);
        lastWidth = size.width - preWidth;
        preHeight = lastHeight = size.height;
        preRect = CGRectMake(rect.origin.x, rect.origin.y, preWidth, preHeight);
        lastRect = CGRectMake(rect.origin.x + preWidth, rect.origin.y, lastWidth, lastHeight);
    }
    else
    {
        if (sum == 0.0)
        {
            preWidth = preHeight = lastWidth = lastHeight = 0.0;
            preRect = CGRectMake(rect.origin.x, rect.origin.y, 0.0, 0.0);
            lastRect = CGRectMake(rect.origin.x, rect.origin.y, 0.0, 0.0);
        }
        else
        {
            preWidth = lastWidth = size.width;
            preHeight = ceil(size.height * preRate);
            lastHeight = size.height - preHeight;
            preRect = CGRectMake(rect.origin.x, rect.origin.y, preWidth, preHeight);
            lastRect = CGRectMake(rect.origin.x, rect.origin.y + preHeight, lastWidth, lastHeight);
        }
    }
    [self assembleModuleWithModules:preArray rect:preRect size:CGSizeMake(preWidth, preHeight) depth:depth+1 isCreated:isCreated];
    [self assembleModuleWithModules:lastArray rect:lastRect size:CGSizeMake(lastWidth, lastHeight) depth:depth+1 isCreated:isCreated];
}

- (void)setData:(NSArray *)data
{
    data = [self sortArray:data];
    NSMutableArray *nodes = [NSMutableArray array];
    for (NSInteger i = 0; i < data.count; i++)
    {
        NSNumber *value = [data objectAtIndex:i];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        [dict setValue:[NSNumber numberWithInteger:i] forKey:@"index"];
        [dict setValue:value forKey:@"value"];
        [nodes addObject:dict];
    }
    _data = nodes;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self createModules];
}

- (void)setTextArray:(NSArray *)textArray
{
    _textArray = textArray;
}

- (void)createModules
{
    if (self.data && self.data.count > 0)
    {
        [self assembleModuleWithModules:self.data rect:self.bounds size:CGSizeMake(ceil(self.width), ceil(self.height)) depth:0 isCreated:YES];
    }
}

- (void)resizeModules
{
    if (self.data && self.data.count > 0)
    {
        [self assembleModuleWithModules:self.data rect:self.bounds size:CGSizeMake(ceil(self.width), ceil(self.height)) depth:0 isCreated:NO];
    }
}

- (NSArray *)sortArray:(NSArray *)datas
{
    NSArray *array = [datas sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        CGFloat cmp1 = fabs(obj1.floatValue);
        CGFloat cmp2 = fabs(obj2.floatValue);
        return [@(cmp2) compare:@(cmp1)];
    }];
    return array;
}

@end
