//
//  BGControl.m
//  MyControl
//
//  Created by chenghong_mac on 15/7/30.
//  Copyright (c) 2015年 Bogo. All rights reserved.
//

#import "BGControl.h"
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "pinyin.h"
#import "ChineseString.h"
#import "sys/utsname.h"
#import "KIKeyChain.h"

#define kScreenSize [UIScreen mainScreen].bounds.size
static

CGRect oldframe;
@implementation BGControl
+(UILabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font numberOfLine:(NSInteger)numberOfLine isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor{
    //设置label的frame
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    //设置label的内容
    label.text = text;
    //设置label的字体及大小
    label.font = font;
    //设置背景颜色
    label.backgroundColor = backgroundColor;
    //设置label显示的行数
    label.numberOfLines = numberOfLine;
    if (isLayer) {
        //设置label 角的弧度
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = cornerRadius;
    }
    return label;
}

+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)image isBackgroundImage:(BOOL)isBackgroundImage title:(NSString *)title isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius{
    UIButton *button = nil;
    if (image) {
        if (isBackgroundImage) {
            //创建背景图片按钮
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }else{
            //创建图片按钮
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }
    }else if (title) {
        //创建标题按钮
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
    }else{
        button = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    //设置button的弧度
    if (isLayer) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    if (image == nil && title == nil) {
        button.backgroundColor = [UIColor clearColor];
    }
    //设置button的frame
    button.frame = frame;
    //设置 button的 tag值
    button.tag = tag;
    //button 添加点击事件
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+(UIImageView *)creatImageViewWithFrame:(CGRect)frame image:(NSString *)image isWebImage:(BOOL)isWebImage holdOnImage:(NSString *)holdOnImage isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius{
    //设置 imageView 的 frame
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    //判断来源是否是网络图片
    if (isWebImage) {//加载网络图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:holdOnImage]];
    }else{//加载本地图片
        imageView.image = [UIImage imageNamed:image];
    }
    //判断是否需要圆角
    if (isLayer) {
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = cornerRadius;
    }
    imageView.userInteractionEnabled = YES;
    return imageView;
}


+(UITextField *)creatTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder borderStyle:(UITextBorderStyle)borderStyle delegate:(id<UITextFieldDelegate>)delegate tag:(NSInteger)tag{
    //设置 textField 的 frame
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    //设置 默认内容
    textField.placeholder = placeHolder;
    //设置 边框风格
    textField.borderStyle = borderStyle;
    //设置 代理
    textField.delegate = delegate;
    //设置 tag值
    textField.tag = tag;
    return textField;
}

+(UITextView *)creatTextViewWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor font:(UIFont *)font isEditable:(BOOL)isEditable backgroundColor:(UIColor *)backgroundColor isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius delegate:(id<UITextViewDelegate>)delegate{
    //设置 textView 的 frame
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    //设置 内容
    textView.text = text;
    //设置 排版类型 0->左对齐  1->居中  2->右对齐
    textView.textAlignment = textAlignment;
    //设置 字体颜色
    textView.textColor =textColor;
    //设置 字体
    textView.font = font;
    //设置 是否可编辑
    textView.editable = isEditable;
    //设置 背景颜色
    textView.backgroundColor = backgroundColor;
    //设置 圆角
    if (isLayer) {
        textView.layer.masksToBounds = YES;
        textView.layer.cornerRadius = cornerRadius;
    }
    //设置 代理
    textView.delegate = delegate;
    //设置 PlaceHolder
    /*
     -(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
     if (![text isEqualToString:@""]) {
     _text.hidden = YES;
     }
     if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
     _text.hidden = NO;
     }
     return YES;
     }
     */
    return textView;
}

+(UIScrollView *)creatScrollViewWithFrame:(CGRect)frame dataArr:(NSArray *)dataArr delegate:(id<UIScrollViewDelegate>)delegate time:(NSTimeInterval)time target:(id)target btnSel:(SEL)btnSel timerSel:(SEL)timerSel userInfo:(id)userInfo repeats:(BOOL)repeats isLocalImage:(BOOL)isLocalImage placeHolderImage:(NSString *)placeHolderImage{
    //创建scrollView 及 frame
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    //设置scrollView 的总长度
    scrollView.contentSize = CGSizeMake(kScreenSize.width * dataArr.count, frame.size.height);
    //设置 分成不同页面
    scrollView.pagingEnabled = YES;
    //代理
    scrollView.delegate = delegate;
    //设置是否可以左右滑动
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    //设置反弹动画
    scrollView.bounces = NO;
    //背景颜色
    scrollView.backgroundColor = [UIColor whiteColor];
    //是否 可翻页
    scrollView.delaysContentTouches = YES;
    //触摸事件
    scrollView.canCancelContentTouches = NO;
    //用户交互
    scrollView.userInteractionEnabled = YES;
    
    //循环将粘有button的imageView 粘贴到scrollView上
    for (NSInteger i = 0; i < dataArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenSize.width, 0, kScreenSize.width, frame.size.height)];
        if (!isLocalImage) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:dataArr[i]] placeholderImage:[UIImage imageNamed:placeHolderImage]];
        }else{
            imageView.image = [UIImage imageNamed:dataArr[i]];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i+1000;
        button.frame = frame;
        [button addTarget:target action:btnSel forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
    }
    
    //添加定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:time target:target selector:timerSel userInfo:userInfo repeats:repeats];
    //运行定时器
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return scrollView;
    
    //具体的点击事件内容
    /*
     - (void)buttonClick:(UIButton *)button{
     NSLog(@"被点击 %d",button.tag);
     }
     -(void)timerSelect{
     _timeCount ++;
     NSInteger count = 0;
     NSArray *array = @[@"表嫂.jpg",@"老白干.jpg",@"扫黄.jpg",@"laoda.jpg"];
     if (_change) {
     count =_timeCount% array.count;
     if (count == array.count-1) {
     _change = NO;
     }
     }else{
     count =array.count - (_timeCount%array.count)-1;
     if (count == 0) {
     _change = YES;
     }
     }
     [self.scrollView setContentOffset:CGPointMake(kScreenSize.width*count, 0) animated:YES];
     }
     */
}

//创建view
+ (UIView *)creatViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor isLayer:(BOOL)isLayer cornerRadius:(CGFloat)cornerRadius{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    if (isLayer) {
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = cornerRadius;
    }
    return view;
}


+ (NSDictionary *)getJsonData:(id)data{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return jsonData;
}


+ (NSString *)MD5SecretCode:(NSString *)password{
    const char *cStr = [password UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (UIAlertController *)creatAlertWithString:(NSString *)string controller:(id)controller autoHiddenTime:(double)autoHiddenTime{
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert show];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [controller presentViewController:alert animated:YES completion:^{
        if (autoHiddenTime > 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(autoHiddenTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [controller dismissViewControllerAnimated:YES completion:nil];
            });
        }
        
    }];
    
    return alert;
}



+ (NSString *)getStringWithHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    NSString * regEx = @"<([^>]*)>&";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

+ (NSAttributedString *)showViewWithHtml:(NSString *)html{
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attributedString;
}

+ (CGFloat)getFrameFromAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width{
    CGRect fram = [attributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return fram.size.height;
}

+ (NSAttributedString *)setAttributedColorWithHtml:(NSString *)html color:(UIColor *)color{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSForegroundColorAttributeName :[UIColor redColor]} documentAttributes:nil error:nil];
    [attributedString addAttributes:@{NSForegroundColorAttributeName :color} range:NSMakeRange(0,attributedString.length)];
    return attributedString;
}


+ (NSURL *)getURLWithFormat:(NSString *)string1 string2:(NSString *)string2{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",string1,string2]];
    return url;
}

+ (CGColorRef)getButttonBurderColorWithR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ R/255.0f, G/255.0f, B/255.0f, 1 });
    return colorref;
}


+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    //DDLogVerbose(@"手机的IP是：%@", address);
    return address;
}


+ (NSString *)getTimeStringFromNumberTimer:(NSString *)timerStr isMinuteLater:(BOOL)isMinute{
    NSDate *longDate;
    NSDate *strDate;
    //转化为 时间格式化字符串
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df = [[NSDateFormatter alloc] init];
    //    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    df.dateFormat = @"HH:mm";
    
    if (timerStr.longLongValue >10000) {
    }else{
        strDate = [df dateFromString:timerStr];
        timerStr = [NSString stringWithFormat:@"%ld",(long)[strDate timeIntervalSince1970]*1000];
        NSLog(@"%@",timerStr);
    }
    
    //转化为Double
    double t = [timerStr doubleValue]/1000;
    longDate = [NSDate dateWithTimeIntervalSince1970:t];
    NSString *theDay = [df stringFromDate:longDate];//日期的年月日
    NSString *currentDay = [df stringFromDate:[NSDate date]];//当前年月日
    NSInteger timeInterval = -[longDate timeIntervalSinceNow];
    if (isMinute) {
        if (timeInterval < 60) {
            return @"1分钟内";
        } else if (timeInterval < 3600) {//1小时内
            return [NSString stringWithFormat:@"%ld分钟前", timeInterval / 60];
        } else if (timeInterval < 21600) {//6小时内
            return [NSString stringWithFormat:@"%ld小时前", timeInterval / 3600];
        } else if ([theDay isEqualToString:currentDay]) {//当天
            [df setDateFormat:@"HH:mm:ss"];
            return [NSString stringWithFormat:@"今天 %@", [df stringFromDate:longDate]];
        } else if ([[df dateFromString:currentDay] timeIntervalSinceDate:[df dateFromString:theDay]] == 86400) {//昨天
            [df setDateFormat:@"HH:mm:ss"];
            return [NSString stringWithFormat:@"昨天 %@", [df stringFromDate:longDate]];
        } else {//以前
            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            return [df stringFromDate:longDate];
        }
    }else{
        return [df stringFromDate:longDate];
    }
}

//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    if (kSystemNo >= 7.0) {
        //iOS7之后
        /*
         第一个参数: 预设空间 宽度固定  高度预设 一个最大值
         第二个参数: 行间距 如果超出范围是否截断
         第三个参数: 属性字典 可以设置字体大小
         */
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
        
    }else {
        //iOS7之前
        /*
         1.第一个参数  设置的字体固定大小
         2.预设 宽度和高度 宽度是固定的 高度一般写成最大值
         3.换行模式 字符换行
         */
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;//返回 计算出得行高
    }
}


//获取本地文件信息  json
+ (NSMutableArray *)getCityDataFileName:(NSString *)fileName type:(NSString *)type
{
    NSArray *jsonArray = [[NSArray alloc]init];
    NSData *fileData = [[NSData alloc]init];
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    if ([UD objectForKey:@"city"] == nil) {
        NSString *path;
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
        fileData = [NSData dataWithContentsOfFile:path];
        
        [UD setObject:fileData forKey:@"city"];
        [UD synchronize];
    }
    else {
        fileData = [UD objectForKey:@"city"];
    }
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *dict in jsonArray) {
        [array addObject:dict];
    }
    
    return array;
}




+ (NSMutableArray *)chineseSequence:(NSMutableArray *)stringsToSort{
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringsToSort count];i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        
        chineseString.string=[NSString stringWithString:[stringsToSort objectAtIndex:i]];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<chineseString.string.length;j++){
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin=pinYinResult;
        }else{
            chineseString.pinYin=@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *result=[NSMutableArray array];
    for(int i=0;i<[chineseStringsArray count];i++){
        [result addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).string];
    }
    
    return result;
}

+ (NSString *)getCurrentIOS {
    return [[UIDevice currentDevice] systemVersion];
}

//23.创建 BarButtonItem
+ (UIBarButtonItem *)creatUIBarButtomTarget:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name{
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:sel];
    button.tag = tag;
    
    return button;
}
//24.创建 BarButtonItemSpace
+ (UIBarButtonItem *)creatUIBarButtomOfSpaceSel:(SEL)sel target:(id)target width:(NSInteger)width{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:target action:sel];
    //宽度
    space.width = width;
    return space;
}

//正则判断手机号
+ (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机格式" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9])\\d{8}$
        //^((13[0-9])|(15[0-9])|(18[0-9])|(17[0-9])|(14[7]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
    NSString *regex = @"^((13[0-9])|(15[0-9])|(18[0-9])|(17[3,6-9])|(14[7]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}


//返回今天星期几
+ (NSInteger)weekDay{
    
      NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSInteger weekday = [componets weekday];
    NSLog(@"%ld",weekday);
    return weekday;
}

//NSDate转NSString

+(NSString*)stringFromDate:(NSDate*)date

{
    
    //获取系统当前时间
    
    NSDate*currentDate=[NSDate date];
    
    //用于格式化NSDate对象
    
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    
    //设置格式：zzz表示时区
    
//    [dateFormatter setDateFormat:@"yyyy-MM-ddHH:mm:sszzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //NSDate转NSString
    
    NSString*currentDateString=[dateFormatter stringFromDate:currentDate];
    
    //输出currentDateString
    
    NSLog(@"%@",currentDateString);
    
    return currentDateString;
    
}
//NSString转NSDate

+(NSDate*)dateFromString:(NSString*)string

{
    
    //需要转换的字符串
    
//    NSString*dateString=@"2015-06-26 08:08:08";
    NSString*dateString=@"2015-06-26";
    
    //设置转换格式
    
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    
//    [formatter setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
     [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //NSString转NSDate
    
    NSDate*date=[formatter dateFromString:dateString];
    
    return date;
    
}


//返回今天几号
+ (NSArray *)seeDay{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString1 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"YYYY"];
    NSString *locationString2 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"MM"];
    NSString *locationString3 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"dd"];
    NSString *locationString4 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *locationString5 = [dateformatter stringFromDate:senddate];
    NSArray *dayArray = @[locationString1,locationString2,locationString3,locationString4,locationString5];
    //    NSLog(@"%@",dayArray);
    return dayArray;
}
//返回今天左右几号
+ (NSArray *)seeDayAroundToday:(NSInteger)dayNum{
    NSInteger dayNUM = dayNum * 86400;
    NSDate *  senddate=[NSDate dateWithTimeIntervalSinceNow:dayNUM];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString1 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"YYYY"];
    NSString *locationString2 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"MM"];
    NSString *locationString3 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"dd"];
    NSString *locationString4 = [dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *locationString5 = [dateformatter stringFromDate:senddate];
    NSArray *dayArray = @[locationString1,locationString2,locationString3,locationString4,locationString5];//    NSLog(@"%@",dayArray);
    return dayArray;
}


//字典转Data
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict{
    NSMutableData* data = [[NSMutableData alloc]init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}

+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}

+ (NSString *)readKeyChain:(NSString *)key{
    KIKeyChain *keyChain = [KIKeyChain keyChainWithIdentifier:@"default_user"];
    
    return [keyChain valueForKey:key];
}

+ (void)writeKeyChain:(NSString *)uuid key:(NSString *)key{
    KIKeyChain *keyChain = [KIKeyChain keyChainWithIdentifier:@"default_user"];
    [keyChain setValue:uuid forKey:key];
    //    [key setValue:@"password1" forKey:@"password"];
    [keyChain write];
}


//plist 存储地址
+ (NSString*)filePath:(NSString*)fileName{
    NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* filePath = [myDocPath stringByAppendingPathComponent:fileName];
    return filePath;
}

//存储方法
+ (NSMutableDictionary *)saveUserInfoInDictionary:(NSMutableDictionary *)dic key:(NSString *)key value:(NSString *)value{
    if (value == nil ||[@"" isEqualToString:value]) {
        //        [dic setObject:@"" forKey:key];
    }else{
        [dic setObject:value forKey:key];
    }
    return dic;
}


/**
 *  将时间字符串转变为时间戳
 *
 *  @param timeStr 传入时间字符串
 *
 *  @return 时间戳
 */
+ (NSString *)getTimeStempByString:(NSString *)timeStr{
    NSString* dateStr = timeStr;
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* date = [formater dateFromString:dateStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld000",(long)[date timeIntervalSince1970]];
    return timeSp;
}

/**
 *  将两张图片合二为一,一般用于二维码上添加图片
 *
 *  @param image1 要添加在二维码上的图片
 *  @param image2 二维码
 *
 *  @return 合成之后的image
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2{
    UIGraphicsBeginImageContext(image2.size);
    
    // Draw image1
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    // Draw image2
    [image1 drawInRect:CGRectMake((image2.size.width-image1.size.width)/2, (image2.size.height-image1.size.height)/2, image1.size.width, image1.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize{
    
    //调用的函数
    
    //    CGSize maxSize = CGSizeMake(MAXFLOAT, 40);
    //
    //    CGSize titleSize = [self labelAutoCalculateRectWith:_publicDetail.name FontSize:15.0f MaxSize:maxSize];
    //
    //    　UILabel *label = [UILabel alloc]init];
    //
    //    　label.frame = CGRectMake(0 , 0, titleSize.width, titleSize.height);
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    //如果系统为iOS7.0；
    
    CGSize labelSize;
    
    if (![text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        
        labelSize = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        labelSize = [text boundingRectWithSize: maxSize
                     
                                       options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                     
                                    attributes:attributes
                     
                                       context:nil].size;
    }
    labelSize.height=ceil(labelSize.height);
    
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}
#pragma mark ---判断网络状态
//+ (NSString *)isConnectionAvailable {
//    NSString *newWork = [NSString string];
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:
//            newWork = @"1";
//            //NSLog(@"notReachable");
//            break;
//        case ReachableViaWiFi:
//            newWork = @"2";
//            //NSLog(@"WIFI");
//            break;
//        case ReachableViaWWAN:
//            newWork = @"3";
//            //NSLog(@"3G");
//            break;
//    }
//    return newWork;
//
//}
+ (NSString *)getYear {
    NSDate *date = [NSDate date];//这个是NSDate类型的日期，所要获取的年月日都放在这里
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|
    NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSWeekdayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    
    NSInteger month = [d month];
    
    NSInteger day  =  [d day];
    NSInteger hour = [d hour];
    NSInteger minute = [d minute];
    NSInteger week = [d weekday];
    NSString *str = [NSString stringWithFormat:@"%d-%d-%d %d:%d",year,month,day,hour,minute];
    return str;
}
+(void)showImage:(UIImageView*)avatarImageView{
    
    UIImage*image = avatarImageView.image;
    
    UIWindow * window=[UIApplication sharedApplication].keyWindow;
    
    UIView * backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor blackColor];
    
    backgroundView.alpha=0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    
    imageView.image=image;
    
    imageView.tag=1;
    
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height * [UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    }
                     completion:^(BOOL finished) {
                     }];
}


+(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=oldframe;
        
        backgroundView.alpha=0;
    }
                     completion:^(BOOL finished) {
                         [backgroundView
                          removeFromSuperview];
                     }];
}
//判断是否为空
+ (BOOL)isNULLOfString:(NSString *)string{
    if (string == NULL) {
        return YES;
    }
    
    if (string == nil) {
        return YES;
    }
    
    if ([@"" isEqualToString:string]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@",string];
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//格式话小数 四舍五入类型
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

#pragma 正则匹配用户身份证号15或18位
#pragma 正则匹配用户身份证号15或18位
+ (BOOL) validateIdentityCard: (NSString *)identityCard

{
  
//    NSString *regex2 = @"^(d{14}|d{17})(d|[xX])$";
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:identityCard];
    return isMatch;
}
+ (BOOL)isPhoneNumberString:(NSString *)number {
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^1[2|3|4|5|6|7|8|9][0-9][0-9]{8}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:number
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0,number.length)];
    
    
    if(numberofMatch > 0) {
        
        return YES;
    }
    return NO;
}
#pragma mark -- 获取前一天
+(NSDate *)lastDay:(NSDate*)lastDate {
 NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:lastDate];
    return lastDay;
}
+(NSDate *)nextDay:(NSDate*)nextDate {
   NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60 sinceDate:nextDate];
    return nextDat;
}

+ (NSString *)notRounding:(NSDecimalNumber *)price afterPoint:(NSInteger)position
{
    
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                       
                                       scale:position
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    NSString *str = [NSString stringWithFormat:@"%@",price];
    NSDecimalNumber *subtotal = [NSDecimalNumber decimalNumberWithString:str];
    
    NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
    
    
    
    //    NSDecimalNumber*total = [subtotal decimalNumberByMultiplyingBy:discount
    
    //                                                      withBehavior:roundUp];
    
    
    NSDecimalNumber *total = [subtotal decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
    NSString *totalStr =  [NSString stringWithFormat:@"%@",total];
    NSString *temp =nil;
    NSMutableArray *arr = [NSMutableArray array];
    for(int i =0; i < [totalStr length]; i++)
        
    {
        temp = [totalStr substringWithRange:NSMakeRange(i,1)];
        [arr addObject:temp];
    }
    if ([arr containsObject:@"."]) {
        NSInteger index = [arr indexOfObject:@"."];
        NSInteger dec = arr.count - index-1;
        if (dec <position) {
            NSInteger sum = position-dec;
            for (int j = 0; j<sum; j++) {
                [arr addObject:@"0"];
            }
            
        }
    }else {
        [arr addObject:@"."];
        for (int i = 0; i<position; i++) {
            [arr addObject:@"0"];
        }
    }
    return [NSString stringWithFormat:@"%@",[arr componentsJoinedByString:@""]];
    
}
+(NSString *) dateToDateString:(NSDate *)date {
    static NSDateFormatter *df1 = nil;
    static NSDateFormatter *df2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df1 = [NSDateFormatter new];
        [df1 setDateFormat:@"YYYY-MM-dd'T'HH:mm:ssZ"];
        
        
        df2 = [NSDateFormatter new];
        [df2 setDateFormat:@"yyyy-MM-dd"];
    });
    NSString *dateString = [NSString stringWithFormat:@"%@",date];
    NSDate *dateOne = [df1 dateFromString:dateString];
    return [df2 stringFromDate:dateOne];
}
+(NSDate *)stringToDate:(NSString *)str {
    NSString *birthdayStr=str;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *Date = [dateFormatter dateFromString:birthdayStr];
    return Date;
}

@end
