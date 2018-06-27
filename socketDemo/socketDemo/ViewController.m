//
//  ViewController.m
//  socketDemo
//
//  Created by 海二少 on 2018/6/21.
//  Copyright © 2018年 海二少. All rights reserved.
//

#import "ViewController.h"
#import <GCDAsyncSocket.h>
#import "LHSocketManager.h"
#import "LHSocketSender.h"
#import "LHSocketNotiObj.h"
#import "NSString+LHString.h"
#import "LHSocketDefine.h"
#import "LHConst.h"
#import "LHSocketOperation.h"
#import "LHSocketResponse.h"
#import "LHSocketProperty.h"
#import "UIImage+LHImage.h"
#import "LHSocketDecodeTool.h"
#import "NSArray+LHArray.h"
#import <NSArray+YYAdd.h>
#import "JYProduct.h"
#import "JYBasePickerView.h"
#import "UIView+Extension.h"
#import "JYNikon.h"
#import "CameraModel.h"

#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>
#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define blockSelf(self) __weak __block typeof(self) weakSelf = self;
@interface ViewController ()<UIGestureRecognizerDelegate,UIPickerViewDelegate, UIPickerViewDataSource, JYBasePickerViewDelegate>{
    NSInteger index;
    BOOL senderFlag;
    BOOL startAppend;
    BOOL previewStartAppend;
    BOOL imageAppending;
    int imageLength;
    __block int beginImageLength;
    __block int beginSnapImageLength;
    int imageHeaderLength;
    int beginImageHeaderLength;
    int beginSnapImageHeaderLength;
    NSInteger testindex;
    NSTimeInterval startTime;
    NSTimeInterval beginStartTime;
    NSTimeInterval stopTime;
    BOOL _isStartConnect;
    BOOL _responseOk;
    long _openSessionID;
    NSInteger _basePickerViewRow;
}
@property(nonatomic ,strong) NSTimer  *imageTimer;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (weak, nonatomic) IBOutlet UIButton *previewButton;
@property(nonatomic ,strong) NSMutableData *appendMDtata;
@property(nonatomic ,strong) NSMutableData *beginAppendMDtata;
@property(nonatomic ,strong) NSMutableArray *imageDataArr;
@property(nonatomic ,strong) NSMutableArray *imagePacketDataArr;
@property (weak, nonatomic) IBOutlet UIButton *startConnectButton;
@property (weak, nonatomic) IBOutlet UITextView *showMessageTF;
@property (weak, nonatomic) IBOutlet UILabel *cameraNameLabel;
@property(assign ,nonatomic) int selectCameraBrand;
@property(assign ,nonatomic) int selectCameraType;
@property(nonatomic ,strong) NSMutableArray *snapImageDataArr;
@property (weak, nonatomic) IBOutlet UIButton *snapButton;
@property (weak, nonatomic) IBOutlet UIButton *afButton;
@property (weak, nonatomic) IBOutlet UIButton *apertureButton;
@property (weak, nonatomic) IBOutlet UIButton *shutterButton;
@property (weak, nonatomic) IBOutlet UIButton *exposureCompensationButton;
@property (weak, nonatomic) IBOutlet UIButton *ISOButton;
@property (weak, nonatomic) IBOutlet UIButton *whiteBalanceButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraModelButton;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *valuesArr;
@end

@implementation ViewController
- (NSArray *)valuesArr{
    if (!_valuesArr) {
        _valuesArr = [NSArray array];
    }
    return _valuesArr;
}

- (NSMutableArray *)snapImageDataArr{
    if (!_snapImageDataArr) {
        _snapImageDataArr = [NSMutableArray array];
    }
    return _snapImageDataArr;
}

- (NSMutableData *)appendMDtata{
    if (!_appendMDtata) {
        _appendMDtata = [NSMutableData data];
    }
    return _appendMDtata;
}

- (NSMutableArray *)imagePacketDataArr{
    if (!_imagePacketDataArr) {
        _imagePacketDataArr = [NSMutableArray array];
    }
    return _imagePacketDataArr;
}

- (NSMutableData *)beginAppendMDtata{
    if (!_beginAppendMDtata) {
        _beginAppendMDtata = [NSMutableData data];
    }
    return _beginAppendMDtata;
}

- (NSMutableArray *)imageDataArr{
    if (!_imageDataArr) {
        _imageDataArr = [NSMutableArray array];
    }
    return _imageDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _basePickerViewRow = 0;
    senderFlag = NO;
    startAppend = NO;
    previewStartAppend = NO;
    _openSessionID = -1;
    imageAppending = YES;
    imageLength = 0;
    imageHeaderLength = 0;
    beginImageHeaderLength = 0;
    beginSnapImageLength = 0;
    beginSnapImageHeaderLength = 0;
    beginImageLength = 0;
    index = 0;
    testindex = 0;
    _responseOk = NO;
    _isStartConnect = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(testImageViewTapAction)];
    [self.testImageView addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    blockSelf(self)
    [socketManager responseConnectBlock:^(NSError *error, NSDictionary *result){
        if (error) {
            NSLog(@"responseConnectBlock 连接失败 %@",error);
        }else{
            NSLog(@"responseConnectBlock 连接成功");
            self.startConnectButton.selected = NO;
            [LHSocketManager shareSocketManager].sendHeart = YES;
            [LHSocketManager shareSocketManager].receiveMessage = YES;
//            [self getUSB_info];
            [self showMessageWithStr:@"连接成功"];
            [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP: %@", result[@"host"]]];
            
        }
    }];
    [socketManager responseReadDataBlock:^(NSData *result) {
        
        if (result.length<200) {
            //            NSLog(@">>>result.length %ld",result.length);
            //            NSLog(@"client 收到消息:%@",result);
        }
        LHSocketNotiObj *notiObj = [[LHSocketNotiObj alloc] init];
        notiObj.notiData = result;
        [self snalysisWithNotiObj:notiObj];
        
        [self showMessageWithStr:[[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding]];
    }];
}

- (IBAction)afButtonClick:(UIButton *)sender {
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *afData = [LHPacketData encodeCommandCode:NikonAfDrive];
    [LHSocketSender sendData:afData withTimeout:-1 tag:110];
}

- (void)testImageViewTapAction{
    
}

- (int)arrayConverIntWithArray:(NSArray *)array{
    NSString *appendStr = @"";
    for (NSString *tempStr in array) {
        appendStr = [appendStr stringByAppendingString:tempStr];
    }
    NSArray *tempArr = [NSString snalysisWithResponseTwoString:appendStr];
    tempArr = [[tempArr reverseObjectEnumerator] allObjects];
    NSString *text = [tempArr componentsJoinedByString:@""];
    NSNumber *tempResult = [NSString numberHexString:text];
    //    NSString *text = @"0x0373db";
    int result = [tempResult intValue];
    NSLog(@">>> %d",result);
    return result;
}

- (void)unpackingSnapImageData{
    if (self.snapImageDataArr.count<2) {
        return ;
    }
    NSMutableData *imageAppendData = [NSMutableData data];
    NSTimeInterval Time1 = [[NSDate date] timeIntervalSince1970]*1000;
    for (NSData *tempData in self.snapImageDataArr) {
//        NSLog(@"===unpackingSnapImageData tempData%@",tempData);
        [imageAppendData appendData:tempData];
    }
    NSTimeInterval Time2 = [[NSDate date] timeIntervalSince1970]*1000;
//    NSLog(@"unpackingSnapImageData=结束=%lu -- %d -- %d -- %ld",(unsigned long)imageAppendData.length,beginSnapImageLength,beginSnapImageHeaderLength,self.snapImageDataArr.count);
//    if (imageAppendData.length != beginSnapImageLength) return;
    NSData *imageData = [imageAppendData subdataWithRange:NSMakeRange(beginSnapImageHeaderLength, imageAppendData.length-beginSnapImageHeaderLength)];
    UIImage *image = [UIImage imageWithData:imageData];
    
    if(!image) return;
    if (!self.snapButton.selected) return;
    self.testImageView.image = image;
    stopTime = [[NSDate date] timeIntervalSince1970]*1000;
    self.snapButton.selected = NO;
    [self.snapImageDataArr removeAllObjects];
    [self performSelector:@selector(showSnapImage) withObject:nil afterDelay:2];
//    NSLog(@"======================结束=================== %f -- %f",stopTime - beginStartTime,Time2-Time1);
    
}

- (void)showSnapImage{
    self.testImageView.image = nil;
}

- (void)unpackingImageData{
    if (!self.imageDataArr.count) {
        return ;
    }

    NSMutableData *imageAppendData = [NSMutableData data];
    NSTimeInterval Time1 = [[NSDate date] timeIntervalSince1970]*1000;
    for (NSData *tempData in self.imageDataArr) {
        [imageAppendData appendData:tempData];
    }
    NSTimeInterval Time2 = [[NSDate date] timeIntervalSince1970]*1000;
//    NSLog(@"======preview====结束=====%lu -- %d -- %d",(unsigned long)imageAppendData.length,beginImageLength,beginImageHeaderLength);
    if (imageAppendData.length < beginImageLength) return;
    NSData *imageData = [imageAppendData subdataWithRange:NSMakeRange(beginImageHeaderLength, imageAppendData.length-beginImageHeaderLength)];
    UIImage *image = [UIImage imageWithData:imageData];
    if(!image) return;
    if (!self.previewButton.selected) return;
    self.testImageView.image = image;
    stopTime = [[NSDate date] timeIntervalSince1970]*1000;
//    NSLog(@"======================结束=================== %f -- %f",stopTime - beginStartTime,Time2-Time1);
    [LHSocketSender sendPreviewNikonGetLiveViewImageCommand];
}

- (void)sendGetDeviceInfoCommand{
    //GetDeviceInfo
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDeviceInfo];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5001
- (void)sendGetDevicePropDescAndBatteryLevelCommand{
    //BatteryLevel
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:BatteryLevel];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5003
- (void)sendGetDevicePropDescAndImageSizeCommand{
    //ImageSize
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ImageSize];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5004
- (void)sendGetDevicePropDescAndCompressionSettingCommand{
    //CompressionSetting
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:CompressionSetting];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5005
- (void)sendGetDevicePropDescAndWhiteBalanceCommand{
    //WhiteBalance
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:WhiteBalance];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5007
- (void)sendGetDevicePropDescAndFNumberCommand{
    //FNumber
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:FNumber];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5008
- (void)sendGetDevicePropDescAndFocalLengthCommand{
    //FocalLength
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:FocalLength];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 500a
- (void)sendGetDevicePropDescAndFocusModeCommand{
    //FocusMode
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:FocusMode];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 500b
- (void)sendGetDevicePropDescAndExposureMeteringModeCommand{
    //ExposureMeteringMode
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ExposureMeteringMode];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 500c
- (void)sendGetDevicePropDescAndFlashModeCommand{
    //FlashMode
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:FlashMode];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 500d
- (void)sendGetDevicePropDescAndExposureTimeCommand{
    //ExposureTime
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ExposureTime];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 500e
- (void)sendGetDevicePropDescAndExposureProgramModeCommand{
    //ExposureProgramMode
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ExposureProgramMode];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 500f
- (void)sendGetDevicePropDescAndExposureIndexCommand{
    //ExposureIndex
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ExposureIndex];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5010
- (void)sendGetDevicePropDescAndExposureBiasCompensationCommand{
    //ExposureBiasCompensation
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ExposureBiasCompensation];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5011
- (void)sendGetDevicePropDescAndDateTimeCommand{
    //DateTime
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:DateTime];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5013
- (void)sendGetDevicePropDescAndStillCaptureModeCommand{
    //StillCaptureMode
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:StillCaptureMode];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 5018
- (void)sendGetDevicePropDescAndBurstNumberCommand{
    //BurstNumber
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:BurstNumber];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 501c
- (void)sendGetDevicePropDescAndFocusMeteringModeCommand{
    //FocusMeteringMode
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:FocusMeteringMode];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 d406
- (void)sendGetDevicePropDescAndMtpSessionInitiatorInfoCommand{
    //MtpSessionInitiatorInfo
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:MtpSessionInitiatorInfo];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 d407
- (void)sendGetDevicePropDescAndMtpPerceivedDeviceTypeCommand{
    //MtpPerceivedDeviceType
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:MtpPerceivedDeviceType];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//90ca
- (void)sendNikonGetVendorPropCodesCommand{
    //NikonGetVendorPropCodes
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:NikonGetVendorPropCodes];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 d017
- (void)sendGetDevicePropDesc_D017{
    //打开会话
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:0xd017];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}

//1014 d018
- (void)sendGetDevicePropDesc_D018{
    //打开会话
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *getDeviceInfoData = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:0xd018];
    [LHSocketSender sendData:getDeviceInfoData withTimeout:-1 tag:110];
}


- (void)snalysisCameraInfoWithBrandStr:(NSString *)brandStr cameraTypeStr:(NSString *)cameraTypeStr{
//    NSLog(@"snalysisCameraInfoWithBrandStr %@--%@",brandStr,cameraTypeStr);
    if ([brandStr compareWithHexint:NikonBrand]) {
        self.selectCameraBrand = NikonBrand;
        if ([cameraTypeStr compareWithHexint:NikonD300]) {
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD300];
            NSLog(@"NikonD300");
            self.cameraNameLabel.text = @"NikonD300";
            self.selectCameraType = NikonD300;
        }else if ([cameraTypeStr compareWithHexint:NikonD300S]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD300S];
            NSLog(@"NikonD300S");
            self.cameraNameLabel.text = @"NikonD300S";
            self.selectCameraType = NikonD300S;
        }else if ([cameraTypeStr compareWithHexint:NikonD5000]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD5000];
            NSLog(@"NikonD5000");
            self.cameraNameLabel.text = @"NikonD5000";
            self.selectCameraType = NikonD5000;
        }else if ([cameraTypeStr compareWithHexint:NikonD5100]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD5100];
            NSLog(@"NikonD5100");
            self.cameraNameLabel.text = @"NikonD5100";
            self.selectCameraType = NikonD5100;
        }else if ([cameraTypeStr compareWithHexint:NikonD7000]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD7000];
            NSLog(@"NikonD7000");
            self.cameraNameLabel.text = @"NikonD7000";
            self.selectCameraType = NikonD7000;
        }else if ([cameraTypeStr compareWithHexint:NikonD80]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD80];
            NSLog(@"NikonD80");
            self.cameraNameLabel.text = @"NikonD80";
            self.selectCameraType = NikonD80;
        }else if ([cameraTypeStr compareWithHexint:NikonD200]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD200];
            NSLog(@"NikonD200");
            self.cameraNameLabel.text = @"NikonD200";
            self.selectCameraType = NikonD200;
        }else if ([cameraTypeStr compareWithHexint:NikonD3]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD3];
            NSLog(@"NikonD3");
            self.cameraNameLabel.text = @"NikonD3";
            self.selectCameraType = NikonD3;
        }else if ([cameraTypeStr compareWithHexint:NikonD3S]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD3S];
            NSLog(@"NikonD3S");
            self.cameraNameLabel.text = @"NikonD3S";
            self.selectCameraType = NikonD3S;
        }else if ([cameraTypeStr compareWithHexint:NikonD3X]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD3X];
            NSLog(@"NikonD3X");
            self.cameraNameLabel.text = @"NikonD3X";
            self.selectCameraType = NikonD3X;
        }else if ([cameraTypeStr compareWithHexint:NikonD40]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD40];
            NSLog(@"NikonD40");
            self.cameraNameLabel.text = @"NikonD40";
            self.selectCameraType = NikonD40;
        }else if ([cameraTypeStr compareWithHexint:NikonD90]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD90];
            NSLog(@"NikonD90");
            self.cameraNameLabel.text = @"NikonD90";
            self.selectCameraType = NikonD90;
        }else if ([cameraTypeStr compareWithHexint:NikonD700]){
            [LHSocketSender sendConnectCameraCommandWithCameraBrand:NikonBrand cameraType:NikonD700];
            NSLog(@"NikonD700");
            self.cameraNameLabel.text = @"NikonD700";
            self.selectCameraType = NikonD700;
        }
    }else{
        NSLog(@"相机品牌NULL");
    }
}

- (void)snalysisWithNotiObj:(LHSocketNotiObj *)notiObj{
    if (notiObj.notiData.length<200) {
        NSLog(@">>>111response data %@",notiObj.notiData);
    }
    [self snalysisWithResponseNotiObj:notiObj];
    
    //Request_header_usb_info_1
    if ([notiObj.noti_header1 compareWithHexint:Request_header_usb_info_1]) {//得到USB信息后去连接相机
        if ([notiObj.noti_header2 compareWithHexint:Request_header_usb_info_2]) {
            NSString *camera = notiObj.noti_values[9];
            NSString *cameraType = notiObj.noti_values[10];
            [self snalysisCameraInfoWithBrandStr:camera cameraTypeStr:cameraType];
        }
    }
    
    if ([notiObj.noti_header1 compareWithHexint:Request_header_camera_connect_1]) {//连接相机成功后就可以去打开会话
        if ([notiObj.noti_header2 compareWithHexint:Request_header_camera_connect_2]) {
            NSString *camera = notiObj.noti_values[8];
            NSString *cameraType = notiObj.noti_values[9];
            NSString *cameraConnect = notiObj.noti_values[13];
            if ([camera compareWithHexint:self.selectCameraBrand]
                &&[cameraType compareWithHexint:self.selectCameraType]
                &&[cameraConnect compareWithHexint:responseOk]) {
                //打开会话 打开会话之前先关闭会话
                [LHSocketSender sendCloseSessionCommand];
                //打开会话
                _openSessionID = [LHSocketSender sendOpenSessionCommand];
                //获取deviceinfo
                //                        NSData *connectData = [LHPacketData encodeCommandCode:GetDeviceInfo];
                //                        [LHSocketSender sendData:connectData commandType:LHPacketDataTypeHex withTimeout:-1 tag:110];
                NSLog(@"client opensession");
            }
        }
    }
    
    if (notiObj.notiData.length>200) {
        NSString *tempStr = @"";
        if ([notiObj.noti_values containsObject:Response_header_image]) {
            NSInteger index = [notiObj.noti_values indexOfObject:Response_header_image];
            tempStr = notiObj.noti_values[index+1];
            tempStr = [tempStr substringWithRange:NSMakeRange(0, 2)];
            if ([tempStr isEqualToString:Response_header_image_1]) {
                //                [LHSocketManager stopHeartTimer];
//                NSLog(@"======================开始======================");
                beginStartTime = startTime;
                startTime = [[NSDate date] timeIntervalSince1970]*1000;
                if (self.previewButton.selected) {
                    previewStartAppend = YES;
                    beginImageLength = [NSArray arrayConverIntWithArray:@[notiObj.noti_values[0],notiObj.noti_values[1]]];
                    beginImageHeaderLength = (int)2*index;
                }
                
                [self.imageDataArr removeAllObjects];
                if (self.snapButton.selected) {
                    startAppend = YES;
                    beginSnapImageLength = [NSArray arrayConverIntWithArray:@[notiObj.noti_values[0],notiObj.noti_values[1]]];
                    beginSnapImageHeaderLength = (int)2*index;
                }
            }
        }
        if (self.snapButton.selected&&notiObj.notiData.length>200) {
            [self.snapImageDataArr addObject:notiObj.notiData];
            [self unpackingSnapImageData];
        }
        if (previewStartAppend&&notiObj.notiData.length>200&&previewStartAppend) {//开始组装数据
            [self.imageDataArr addObject: notiObj.notiData];
            [self unpackingImageData];
        }
    }
}


- (void)testCode{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *propValueData = [LHPacketData encodeCommandCode:GetDevicePropValue param0:53666];
    NSLog(@"testCode>>> %@",propValueData);
}

- (void)appendImageData:(NSData *)imageData{
    testindex ++;
    NSLog(@">>>appendImageData>>>%ld",(long)testindex);
    [self.appendMDtata appendData:imageData];
    //    NSLog(@">>>appendImageData>>> %@",self.appendMDtata);
}

- (void)sendPreviewCommand2{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *previewData = [LHPacketData encodeCommandCode:EosGetLiveViewPicture param1:GetLiveViewPicture_p1 param2:0 param3:0];
    [LHSocketSender sendData:previewData withTimeout:-1 tag:110];
}

- (void)sendPreviewCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    //                    [LHSocketManager stopHeartTimer];
    NSData *previewData = [LHPacketData encodeCommandCode:EosGetLiveViewPicture param1:GetLiveViewPicture_p1 param2:0 param3:0];
    //                    NSLog(@"preview>>> %@",previewData);
    [LHSocketSender sendData:previewData withTimeout:-1 tag:110];
}

- (IBAction)connectButtonClick:(UIButton *)sender {
    
    //192.168.3:343
    //伴侣
    NSString *hostStr = @"192.168.1.1";
    NSString *portStr = @"4757";
    [socketManager connectToHost:hostStr port:[portStr integerValue] viaInterface:nil timeout:-1];
    self.startConnectButton.selected = YES;
}

- (IBAction)snapButtonClick:(UIButton *)sender {
    self.snapButton.selected = !self.snapButton.selected;
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0xd108];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0xd161];
//    [LHSocketSender sendNikonDeviceReadyCommand];
    [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:0xd161 param1:0x000d param2:0x04];
    [LHSocketSender sendSnapInitiateCaptureCommand];
    [LHSocketSender sendNikonDeviceReadyCommand];
    [LHSocketSender sendHeartCommand];
//    [LHSocketSender sendNikonDeviceReadyCommand];
//    [LHSocketSender sendGetPartialObjectCommand];
    
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0x500a];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0x501c];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0xd103];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0xd108];
    
//    [LHSocketSender sendGetObjectInfoCommandWithParam:0x29190015];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0xd1a2];
//    [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:0xd161 param1:0x000d param2:0x0002];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:0xd161];
//    [LHSocketSender sendPreviewNikonChangeCameraModeCommand:NikonPreviewTypeOff];//关闭预览
//    [LHSocketSender sendPreviewExposureProgramModeCommmandWithParam0:ExposureProgramMode param1:1];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
//    [LHSocketSender sendPreviewExposureProgramModeCommmandWithParam0:StillCaptureMode param1:1];
//    [LHSocketSender sendGetDevicePropDescCommmandWithParam:StillCaptureMode];
    
//    [LHSocketSender sendGetObjectInfoCommandWithParam:0x2919400c];
//    [LHSocketSender sendGetThumbCommandWithParam:0x2919400c];//**

}

//1015
//- (void)sendGetDevicePropValueCommand{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropValue param0:0xd1a4];
//    NSLog(@"GetDevicePropValue>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}

- (IBAction)settingModelButtonClick:(UIButton *)sender {
    
    if (!self.previewButton.selected) {
        [LHSocketManager shareSocketManager].sendHeart = NO;
        NSData *PCModelData = [LHPacketData encodeCommandCode:EosSetPCConnectMode param0:1];
        NSLog(@"==PCModelData: %@",PCModelData);
        [LHSocketSender sendData:PCModelData withTimeout:-1 tag:110];
    }
}

- (IBAction)previewButtonClick:(UIButton *)sender {
    
    self.previewButton.selected = !self.previewButton.selected;
    if (self.previewButton.selected) {
        //1015
        [LHSocketSender sendGetDevicePropValueCommandWithParam:0xd1a4];
        //1016 21 NikonRecordingMedia 0x0d 1
        [LHSocketSender sendPreviewNikonRecordingMediaCommmandWithParam0:NikonRecordingMedia param1:0x0d param2:1];
        //90c2
        [LHSocketSender sendPreviewNikonChangeCameraModeCommand:NikonPreviewTypeOn];
        //1014 ExposureProgramMode
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:ExposureProgramMode];
        //1016 22 0x0e ExposureProgramMode
        [LHSocketSender sendPreviewExposureProgramModeCommmandWithParam0:ExposureProgramMode param1:0x0e];
        //1015 0x500e
        [LHSocketSender sendGetDevicePropValueCommandWithParam:0x500e];
        //1016 22
        [LHSocketSender sendPreviewExposureProgramModeCommmandWithParam0:ExposureProgramMode param1:0x0e];
        //9201
        [LHSocketSender sendPreviewNikonStartLiveViewCommand];
        //1014
        [LHSocketSender sendGetDevicePropDescCommmandWithParam:0xd1a4];
        //9203
        [LHSocketSender sendPreviewNikonGetLiveViewImageCommand];
        senderFlag = NO;
    }else{
        self.testImageView.image = nil;
        [LHSocketSender sendPreviewNikonEndLiveViewCommand];
        [LHSocketSender sendPreviewNikonChangeCameraModeCommand:NikonPreviewTypeOff];
        self.testImageView.image = nil;
    }
}

////1016 21
//- (void)previewNikonRecordingMediaCommmand2{
//    NSData *data = [LHPacketData encode_21NikonCommandCodeAndCommandData:SetDevicePropValue param1:NikonRecordingMedia param2:0x0d param3:0];
//    NSLog(@"预览NikonRecordingMedia2>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////1014
//- (void)sendGetDevicePropDescCommmand2{
//    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:0xd1a4];
//    NSLog(@"预览GetDevicePropDesc>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////1016 22
//- (void)previewExposureProgramModeCommmand2{
//    NSData *data = [LHPacketData encode_22NikonCommandCodeAndCommandData:SetDevicePropValue param1:StillCaptureMode param2:0x0e];
//    NSLog(@"预览ExposureProgramMode2>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////1015
//- (void)sendGetDevicePropValueCommand2{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropValue param0:0x500e];
//    NSLog(@"拍照GetDevicePropValue>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////1014
//- (void)sendGetDevicePropDescCommmand{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:ExposureProgramMode];
//    NSLog(@"预览GetDevicePropDesc>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////1016 21
//- (void)previewNikonRecordingMediaCommmand{//
//    NSData *data = [LHPacketData encode_21NikonCommandCodeAndCommandData:SetDevicePropValue param1:NikonRecordingMedia param2:0x0d param3:1];
//    NSLog(@"预览NikonRecordingMedia>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////1016 22
//- (void)previewExposureProgramModeCommmand{
//    NSData *data = [LHPacketData encode_22NikonCommandCodeAndCommandData:SetDevicePropValue param1:ExposureProgramMode param2:0x0e];
//    NSLog(@"预览ExposureProgramMode>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////90c2
//- (void)previewNikonChangeCameraModeCommand{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:NikonChangeCameraMode param0:1];
//    NSLog(@"预览NikonStartLiveView>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
//- (void)previewStopNikonChangeCameraModeCommand{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:NikonChangeCameraMode param0:0];
//    NSLog(@"预览NikonStopLiveView>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
//- (void)previewNikonEndLiveViewCommand{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:NikonEndLiveView];
//    NSLog(@"预览NikonEndLiveView>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
////9201
//- (void)previewNikonStartLiveViewCommand{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:NikonStartLiveView];
//    NSLog(@"预览NikonStartLiveView>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}
//
//- (void)previewNikonGetLiveViewImageCommand{
//    [LHSocketManager shareSocketManager].sendHeart = NO;
//    NSData *data = [LHPacketData encodeCommandCode:NikonGetLiveViewImage];
//    NSLog(@"预览GetLiveViewImage>>> %@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
//}

//相机亮屏
- (void)brightScreenCommand{
    [LHSocketManager startHeartTimer];
    self.testImageView.image = nil;
    NSData *data = [LHPacketData encodeCommandCodeAndCommandData:EosSetDevicePropValue param1:EosEvfOutputDevice param2:camera_previre_off];
    NSLog(@"发送消息：%@",data);
    [LHSocketManager shareSocketManager].sendHeart = NO;
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
    senderFlag = NO;
}

//相机熄屏
- (void)extinguishingScreenCommand1{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *propValueData = [LHPacketData encodeCommandCode:GetDevicePropValue param0:53666];
    NSLog(@"extinguishingScreenCommand1>>> %@",propValueData);
}

- (void)extinguishingScreenCommand2{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:NikonGetLiveViewImage];
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
    
    
    
    
//    NSData *data = [LHPacketData encodeCommandCodeAndCommandData:SetDevicePropValue param1:EosEvfOutputDevice param2:camera_previre_on];
//    NSLog(@"发送消息：%@",data);
//    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

- (IBAction)getParamsButtonClick:(UIButton *)sender {
    
    
//    //先切PC模式
//    [self snapButtonClick:nil];
//    //    [self performSelector:@selector(getCameraParams0) withObject:nil afterDelay:0.5];
//    [self performSelector:@selector(getCameraParams1) withObject:nil afterDelay:1.0];
//    [self performSelector:@selector(getCameraParams1) withObject:nil afterDelay:2.0];
}

- (void)sendNikonAfAndCaptureInSdramCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:EosSetEventMode param0:1];
    NSLog(@"发送消息：%@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

- (void)getCameraParams0{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:EosSetEventMode param0:1];
    NSLog(@"发送消息：%@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

- (void)getCameraParams1{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:EosEventCheck];
    NSLog(@"发送消息：%@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}

- (IBAction)apertureButtonClick:(UIButton *)sender {
    
}

- (IBAction)shutterButtonClick:(UIButton *)sender {
    
}

- (IBAction)exposureCompensationButtonClick:(UIButton *)sender {
    
    
}

- (IBAction)ISOButtonClick:(UIButton *)sender {
    
    
}

- (IBAction)whiteBalanceButtonClick:(UIButton *)sender {
    JYBasePickerView *basePickerView = [JYBasePickerView basePickerView];
    basePickerView.width = screenW;
    basePickerView.height = screenH;
    basePickerView.x = 0;
    basePickerView.y = 0;
    basePickerView.delegate = self;
    basePickerView.pickerView.delegate = self;
    basePickerView.pickerView.dataSource = self;
    basePickerView.titleLabel.text = @"白平衡";
    NSArray *tempArr = [JYNikon nikonWhiteBalanceWithModel];
    self.valuesArr = [tempArr copy];
    self.pickerView = basePickerView.pickerView;
    [basePickerView.pickerView selectRow:_basePickerViewRow inComponent:0 animated:NO];
    [basePickerView.pickerView reloadComponent:0];
    [self.view addSubview:basePickerView];
    
}

- (IBAction)cameraModelButtonClick:(UIButton *)sender {
    
    
}

- (IBAction)focalLengthRight2ButtonClick:(UIButton *)sender {
    [LHSocketSender sendNikonDeviceReadyCommand];
    [self performSelector:@selector(sendFocalLengthRight2Command) withObject:nil afterDelay:0.5];
}

- (void)focalLengthCommand{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *data = [LHPacketData encodeCommandCode:GetDevicePropDesc param0:FocalLength];
    NSLog(@"focalLengthCommand %@",data);
    [LHSocketSender sendData:data withTimeout:-1 tag:110];
}


- (void)sendFocalLengthRight2Command{
    [LHSocketSender sendNikonMfDriveWithParam0:0x0002 param1:0x0168];
}

- (IBAction)focalLengthRight1ButtonClick:(UIButton *)sender {
    [LHSocketSender sendNikonDeviceReadyCommand];
    [self performSelector:@selector(sendFocalLengthRight1Command) withObject:nil afterDelay:0.5];
}
- (void)sendFocalLengthRight1Command{
    [LHSocketSender sendNikonMfDriveWithParam0:0x0002 param1:0x0078];
}

- (IBAction)focalLengthRight0ButtonClick:(UIButton *)sender {
    [LHSocketSender sendNikonDeviceReadyCommand];
    [self performSelector:@selector(sendFocalLengthRight0Command) withObject:nil afterDelay:0.5];
}
- (void)sendFocalLengthRight0Command{
    [LHSocketSender sendNikonMfDriveWithParam0:0x0002 param1:0x0014];
}

- (IBAction)focalLengthLeft0ButtonClick:(UIButton *)sender {
    [LHSocketSender sendNikonDeviceReadyCommand];
    [self performSelector:@selector(sendFocalLengthLeft0Command) withObject:nil afterDelay:0.5];
}
- (void)sendFocalLengthLeft0Command{
    [LHSocketSender sendNikonMfDriveWithParam0:0x0001 param1:0x0014];
}


- (IBAction)focalLengthLeft1ButtonClick:(UIButton *)sender {
    [LHSocketSender sendNikonDeviceReadyCommand];
    [self performSelector:@selector(sendFocalLengthLeft1Command) withObject:nil afterDelay:0.5];
}
- (void)sendFocalLengthLeft1Command{
    [LHSocketSender sendNikonMfDriveWithParam0:0x0001 param1:0x0078];
}

- (IBAction)focalLengthLeft2ButtonClick:(UIButton *)sender {
    [LHSocketSender sendNikonDeviceReadyCommand];
    [self performSelector:@selector(sendFocalLengthLeft2Command) withObject:nil afterDelay:0.5];
}
- (void)sendFocalLengthLeft2Command{
    [LHSocketSender sendNikonMfDriveWithParam0:0x0001 param1:0x0168];
}

- (void)snalysisWithResponseNotiObj:(LHSocketNotiObj *)notiObj{
    if (!notiObj.noti_values.count) return;
    if (notiObj.notiData.length>0) {
        [LHSocketManager shareSocketManager].sendHeart = YES;
        [LHSocketManager shareSocketManager].receiveMessage = YES;
    }

    //DslrDashboardServer <1d000000 01000000 44736c72 44617368 626f6172 64536572 76657200 00>
    NSMutableData *startConnnectData = [NSMutableData data];
    if ([notiObj.noti_values[0] isEqualToString:@"1d00"]&&(29 == notiObj.notiData.length)) {
        startConnnectData = (NSMutableData *)[notiObj.notiData subdataWithRange:NSMakeRange(8, notiObj.notiData.length - 8 - 2)];
    }
    NSString *startConnnectStr = [[NSString alloc]initWithData:startConnnectData encoding:NSUTF8StringEncoding];
    
    if ([startConnnectStr isEqualToString:@"DslrDashboardServer"]) {
        [LHSocketSender sendGetUSB_infoCommand];
    }
    
    NSString *tempStr = @"";
    NSString *commandStr = @"";
    long commandCountID = -1;
    NSString *headStr = notiObj.noti_values[0];
    if ([headStr compareWithHexint:0x1c]){//28 39?
        if (notiObj.noti_values.count>11) {
            commandStr = notiObj.noti_values[5];
            tempStr = notiObj.noti_values[11];
            NSString *IDStr = notiObj.noti_values[12];
            commandCountID = [NSArray arrayConverIntWithString:IDStr];
            NSLog(@">>>response commandCountID %ld -- %ld",commandCountID,packetData.commandCountID);
        }
    }else if ([headStr compareWithHexint:0x20]){//0x20 32
        if (notiObj.noti_values.count>13) {
            commandStr = notiObj.noti_values[5];
            tempStr = notiObj.noti_values[13];
            NSString *IDStr = notiObj.noti_values[14];
            commandCountID = [NSArray arrayConverIntWithString:IDStr];
            NSLog(@">>>response commandCountID %ld -- %ld",commandCountID,packetData.commandCountID);
        }
    }else if ([headStr compareWithHexint:0x1e]){//0x1e 30
        if (notiObj.noti_values.count>13) {
            commandStr = notiObj.noti_values[5];
            tempStr = notiObj.noti_values[12];
            NSString *IDStr = notiObj.noti_values[13];
            commandCountID = [NSArray arrayConverIntWithString:IDStr];
            NSLog(@">>>response commandCountID %ld -- %ld",commandCountID,packetData.commandCountID);
        }
    }else{//0x10
        if (notiObj.noti_values.count>5) {
            commandStr = notiObj.noti_values[5];
            tempStr = notiObj.noti_values[5];
            NSString *IDStr = notiObj.noti_values[6];
            commandCountID = [NSArray arrayConverIntWithString:IDStr];
            NSLog(@">>>response commandCountID %ld -- %ld",commandCountID,packetData.commandCountID);
        }
    }
    
    if ([tempStr compareWithHexint: responseOk]) {//此操作OK
        _responseOk = YES;
        _isStartConnect = YES;
        
        NSLog(@">>>responseOk");
    }else if ([tempStr compareWithHexint: GeneralError]){
        NSLog(@">>>GeneralError");
        [self showMessageWithStr:@">>>GeneralError"];
    }else if ([tempStr compareWithHexint: SessionNotOpen]){
        NSLog(@">>>SessionNotOpen");
        [self showMessageWithStr:@">>>SessionNotOpen"];
    }else if ([tempStr compareWithHexint: InvalidTransactionID]){
        NSLog(@">>>InvalidTransactionID");
        [self showMessageWithStr:@">>>InvalidTransactionID"];
    }else if ([tempStr compareWithHexint: OperationNotSupported]){
        NSLog(@">>>OperationNotSupported");
        [self showMessageWithStr:@">>>OperationNotSupported"];
    }else if ([tempStr compareWithHexint: ParameterNotSupported]){
        NSLog(@">>>ParameterNotSupported");
        [self showMessageWithStr:@">>>ParameterNotSupported"];
    }else if ([tempStr compareWithHexint: IncompleteTransfer]){
        NSLog(@">>>IncompleteTransfer");
        [self showMessageWithStr:@">>>IncompleteTransfer"];
    }else if ([tempStr compareWithHexint: InvalidStorageID]){
        NSLog(@">>>InvalidStorageID");
        [self showMessageWithStr:@">>>InvalidStorageID"];
    }else if ([tempStr compareWithHexint: InvalidObjectHandle]){
        NSLog(@">>>InvalidObjectHandle");
        [self showMessageWithStr:@">>>InvalidObjectHandle"];
    }else if ([tempStr compareWithHexint: DevicePropNotSupported]){
        NSLog(@">>>DevicePropNotSupported");
    }else if ([tempStr compareWithHexint: InvalidObjectFormatCode]){
        NSLog(@">>>InvalidObjectFormatCode");
        [self showMessageWithStr:@">>>InvalidObjectFormatCode"];
    }else if ([tempStr compareWithHexint: StoreIsFull]){
        NSLog(@">>>StoreIsFull");
        [self showMessageWithStr:@">>>StoreIsFull"];
    }else if ([tempStr compareWithHexint: ObjectWriteProtect]){
        NSLog(@">>>ObjectWriteProtect");
        [self showMessageWithStr:@">>>ObjectWriteProtect"];
    }else if ([tempStr compareWithHexint: StoreReadOnly]){
        NSLog(@">>>StoreReadOnly");
        [self showMessageWithStr:@">>>StoreReadOnly"];
    }else if ([tempStr compareWithHexint: AccessDenied]){
        NSLog(@">>>AccessDenied");
        [self showMessageWithStr:@">>>AccessDenied"];
    }else if ([tempStr compareWithHexint: NoThumbnailPresent]){
        NSLog(@">>>NoThumbnailPresent");
        [self showMessageWithStr:@">>>NoThumbnailPresent"];
    }else if ([tempStr compareWithHexint: PartialDeletion]){
        NSLog(@">>>PartialDeletion");
        [self showMessageWithStr:@">>>PartialDeletion"];
    }else if ([tempStr compareWithHexint: StoreNotAvailable]){
        NSLog(@">>>StoreNotAvailable");
        [self showMessageWithStr:@">>>StoreNotAvailable"];
    }else if ([tempStr compareWithHexint: SpecificationByFormatUnsupported]){
        NSLog(@">>>SpecificationByFormatUnsupported");
        [self showMessageWithStr:@">>>SpecificationByFormatUnsupported"];
    }else if ([tempStr compareWithHexint: NoValidObjectInfo]){
        NSLog(@">>>NoValidObjectInfo");
        [self showMessageWithStr:@">>>NoValidObjectInfo"];
    }else if ([tempStr compareWithHexint: DeviceBusy]){
        NSLog(@">>>DeviceBusy");
        [self showMessageWithStr:@">>>DeviceBusy"];
    }else if ([tempStr compareWithHexint: InvalidParentObject]){
        NSLog(@">>>InvalidParentObject");
        [self showMessageWithStr:@">>>InvalidParentObject"];
    }else if ([tempStr compareWithHexint: InvalidDevicePropFormat]){
        NSLog(@">>>InvalidDevicePropFormat");
        [self showMessageWithStr:@">>>InvalidDevicePropFormat"];
    }else if ([tempStr compareWithHexint: InvalidDevicePropValue]){
        NSLog(@">>>InvalidDevicePropValue");
        [self showMessageWithStr:@">>>InvalidDevicePropValue"];
    }else if ([tempStr compareWithHexint: InvalidParameter]){
        NSLog(@">>>InvalidParameter");
        [self showMessageWithStr:@">>>InvalidParameter"];
    }else if ([tempStr compareWithHexint: SessionAlreadyOpen]){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.startConnectButton.selected) {
//                self.startConnectButton.selected = NO;
//                //                        NSData *data = [LHPacketData encodeCommandCode:Usb_info];
//                //                        [LHSocketSender sendData:data commandType:LHPacketDataTypeHex withTimeout:-1 tag:110];
//                //                        [self getCameraParamsButtonClick:nil];
//            }else{
//                if (self.previewButton.selected) {
//                    [self sendPreviewCommand];
//                }
//            }
//        });
        
        
        NSLog(@">>>SessionAlreadyOpen");
        [self showMessageWithStr:@">>>SessionAlreadyOpen"];
    }else if ([tempStr compareWithHexint: TransferCancelled]){
        NSLog(@">>>TransferCancelled");
        [self showMessageWithStr:@">>>TransferCancelled"];
    }else if ([tempStr compareWithHexint: SpecificationOfDestinationUnsupported]){
        NSLog(@">>>SpecificationOfDestinationUnsupported");
        [self showMessageWithStr:@">>>SpecificationOfDestinationUnsupported"];
    }
    else if ([tempStr compareWithHexint: HardwareError]){
        NSLog(@">>>HardwareError");
        [self showMessageWithStr:@">>>HardwareError"];
    }else if ([tempStr compareWithHexint: OutOfFocus]){
        NSLog(@">>>OutOfFocus");
        [self showMessageWithStr:@">>>OutOfFocus"];
    }else if ([tempStr compareWithHexint: ChangeCameraModeFailed]){
        NSLog(@">>>ChangeCameraModeFailed");
        [self showMessageWithStr:@">>>ChangeCameraModeFailed"];
    }else if ([tempStr compareWithHexint: InvalidStatus]){
        NSLog(@">>>InvalidStatus");
        [self showMessageWithStr:@">>>InvalidStatus"];
    }else if ([tempStr compareWithHexint: SetPropertyNotSupport]){
        NSLog(@">>>SetPropertyNotSupport");
        [self showMessageWithStr:@">>>SetPropertyNotSupport"];
    }else if ([tempStr compareWithHexint: WbPresetError]){
        NSLog(@">>>WbPresetError");
        [self showMessageWithStr:@">>>WbPresetError"];
    }else if ([tempStr compareWithHexint: DustReferenceError]){
        NSLog(@">>>DustReferenceError");
        [self showMessageWithStr:@">>>DustReferenceError"];
    }else if ([tempStr compareWithHexint: MirrorUpSequence]){
        NSLog(@">>>MirrorUpSequence");
        [self showMessageWithStr:@">>>MirrorUpSequence"];
    }else if ([tempStr compareWithHexint: CameraModeNotAdjustFnumber]){
        NSLog(@">>>CameraModeNotAdjustFnumber");
        [self showMessageWithStr:@">>>CameraModeNotAdjustFnumber"];
    }else if ([tempStr compareWithHexint: NotLiveView]){
        [LHSocketSender sendPreviewNikonGetLiveViewImageCommand];
        NSLog(@">>>NotLiveView");
        [self showMessageWithStr:@">>>NotLiveView"];
    }else if ([tempStr compareWithHexint: MfDriveStepEnd]){
        NSLog(@">>>MfDriveStepEnd");
        [self showMessageWithStr:@">>>MfDriveStepEnd"];
    }else if ([tempStr compareWithHexint: MfDriveStepInsufficiency]){
        NSLog(@">>>MfDriveStepInsufficiency");
        [self showMessageWithStr:@">>>MfDriveStepInsufficiency"];
    }else if ([tempStr compareWithHexint: InvalidObjectPropCode]){
        NSLog(@">>>InvalidObjectPropCode");
        [self showMessageWithStr:@">>>InvalidObjectPropCode"];
    }else if ([tempStr compareWithHexint: InvalidObjectPropFormat]){
        NSLog(@">>>vInvalidObjectPropFormat");
        [self showMessageWithStr:@">>>vInvalidObjectPropFormat"];
    }else if ([tempStr compareWithHexint: ObjectPropNotSupported]){
        NSLog(@">>>ObjectPropNotSupported");
        [self showMessageWithStr:@">>>ObjectPropNotSupported"];
    }

    if ([tempStr compareWithHexint:0x90c7]) {//心跳
        NSLog(@">>>response 心跳 %@",tempStr);
    }else if (_openSessionID == commandCountID){
        _openSessionID = -1;
        [self sendGetDeviceInfoCommand];
        [self sendGetDevicePropDescAndBatteryLevelCommand];
        [self sendGetDevicePropDescAndImageSizeCommand];
        [self sendGetDevicePropDescAndCompressionSettingCommand];
        [self sendGetDevicePropDescAndWhiteBalanceCommand];
        [self sendGetDevicePropDescAndFNumberCommand];
        [self sendGetDevicePropDescAndFocalLengthCommand];
        [self sendGetDevicePropDescAndFocusModeCommand];
        [self sendGetDevicePropDescAndExposureMeteringModeCommand];
        [self sendGetDevicePropDescAndFlashModeCommand];
        [self sendGetDevicePropDescAndExposureTimeCommand];
        [self sendGetDevicePropDescAndExposureProgramModeCommand];
        [self sendGetDevicePropDescAndExposureIndexCommand];
        [self sendGetDevicePropDescAndExposureBiasCompensationCommand];
        [self sendGetDevicePropDescAndDateTimeCommand];
        [self sendGetDevicePropDescAndStillCaptureModeCommand];
        [self sendGetDevicePropDescAndBurstNumberCommand];
        [self sendGetDevicePropDescAndFocusMeteringModeCommand];
        [self sendGetDevicePropDescAndMtpSessionInitiatorInfoCommand];
        [self sendGetDevicePropDescAndMtpPerceivedDeviceTypeCommand];
        [self sendNikonGetVendorPropCodesCommand];
        [self sendGetDevicePropDesc_D017];
        [self sendGetDevicePropDesc_D018];
        NSLog(@"打开会话了。。。");
    }else{
      NSLog(@">>>response callStr %@",commandStr);
    }
    
    if (_isStartConnect) {
        _isStartConnect = NO;
//        [self testCode];
    }
    
    if ([notiObj.noti_header1 isEqualToStringWithoutCase:Response_header_result]
        ||[notiObj.noti_header1 isEqualToStringWithoutCase:Request_header_take_picture]) {
        if ([notiObj.noti_header2 isEqualToStringWithoutCase:Response_header_result_1]
            ||[notiObj.noti_header2 isEqualToStringWithoutCase:Request_header_take_picture_1]) {
            
            
        }
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
 
    return self.valuesArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return self.valuesArr[row];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.tag=row;
        
        if (_basePickerViewRow == row){
            pickerLabel.textColor = [UIColor redColor];
        }else{
            
            pickerLabel.textColor = kColor(134, 135, 142, 1);
        }
        
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _basePickerViewRow = row;
    [pickerView reloadComponent:0];
}

- (void)basePickerView:(JYBasePickerView *)basePickerView confirmBtn:(UIButton *)confirmBtn{
    [LHSocketSender send_22NikonWithParam1:WhiteBalance param2:0x0005];
    [LHSocketSender sendGetDevicePropDescCommmandWithParam:WhiteBalance];
}

// 信息展示
- (void)showMessageWithStr:(NSString *)str {
    
    blockSelf(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.showMessageTF.text = [self.showMessageTF.text stringByAppendingFormat:@"%@\n", str];
        //        NSLog(@"showMessageWithStr %@ -- %@",str,weakSelf.showMessageTF.text);
    });
    
}

- (void)testCode1{
    [LHSocketManager shareSocketManager].sendHeart = NO;
    NSData *testData = [LHPacketData encodeCommandCode:0x1003];
    [LHSocketSender sendData:testData withTimeout:-1 tag:110];
    NSLog(@"testCode1>>> %@",testData);
}

- (NSString *) localWiFiIPAddress{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}

- (NSString *)getIPAddressForCurrentWiFi{
    
    NSString *address = nil;
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        
        temp_addr = interfaces;
        
        while (temp_addr != NULL) {
            
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    //  广播地址
                    NSLog(@"broadcast address--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
                    // 本地IP地址
                    NSLog(@"local device ip--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
                    //子网掩码地址
                    NSLog(@"netmask--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
                    //  端口地址
                    NSLog(@"interface--%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
