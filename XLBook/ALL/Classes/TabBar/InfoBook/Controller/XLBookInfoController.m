//
//  XLBookInfoController.m
//  XLBook
//
//  Created by Lee on 2019/11/1.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLBookInfoController.h"
#import "LNProfileTopView.h"
#import "UIView+NIB.h"

@interface XLBookInfoController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headerImage;
@property (nonatomic, weak) LNProfileTopView *topView;
@property (nonatomic, assign) NSUInteger hcSize;

@end
static NSString *const reuseId = @"cell";
@implementation XLBookInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
    LNProfileTopView *topView = [LNProfileTopView viewFromNib];
    topView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 200 / 375.0);
    [self.view addSubview:topView];
    self.topView = topView;
    [self.view addSubview:self.tableView];
    //LeeWeakSelf(self)
    [topView setClickHeadIcon:^(LNProfileTopView * view) {
        //[weakself pickPicture];
    }];
    
    _hcSize = [self folderSize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *arr = @[@"清除缓存"];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",arr[indexPath.row]];
    UILabel *hcLabel = [UILabel new];
    [hcLabel setFont:[UIFont systemFontOfSize:14]];
    [hcLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    hcLabel.frame = CGRectMake(kScreenWidth - 120, 1, 100, 50);
    hcLabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:hcLabel];
    hcLabel.text = [NSString stringWithFormat:@"%luM",(unsigned long)self.hcSize];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",arr[indexPath.row]]];
    CGSize itemSize = CGSizeMake(18, 18);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.frame.size.height+self.topView.frame.origin.y, kScreenWidth, kScreenHeight - self.topView.frame.size.height+self.topView.frame.origin.y) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self cleanUp];
    }
}

- (void)cleanUp
{
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要清除缓存?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新UI
            [self removeCache];
        });
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)removeCache{
    //===============清除缓存==============
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    if (files.count == 0) {
        //SHOW_TEXT(@"清除成功");
        NSLog(@"清除成功");
        return;
    }
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                //SHOW_TEXT(@"清除成功");
                NSLog(@"清除成功");
            }else{
                NSLog(@"清除失败");
                
            }
        }
    }
}

- (CGFloat)folderSize{
    CGFloat folderSize = 0.0;
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString *filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    return sizeM;
}




@end
