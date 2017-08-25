//
//  CCCameraViewController.m
//  CCCamera
//
//  Created by wsk on 16/8/22.
//  Copyright © 2016年 cyd. All rights reserved.
//

#import "CCCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <CoreMedia/CMMetadata.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "CCVideoPreview.h"
#import "BezierView.h"
#import "UIImage+Cut.h"
#import "HistoryPictureController.h"
#import "LoadingView.h"
#import "LimitLayout.h"
#import "ShowImageCell.h"
#import "DownButtom.h"
#import "HistoryPhotoModel.h"
#import "SnowflakeFallingView.h"
@interface CCCameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NSURLSessionDataDelegate>
{
    AVCaptureSession            *_captureSession;
    
    // 输入
    AVCaptureDeviceInput        *_deviceInput;
        
    // 输出
    AVCaptureConnection         *_videoConnection;
    AVCaptureConnection         *_audioConnection;
    AVCaptureVideoDataOutput    *_videoOutput;
    AVCaptureStillImageOutput   *_imageOutput;
    
    // 写入相册
    AVAssetWriter               *_assetWriter;
    AVAssetWriterInput			*_assetAudioInput;
    AVAssetWriterInput          *_assetVideoInput;
    
    dispatch_queue_t             _movieWritingQueue;
    BOOL						 _readyToRecordVideo;
    BOOL						 _readyToRecordAudio;
    BOOL                         _recording;
    
    LimitLayout *layout;
    UIActivityIndicatorView *indicatorView;
    DownButtom *cancelButton;
    DownButtom *photoImageButton;
}

// 相机设置
@property(nonatomic, strong) AVCaptureDevice *activeCamera;     // 当前输入设备
@property(nonatomic, strong) AVCaptureDevice *inactiveCamera;   // 不活跃的设备(这里指前摄像头或后摄像头，不包括外接输入设备)

// UI
@property(nonatomic, strong) CCVideoPreview *previewView;
@property(nonatomic, strong) UIView   *bottomView;
@property(nonatomic, strong) UIView   *topView;
@property(nonatomic, strong) UIView   *focusView;       // 聚焦动画
@property(nonatomic, strong) UIView   *exposureView;    // 曝光动画
@property(nonatomic, strong) UIImageView *photoBtn;
@property(nonatomic, strong) UIButton *typeBtn;
@property(nonatomic, strong) UIButton *torchBtn;
@property(nonatomic, strong) UIButton *flashBtn;
@property (nonatomic,strong) UIButton *helpBtn;



@property(readwrite) AVCaptureVideoOrientation	referenceOrientation; // 视频播放方向

@property (nonatomic,strong) BezierView *whiteView;

// 图片截取区域
@property (nonatomic,assign) CGRect photoCutFrame;

//成像图片
@property (nonatomic,strong) UIImageView *imagingView;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSMutableArray *arr_data;

@property (nonatomic,strong) UIImage *image_data;

@property (nonatomic,strong) UIImageView *image_system;
@property (nonatomic,strong) UIView *view_sytem;

@end

@implementation CCCameraViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _referenceOrientation = AVCaptureVideoOrientationPortrait;
  
    [self setupUI];
    NSError *error;
    [self setupSession:&error];
    if (!error) {
        [self.previewView setCaptureSessionsion:_captureSession];
        [self startCaptureSession];
    }
    else{
        [self showError:error];
    }
    [self initWhiteView];
    [self judgeMediaAuthorize];
    
    
}

-(void)judgeMediaAuthorize{
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请在iPhone的'设置-隐私-相机'选项中,允许爱淘苗访问你的相机" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        _photoBtn.userInteractionEnabled=NO;
    }else{
        _photoBtn.userInteractionEnabled=YES;
    }
}

-(void)initWhiteView{
    
    _whiteView= [[BezierView alloc] initWithFrame:CGRectMake(60, 64+50, Screen_Width-120, Screen_Width-120)];
    self.photoCutFrame = _whiteView.pathRect;
    [self.view addSubview:_whiteView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    
    [self.whiteView addGestureRecognizer:tap];
    [self.whiteView addGestureRecognizer:doubleTap];
    [tap requireGestureRecognizerToFail:doubleTap];
    
    [self initIndicatorView];
}

#pragma mark - AVCaptureSession life cycle
// 配置会话
- (void)setupSession:(NSError **)error{
    _captureSession = [[AVCaptureSession alloc]init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self setupSessionInputs:error];
    [self setupSessionOutputs:error];
}

// 添加输入
- (void)setupSessionInputs:(NSError **)error{
    // 视频输入
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([_captureSession canAddInput:videoInput]){
            [_captureSession addInput:videoInput];
            _deviceInput = videoInput;
        }
    }
}

// 添加输出
- (void)setupSessionOutputs:(NSError **)error{
    
    // 静态图片输出
    AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];            
    imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    if ([_captureSession canAddOutput:imageOutput]) {
        [_captureSession addOutput:imageOutput];
        _imageOutput = imageOutput;
    }
}

// 开启捕捉
- (void)startCaptureSession
{
    if (!_movieWritingQueue) {
        _movieWritingQueue = dispatch_queue_create("Movie Writing Queue", DISPATCH_QUEUE_SERIAL);
    }
    
    if (!_captureSession.isRunning){
        [_captureSession startRunning];
    }
}

// 停止捕捉
- (void)stopCaptureSession
{
    if (_captureSession.isRunning){
        [_captureSession stopRunning];
    }
}


#pragma mark - 捕捉设备
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {                              
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)activeCamera {                                         
    return _deviceInput.device;
}

- (AVCaptureDevice *)inactiveCamera {                                       
    AVCaptureDevice *device = nil;
    if ([[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1) {
        if ([self activeCamera].position == AVCaptureDevicePositionBack) {  
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        } 
        else{
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}

#pragma mark - 转换前后摄像头
- (void)switchCameraButtonClick:(UIButton *)btn{
    if ([self switchCameras]) {
        btn.selected = !btn.selected;
        [btn setImage:[UIImage imageNamed:@"ico_flash_camera_normal"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"ico_flash_camera_pressed"] forState:UIControlStateNormal];
    }
}

- (BOOL)canSwitchCameras {                                                  
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1;
}

- (BOOL)switchCameras{
    if (![self canSwitchCameras]) {                                         
        return NO;
    }
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];                   
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (videoInput) {
        [_captureSession beginConfiguration];                           
        [_captureSession removeInput:_deviceInput];            
        if ([_captureSession canAddInput:videoInput]) {                 
            [_captureSession addInput:videoInput];
            _deviceInput = videoInput;
        } 
        else{
            [_captureSession addInput:_deviceInput];
        }
        [_captureSession commitConfiguration];     
        
        // 转换摄像头后重新设置视频输出
        [self resetupVideoOutput];
    } 
    else{
        [self showError:error];          
        return NO;
    }
    return YES;
}


-(void)resetupVideoOutput{
    [_captureSession beginConfiguration]; 
    [_captureSession removeOutput:_videoOutput];
    
    AVCaptureVideoDataOutput *videoOut = [[AVCaptureVideoDataOutput alloc] init];
    [videoOut setAlwaysDiscardsLateVideoFrames:YES];
    [videoOut setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
    dispatch_queue_t videoCaptureQueue = dispatch_queue_create("Video Capture Queue", DISPATCH_QUEUE_SERIAL);
    [videoOut setSampleBufferDelegate:self queue:videoCaptureQueue];
    
    if ([_captureSession canAddOutput:videoOut]) {
        [_captureSession addOutput:videoOut];
        _videoOutput = videoOut;
    }
    _videoConnection = [videoOut connectionWithMediaType:AVMediaTypeVideo];
    _videoConnection.videoOrientation = self.referenceOrientation;
    [_captureSession commitConfiguration];
    
    // 开始视频捕捉
    [self startCaptureSession];
}

#pragma mark - 聚焦
-(void)tapAction:(UIGestureRecognizer *)tap{
    
    if ([self cameraSupportsTapToFocus]) {
        CGPoint point = [tap locationInView:self.previewView];
        [self runFocusAnimation:self.focusView point:point];
        
        CGPoint focusPoint = [self captureDevicePointForPoint:point];
        [self focusAtPoint:focusPoint];
    }
}

- (BOOL)cameraSupportsTapToFocus {                                          
    return [[self activeCamera] isFocusPointOfInterestSupported];
}

- (void)focusAtPoint:(CGPoint)point {                                       
    AVCaptureDevice *device = [self activeCamera];
    if ([self cameraSupportsTapToFocus] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {                         
            device.focusPointOfInterest = point;
            device.focusMode = AVCaptureFocusModeAutoFocus;
            [device unlockForConfiguration];
        } 
        else{
            [self showError:error];
        }
    }
}

#pragma mark - 曝光
-(void)doubleTapAction:(UIGestureRecognizer *)tap{
    if ([self cameraSupportsTapToExpose]) {
        CGPoint point = [tap locationInView:self.previewView];
        [self runFocusAnimation:self.exposureView point:point];
        
        CGPoint exposePoint = [self captureDevicePointForPoint:point];
        [self exposeAtPoint:exposePoint];
    }
}

- (BOOL)cameraSupportsTapToExpose {                                         
    return [[self activeCamera] isExposurePointOfInterestSupported];
}

static const NSString *CameraAdjustingExposureContext;
- (void)exposeAtPoint:(CGPoint)point{
    AVCaptureDevice *device = [self activeCamera];
    if ([self cameraSupportsTapToExpose] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {                         
            device.exposurePointOfInterest = point;
            device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
            if ([device isExposureModeSupported:AVCaptureExposureModeLocked]) {
                [device addObserver:self                                    
                         forKeyPath:@"adjustingExposure"
                            options:NSKeyValueObservingOptionNew
                            context:&CameraAdjustingExposureContext];
            }
            [device unlockForConfiguration];
        } 
        else{
            [self showError:error];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &CameraAdjustingExposureContext) {                     
        AVCaptureDevice *device = (AVCaptureDevice *)object;
        if (!device.isAdjustingExposure && [device isExposureModeSupported:AVCaptureExposureModeLocked]) {
            [object removeObserver:self                                     
                        forKeyPath:@"adjustingExposure"
                           context:&CameraAdjustingExposureContext];
            dispatch_async(dispatch_get_main_queue(), ^{                    
                NSError *error;
                if ([device lockForConfiguration:&error]) {
                    device.exposureMode = AVCaptureExposureModeLocked;
                    [device unlockForConfiguration];
                } 
                else{
                    [self showError:error];
                }
            });
        }
    } 
    else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark - 自动聚焦、曝光
-(void)focusAndExposureButtonClick:(UIButton *)btn{
    if ([self resetFocusAndExposureModes]) {
        [self runResetAnimation];
    }
}

- (BOOL)resetFocusAndExposureModes{
    AVCaptureDevice *device = [self activeCamera];
    AVCaptureExposureMode exposureMode = AVCaptureExposureModeContinuousAutoExposure;
    AVCaptureFocusMode focusMode = AVCaptureFocusModeContinuousAutoFocus;
    BOOL canResetFocus = [device isFocusPointOfInterestSupported] && [device isFocusModeSupported:focusMode];
    BOOL canResetExposure = [device isExposurePointOfInterestSupported] && [device isExposureModeSupported:exposureMode];
    CGPoint centerPoint = CGPointMake(0.5f, 0.5f);                          
    NSError *error;
    if ([device lockForConfiguration:&error]) {
        if (canResetFocus) {                                                
            device.focusMode = focusMode;
            device.focusPointOfInterest = centerPoint;
        }
        if (canResetExposure) {                                             
            device.exposureMode = exposureMode;
            device.exposurePointOfInterest = centerPoint;
        }
        [device unlockForConfiguration];
        return YES;
    } 
    else{
        [self showError:error];
        return NO;
    }
}

#pragma mark - 闪光灯
-(void)flashClick:(UIButton *)btn{
    if ([self cameraHasFlash]) {
        btn.selected = !btn.selected;
        if ([self flashMode] == AVCaptureFlashModeOff) {
            self.flashMode = AVCaptureFlashModeOn;
        }
        else if ([self flashMode] == AVCaptureFlashModeOn) {
            self.flashMode = AVCaptureFlashModeOff;
        }
    } 
}

- (BOOL)cameraHasFlash {
    return [[self activeCamera] hasFlash];
}

- (AVCaptureFlashMode)flashMode{
    return [[self activeCamera] flashMode];
}

- (void)setFlashMode:(AVCaptureFlashMode)flashMode{
    // 如果手电筒打开，先关闭手电筒
    if ([self torchMode] == AVCaptureTorchModeOn) {
        [self torchClick:_torchBtn];
    }
    
    AVCaptureDevice *device = [self activeCamera];
    if (device.flashMode != flashMode && [device isFlashModeSupported:flashMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.flashMode = flashMode;
            [device unlockForConfiguration];
        } 
        else{
            [self showError:error];
        }
    }
}

#pragma mark - 手电筒
- (void)torchClick:(UIButton *)btn{
    if ([self cameraHasTorch]) {
        btn.selected = !btn.selected;
        if ([self torchMode] == AVCaptureTorchModeOff) {
            self.torchMode = AVCaptureTorchModeOn;
        }
        else if ([self torchMode] == AVCaptureTorchModeOn) {
            self.torchMode = AVCaptureTorchModeOff;
        }
    }
}

- (BOOL)cameraHasTorch {
    return [[self activeCamera] hasTorch];
}

- (AVCaptureTorchMode)torchMode {
    return [[self activeCamera] torchMode];
}

- (void)setTorchMode:(AVCaptureTorchMode)torchMode{
    
    // 如果闪光灯打开，先关闭闪光灯
    if ([self flashMode] == AVCaptureFlashModeOn) {
        [self flashClick:_flashBtn];
    }
    
    AVCaptureDevice *device = [self activeCamera];
    if (device.torchMode != torchMode && [device isTorchModeSupported:torchMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.torchMode = torchMode;
            [device unlockForConfiguration];
        } 
        else{
            [self showError:error];
        }
    }
}

#pragma mark - 历史拍照
- (void)cancel:(UIButton *)btn{
   
    HistoryPictureController *controller=[[HistoryPictureController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}



#pragma mark  拍照
-(void)takePictureImage{
 
    if (_imagingView==nil) {
        
        AVCaptureConnection *connection = [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
        
        id takePictureSuccess = ^(CMSampleBufferRef sampleBuffer,NSError *error){
            if (sampleBuffer == NULL) {
                [self showError:error];
                return ;
            }
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
            UIImage *image = [[UIImage alloc]initWithData:imageData];
            UIImage *im=[image scaleToSizePerson];
            UIImage *im1=[im getSubImage:self.photoCutFrame];
            NSData *data1=UIImageJPEGRepresentation(im1, 1);
            UIImage *im2=[UIImage imageWithData:data1];
            _image_data=im2;
            
        [self initImageView:image];
            
        };
        [_imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:takePictureSuccess];
        _photoBtn.image=[UIImage imageNamed:@"custom_paizhao_close"];
    }else{
        _photoBtn.image=[UIImage imageNamed:@"custom_paizhao"];
         [_collectionView removeFromSuperview];
        [_arr_data removeAllObjects];
        [_imagingView removeFromSuperview];
        _imagingView=nil;
        [_view_sytem removeFromSuperview];
        _view_sytem=nil;
       
    }
}


#pragma mark - Tools
// 将屏幕坐标系的点转换为摄像头坐标系的点
- (CGPoint)captureDevicePointForPoint:(CGPoint)point {                      
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.previewView.layer;
    return [layer captureDevicePointOfInterestForPoint:point];
}

// 展示错误
- (void)showError:(NSError *)error
{
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void){
        
        [AlerTool showError:error.localizedFailureReason];
    });
}

#pragma mark - 动画
// 聚焦、曝光动画
-(void)runFocusAnimation:(UIView *)view point:(CGPoint)point{
    view.center = point;
    view.hidden = NO;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    }completion:^(BOOL complete) {
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            view.hidden = YES;
            view.transform = CGAffineTransformIdentity;
        });
    }];
}

// 自动聚焦、曝光动画
- (void)runResetAnimation {
    self.focusView.center = CGPointMake(self.whiteView.center.x, self.whiteView.center.y);
    self.exposureView.center = CGPointMake(self.whiteView.center.x, self.whiteView.center.y);
    self.exposureView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    self.focusView.hidden = NO;
    self.focusView.hidden = NO;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.focusView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
        self.exposureView.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1.0);
    }completion:^(BOOL complete) {
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.focusView.hidden = YES;
            self.exposureView.hidden = YES;
            self.focusView.transform = CGAffineTransformIdentity;
            self.exposureView.transform = CGAffineTransformIdentity;
        });
    }];
}

#pragma mark - 初始化UI
- (void)setupUI{
    self.previewView = [[CCVideoPreview alloc]initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Height-49)];
    
    [self.view addSubview:self.previewView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.previewView addSubview:self.focusView];
    [self.previewView addSubview:self.exposureView];
    
  

    // 拍照
    UIImageView *photoButton = [[UIImageView alloc]init];
    photoButton.image=[UIImage imageNamed:@"custom_paizhao"];
    photoButton.userInteractionEnabled=YES;
    [photoButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePictureImage)]];
    photoButton.frame=CGRectMake(_bottomView.bounds.size.width/2-40*K_SCWIDTH, K_SCWIDTH*10,K_SCWIDTH* 80,K_SCWIDTH * 80);
    [self.bottomView addSubview:photoButton];
    _photoBtn = photoButton;
    
    // 历史记录
    cancelButton = [DownButtom buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"历史记录" forState:UIControlStateNormal];
    cancelButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [cancelButton setImage:[UIImage imageNamed:@"history_record"] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton sizeToFit];
    cancelButton.frame=CGRectMake(_bottomView.bounds.size.width-25-_bottomView.bounds.size.height+40, 20, _bottomView.bounds.size.height-40, _bottomView.bounds.size.height-40);
    [self.bottomView addSubview:cancelButton];
    

    UILabel *lbl_title=[[UILabel alloc]init];
    lbl_title.text=@"植达人";
    lbl_title.textColor=[UIColor whiteColor];
    [lbl_title sizeToFit];
    lbl_title.center=CGPointMake(_topView.center.x, _topView.center.y+10);
    [_topView addSubview:lbl_title];
    
    
    // 转换前后摄像头
//    UIButton *switchCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [switchCameraButton setImage:[UIImage imageNamed:@"ico_flash_camera_normal"] forState:UIControlStateNormal];
//    [switchCameraButton addTarget:self action:@selector(switchCameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//   
//    switchCameraButton.frame = CGRectMake(self.topView.bounds.size.width-50, 20, 44, 44);
//    [self.topView addSubview:switchCameraButton];
    
    
    
    CGFloat whiteY =64+50;
    CGFloat whiteH =Screen_Width-120;
    CGFloat marg =40;
    
    // 补光
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [lightButton setBackgroundImage:[UIImage imageNamed:@"light_no_select"] forState:UIControlStateNormal];
    [lightButton setBackgroundImage:[UIImage imageNamed:@"light_select"] forState:UIControlStateSelected];
    [lightButton addTarget:self action:@selector(torchClick:) forControlEvents:UIControlEventTouchUpInside];
   
    lightButton.frame=CGRectMake(Screen_Width-45,whiteY+whiteH/2-marg-10-marg/2, marg, marg);
    [self.view addSubview:lightButton];
    _torchBtn = lightButton;
    
    // 闪光灯
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashButton setBackgroundImage:[UIImage imageNamed:@"flash_light_no_select"] forState:UIControlStateNormal];
    [flashButton setBackgroundImage:[UIImage imageNamed:@"flash_light_select"] forState:UIControlStateSelected];
    [flashButton addTarget:self action:@selector(flashClick:) forControlEvents:UIControlEventTouchUpInside];
   
    flashButton.frame=CGRectMake(Screen_Width-45,whiteY+whiteH/2-marg/2, marg, marg);
    [self.view addSubview:flashButton];
    _flashBtn = flashButton;
    
    // 重置对焦、曝光
//    UIButton *focusAndExposureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [focusAndExposureButton setTitle:@"聚" forState:UIControlStateNormal];
//    [focusAndExposureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [focusAndExposureButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
//    [focusAndExposureButton addTarget:self action:@selector(focusAndExposureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    focusAndExposureButton.titleLabel.font=[UIFont systemFontOfSize:14];
//    focusAndExposureButton.backgroundColor=[UIColor whiteColor];
//    focusAndExposureButton.layer.cornerRadius=8.0;
//    focusAndExposureButton.frame=CGRectMake(Screen_Width-45,whiteY+whiteH/2+5, marg, marg);
//    [self.view addSubview:focusAndExposureButton];
    
    
    //帮助
    UIButton *btn_help = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_help setBackgroundImage:[UIImage imageNamed:@"help_no_select"] forState:UIControlStateNormal];
    [btn_help setBackgroundImage:[UIImage imageNamed:@"help_yes_select"] forState:UIControlStateSelected];
    [btn_help addTarget:self action:@selector(focusAndExposureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   
    btn_help.frame=CGRectMake(Screen_Width-45,whiteY+whiteH/2+marg/2+10, marg, marg);
    [self.view addSubview:btn_help];
    
    
    

    photoImageButton = [DownButtom buttonWithType:UIButtonTypeCustom];
    [photoImageButton setTitle:@"相册" forState:UIControlStateNormal];
    [photoImageButton setImage:[UIImage imageNamed:@"imagePhoto"] forState:UIControlStateNormal];
    [photoImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     photoImageButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [photoImageButton addTarget:self action:@selector(photoImageButton) forControlEvents:UIControlEventTouchUpInside];
   
    photoImageButton.frame=CGRectMake(25, 20,_bottomView.bounds.size.height-40, _bottomView.bounds.size.height-40);
    [self.bottomView addSubview:photoImageButton];

   

}


#pragma mark 相册
-(void)photoImageButton{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

        [self presentViewController:imagePickerController animated:YES
                         completion:^{
                        
                             [_imagingView removeFromSuperview];
                             _imagingView=nil;
                             [_view_sytem removeFromSuperview];
                             [_imagingView removeFromSuperview];
                             _photoBtn.image=[UIImage imageNamed:@"custom_paizhao"];
                        
                         }];
      
    }

}
#pragma mark - UIImagePickerControllerDelegate 相册

//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:NO completion:NULL];
    NSString *const kPublicImageType = @"public.image";
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:kPublicImageType]) {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data=UIImageJPEGRepresentation(image, 1);
        UIImage *image0=[UIImage imageWithData:data];
        UIImage *image_press=[image0 scaleToSizePerson];
        UIImage *image_cut;
    
        if (image_press.size.width>=image_press.size.height) {
            image_cut=[image_press getSubImage:CGRectMake((image_press.size.width-image_press.size.height)/2, 0, image_press.size.height, image_press.size.height)];
        }else{
            image_cut=[image_press getSubImage:CGRectMake(0,(image_press.size.height-image_press.size.width)/2, image_press.size.width, image_press.size.width)];
        }
        _image_data=image_cut;
        NSMutableArray *arr_image=[NSMutableArray new];
        [arr_image addObject:image_cut];
        [self afnetwork:arr_image];
        _view_sytem=[[UIView alloc]init];
        _view_sytem.backgroundColor=[UIColor blackColor];
        _view_sytem.userInteractionEnabled=YES;
        _view_sytem.frame=_previewView.frame;
        [_previewView addSubview:_view_sytem];
        _image_system=[[UIImageView alloc]initWithImage:image];
        _image_system.frame=self.photoCutFrame;
        _image_system.userInteractionEnabled=YES;
        [_view_sytem addSubview:_image_system];
        _photoBtn.image=[UIImage imageNamed:@"custom_paizhao_close"];
        _imagingView=[[UIImageView alloc]init];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
           }];
}

-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width, 64)];
        _topView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    return _topView;
}

-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height - K_SCWIDTH*100-49, Screen_Width, K_SCWIDTH*100)];
        _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    return _bottomView;
}

-(UIView *)focusView{
    if (_focusView == nil) {
        _focusView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150, 150.0f)];
        _focusView.backgroundColor = [UIColor clearColor];
        _focusView.layer.borderColor = [UIColor orangeColor].CGColor;
        _focusView.layer.borderWidth = 5.0f;
        _focusView.hidden = YES;
    }
    return _focusView;
}

-(UIView *)exposureView{
    if (_exposureView == nil) {
        _exposureView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150, 150.0f)];
        _exposureView.backgroundColor = [UIColor clearColor];
        _exposureView.layer.borderColor = [UIColor redColor].CGColor;
        _exposureView.layer.borderWidth = 5.0f;
        _exposureView.hidden = YES;
    }
    return _exposureView;
}

#pragma mark  请求数据
-(void)afnetwork:(NSArray *)arr {
     _photoBtn.userInteractionEnabled=NO;
    cancelButton.userInteractionEnabled=NO;
    photoImageButton.userInteractionEnabled=NO;
     [_previewView bringSubviewToFront:indicatorView];
     [indicatorView startAnimating]; // 开始旋转
    [[NetWorkManager sharedNetWorkManager] POSTFileWithURL:ProjectUrl ArrayPath:arr parameters:nil success:^(NSDictionary *dit) {
        
        _photoBtn.userInteractionEnabled=YES;
        cancelButton.userInteractionEnabled=YES;
        photoImageButton.userInteractionEnabled=YES;
        
        [indicatorView stopAnimating]; // 结束旋转
        [indicatorView setHidesWhenStopped:YES]; //当旋转结束时隐藏
        if (dit!=nil) {
            NSArray *arr=dit[@"data"];
            if (arr.count>0) {
                
                _arr_data=[[NSMutableArray alloc]initWithArray:arr];
                _pageControl.numberOfPages =_arr_data.count;
                _pageControl.currentPage = 0;
                [_imagingView bringSubviewToFront:_collectionView];
                
                [self createLoacalDataPhoto];
            }
            
            [self.collectionView reloadData];
        }

        
    } failure:^(NSString *error) {
       
        [indicatorView stopAnimating]; // 结束旋转
        [indicatorView setHidesWhenStopped:YES]; //当旋转结束时隐藏
        _photoBtn.userInteractionEnabled=YES;
        cancelButton.userInteractionEnabled=YES;
        photoImageButton.userInteractionEnabled=YES;
    }];
}

-(void)initIndicatorView{
    
    CGFloat whiteY =64+50;
    CGFloat whiteH =Screen_Width-120;
    CGFloat marg =40;
    indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.frame=CGRectMake(Screen_Width/2-20,whiteY+whiteH/2-marg/2, marg, marg);
    indicatorView.transform = CGAffineTransformMakeScale(1.6, 1.6);
    [_previewView addSubview:indicatorView];

}


-(void)createLoacalDataPhoto{
    HistoryPhotoModel *model=[[HistoryPhotoModel alloc]init];
    NSArray *arr_content=_arr_data[0];
    model.Id=[[NSUUID UUID] UUIDString];
    model.reliability=arr_content[1];
    model.name=arr_content[2];
    NSData *img_local=UIImagePNGRepresentation(_image_data);
    NSData*data64=[img_local base64EncodedDataWithOptions:0];
    NSString *decodeStr = [[NSString alloc] initWithData:data64 encoding:NSUTF8StringEncoding];
    
    model.image_local=decodeStr;
    model.image_url=decodeStr;
    model.name_English=@"english";
    model.detail=@"有什么说什么";
    model.address=@"深圳市南山区";
    model.createTime=[DateTool getCurrentDate];
    
    [[PhotoDB shareInstance] createTablePhotoTool];
    [[PhotoDB shareInstance] updateLocalPhotoTool:[NSArray arrayWithObject:model]];
}

#pragma mark 高斯模糊处理
-(void)initImageView:(UIImage *)image{
    UIImage *imr=[UIImage rotateImage:image];
    UIImage *imGS=[UIImage boxblurImage:imr withBlurNumber:0.9];
    

    //高斯模糊成像图片
    _imagingView = [[UIImageView alloc] initWithImage:imGS];
    _imagingView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height-49);
    _imagingView.userInteractionEnabled=YES;
    [self.previewView addSubview:_imagingView];
    
    //高斯模糊黑色透明背景图
    UIView *viewGs=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-49)];
    viewGs.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    viewGs.userInteractionEnabled=YES;
    [_imagingView addSubview:viewGs];
    
    
    
    //创建雪花飘落效果的view
    SnowflakeFallingView *snowflakeFallingView = [SnowflakeFallingView snowfladeFallingViewWithBackgroundImageName:_image_data snowImageName:@"" initWithFrame:self.photoCutFrame];
    snowflakeFallingView.userInteractionEnabled=YES;
    __weak typeof(self)weakSelf=self;
    [snowflakeFallingView setFinishAnimotianBlock:^(UIImage *image){
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        [arr addObject:image];
        [weakSelf afnetwork:arr];
    }];
    //开始下雪
    [snowflakeFallingView beginShow];
    
    [_imagingView addSubview:snowflakeFallingView];

    
    
    //白色框内图片
//    UIImageView *viewP=[[UIImageView alloc]initWithFrame:self.photoCutFrame];
//    viewP.image=_image_data;
//    viewP.userInteractionEnabled=YES;
//    [_imagingView addSubview:viewP];
    
    [self initCollectionView];
}



-(void)initCollectionView{
    layout=[[LimitLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, _whiteView.frame.origin.y+_whiteView.bounds.size.height+10, Screen_Width, Screen_Height-(_whiteView.frame.origin.y+_whiteView.bounds.size.height+10)-10-100-49) collectionViewLayout:layout];
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_imagingView addSubview:self.collectionView];
    
     [self.collectionView registerClass:[ShowImageCell class] forCellWithReuseIdentifier:NSStringFromClass([ShowImageCell class])];
    
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(Screen_Width/2-50,_collectionView.frame.origin.y+_collectionView.bounds.size.height-10, 100, 20);
    
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];// 设置非选中页的圆点颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_imagingView addSubview:_pageControl];

}

#pragma mark  UICollectionDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr_data.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   ShowImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShowImageCell class]) forIndexPath:indexPath];
    NSArray *arrData=_arr_data[indexPath.row];
    [cell setCellModel:arrData andImage:_image_data];
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
      return CGSizeMake(230,collectionView.bounds.size.height-20);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,20, 0,0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    int page = scrollView.contentOffset.x / 230;
    _pageControl.currentPage = page;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
