//
//  JGOneController.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGOneController.h"
#import "JGCatergoryView.h"
#import "UIView+JGFrameExtension.h"
#import "UICollectionViewFlowLayout+JGFullItem.h"
#import "Masonry/Masonry.h"
#import "JGCollectionViewCell.h"


@interface JGOneController () <UICollectionViewDataSource, UICollectionViewDelegate, JGCatergoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;

@end

@implementation JGOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    //有导航控制器必须设置为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //主collectionView
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[JGCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
    //catergoryView
    JGCatergoryView * catergoryView = [JGCatergoryView new];
    //必须设置titles数据源
    catergoryView.titles = self.titles;
    //必须设置关联的scrollview
    catergoryView.scrollView = mainView;
    //代理监听点击;
    catergoryView.delegate = self;
    //设置文字左右渐变
    catergoryView.titleColorChangeGradually = YES;
    //开启底部线条
    catergoryView.bottomLineEable = YES;
    catergoryView.titleFont = [UIFont boldSystemFontOfSize:15];
    //设置底部线条距离item底部的距离
    catergoryView.bottomLineSpacingFromTitleBottom = 6;
    //禁用点击item滚动scrollView的动画
    catergoryView.scrollWithAnimaitonWhenClicked = NO;
    catergoryView.backgroundColor = [UIColor grayColor];
    catergoryView.titleColorChangeGradually = YES;
    [self.view addSubview:catergoryView];
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@50);
        make.bottom.equalTo(mainView.mas_top);
    }];
    
        
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"热门", @"新上榜", @"连载", @"生活家",@"世间事", @"@IT", @"市集", @"七日热门", @"三十日热门"];
    }
    return _titles;
}



/**监听item点击*/
- (void)catergoryView:(JGCatergoryView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%zd个item", indexPath.item);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0f green:(arc4random() % 255) / 255.0f blue:(arc4random() % 255) / 255.0f alpha:1.0];
        cell.title = _titles[indexPath.item];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
