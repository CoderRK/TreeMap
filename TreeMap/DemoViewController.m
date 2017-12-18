

#import "DemoViewController.h"
#import "RKTreeMapView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = [NSArray arrayWithObjects:@"6.0",@"6.0",@"4.0",@"3.0",@"2.0",@"2.0",@"1.0",@"14.0",@"13.0",@"12.0",@"22.4898",@"18.0",@"66.0",@"56.0",@"54.0",@"43.8",@"42.768",@"32.0",@"31.0",@"14.0",@"13.0",@"12.0",@"2.0",@"1.0",nil];
    NSArray *textArr = [NSArray arrayWithObjects:@"平安银行",@"中国银行",@"浦发银行",@"阿里巴巴",@"腾讯控股",@"永辉超市",@"五粮液",@"中兴通讯",@"梦网集团",@"海泰发展",@"乐山电力",@"南方轴承",@"华能水电",@"山西焦化",@"西部黄金",@"红太阳",@"沃特股份",@"奥菲娱乐",@"中华企业",@"文一科技",@"川化股份",@"石英股份",@"天马股份",@"好太太",nil];
    
    RKTreeMapView *treeMap = [[RKTreeMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-70)];
    treeMap.textArray = textArr;
    treeMap.data = array;
    [self.view addSubview:treeMap];
    
}

@end
