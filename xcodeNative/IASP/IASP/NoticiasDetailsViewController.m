//
//  NoticiasDetailsViewController.m
//  IASP
//
//  Created by Heberti Almeida on 05/12/13.
//  Copyright (c) 2013 Heberti Almeida. All rights reserved.
//

#import "NoticiasDetailsViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface NoticiasDetailsViewController ()

@property (nonatomic, strong) NSDictionary *noticia;

@end

@implementation NoticiasDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self getNew];
}

- (void)getNew
{
    NSString *getNews = [NSString stringWithFormat:@"http://iasp.br/appios/ws/?function=GetNoticia&newsId=%@", _noticiaId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:getNews parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        _noticia = (NSDictionary *)responseObject;
        
        [self injectWebView];
    } failure:nil];
}

- (void)injectWebView
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString *embedHTML = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"></head><body style=\"margin:0; padding:0\"><img src=\"%@\"><div class=\"news-detail\"><p class=\"date\">%@</p><p class=\"title\">%@</p>%@</div></body></html>", _noticia[@"image"], _noticia[@"date"], _noticia[@"title"], _noticia[@"content"]];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    [webView loadHTMLString:embedHTML baseURL:baseURL];
    webView.opaque = NO;
    webView.backgroundColor = [UIColor clearColor];
//    videoWebView.scrollView.scrollEnabled = NO;
//    videoWebView.scrollView.bounces = NO;
//    videoWebView.contentMode = UIViewContentModeScaleAspectFill;
//    videoWebView.layer.shadowOffset = CGSizeMake(0, 1);
//    videoWebView.layer.shadowRadius = 2;
//    videoWebView.layer.shadowOpacity = 0.5;
//    
//    // Path for best render
//    CGPathRef path = [UIBezierPath bezierPathWithRect:videoWebView.bounds].CGPath;
//    [videoWebView.layer setShadowPath:path];
//    
//    // Rasterize
//    videoWebView.layer.shouldRasterize = YES;
//    videoWebView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [self.view addSubview:webView];
}

@end
