//
//  LiveListViewController.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/28.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "LiveListViewController.h"
#import "LiveListTableViewCell.h"

@interface LiveListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@end

@implementation LiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColorLightGray;
    [self setupViews];
}

- (void)setupViews
{
    _datas = [NSMutableArray array];
    _pageItem = [[RequestPageParamItem alloc] init];
    
    _listTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    _listTableView.rowHeight = 0.618 * ScreenWidth + 54 + 10;
    [self.view addSubview:_listTableView];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.separatorInset = UIEdgeInsetsZero;
}

#pragma mark - 加载更多
- (void)loadMore:(TCIVoidBlock)complete
{
    __weak typeof(self) ws = self;
    //向业务后台请求直播间列表
    RoomListRequest *listReq = [[RoomListRequest alloc] initWithHandler:^(BaseRequest *request) {
        RoomListRequest *wreq = (RoomListRequest *)request;
        [ws loadListSucc:wreq];
        if (complete)
        {
            complete();
        }
    } failHandler:^(BaseRequest *request) {
        NSLog(@"fail");
        if (complete)
        {
            complete();
        }
    }];
    listReq.token = [AppDelegate sharedAppDelegate].token;
    listReq.type = @"live";
    listReq.index = _pageItem.pageIndex;
    listReq.size = _pageItem.pageSize;
    listReq.appid = [ShowAppId intValue];
    [[WebServiceEngine sharedEngine] asyncRequest:listReq wait:YES];
}

- (void)loadListSucc:(RoomListRequest *)req
{
    RoomListRspData *respData = (RoomListRspData *)req.response.data;
    [_datas addObjectsFromArray:respData.rooms];
    _pageItem.pageIndex += respData.rooms.count;
    //_isCanLoadMore = respData.total > _pageItem.pageIndex;
    [_listTableView reloadData];
    //self.tableView.tableFooterView.hidden = YES;
//    if (_datas.count <= 0)
//    {
//        _noLiveLabel.hidden = NO;
//    }
//    else
//    {
//        _noLiveLabel.hidden = YES;
//    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveListTableViewCell"];
    if(cell == nil)
    {
        cell = [[LiveListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LiveListTableViewCell"];
    }
    if (_datas.count > indexPath.row)
    {
        [cell configWith:_datas[indexPath.row]];
    }
    return cell;
}
@end
