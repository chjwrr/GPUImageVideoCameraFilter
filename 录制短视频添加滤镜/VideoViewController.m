//
//  ViewController.m
//  录制短视频添加滤镜
//
//  Created by chj on 2017/5/22.
//  Copyright © 2017年 chj. All rights reserved.
//

#import "VideoViewController.h"

#import "GPUImage.h"
#import "GPUImageBeautifyFilter.h"

@interface VideoViewController ()

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
//屏幕上显示的View
@property (nonatomic, strong) GPUImageView *filterView;

@property (nonatomic, strong)GPUImageMovieWriter *movieWriter;


@property (nonatomic, strong)NSString *playPath;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    
    
}
//漫画反色，黑白色，就像漫画
- (void)SobelEdgeDetectionFilter {
    [self.videoCamera removeAllTargets];
    GPUImageSobelEdgeDetectionFilter *filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}


//浮雕
- (void)EmbossFilter {
    [self.videoCamera removeAllTargets];
    GPUImageEmbossFilter *filter = [[GPUImageEmbossFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}


//水晶球，整个视频就在一个圆的水晶球里面，但是视频是颠倒的
- (void)SphereRefractionFilter {
    [self.videoCamera removeAllTargets];
    GPUImageSphereRefractionFilter *filter = [[GPUImageSphereRefractionFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}
//
//水晶球，整个视频就在一个圆的水晶球里面
- (void)GlassSphereFilter {
    [self.videoCamera removeAllTargets];
    GPUImageGlassSphereFilter *filter = [[GPUImageGlassSphereFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}
//凸面镜
- (void)StretchDistortionFilter {
    [self.videoCamera removeAllTargets];
    GPUImageStretchDistortionFilter *filter = [[GPUImageStretchDistortionFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}

//凹面镜
- (void)PinchDistortionFilter {
    [self.videoCamera removeAllTargets];
    GPUImagePinchDistortionFilter *filter = [[GPUImagePinchDistortionFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}

//鱼眼，中间回凸起
- (void)BulgeDistortionFilter {
    [self.videoCamera removeAllTargets];
    GPUImageBulgeDistortionFilter *filter = [[GPUImageBulgeDistortionFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter setRadius:0.5];//0-1
    [filter setScale:0.5];//-1.0----1.0
    [filter addTarget:self.filterView];
    
}

//旋涡，中间有一个旋涡
- (void)SwirlFilter {
    [self.videoCamera removeAllTargets];
    GPUImageSwirlFilter *filter = [[GPUImageSwirlFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter setRadius:1.0];
    [filter setAngle:0.3];
    [filter addTarget:self.filterView];
    
}

//晕影（类似于镜头，圆的，四周黑色不透明）
- (void)VignetteFilter {
    [self.videoCamera removeAllTargets];
    GPUImageVignetteFilter *filter = [[GPUImageVignetteFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}

//监控（黑白色）
- (void)ColorPackingFilter {
    [self.videoCamera removeAllTargets];
    GPUImageColorPackingFilter *filter = [[GPUImageColorPackingFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}
//卡通
- (void)SmoothToonFilter {
    [self.videoCamera removeAllTargets];
    GPUImageSmoothToonFilter *filter = [[GPUImageSmoothToonFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
}
//素描
- (void)SketchFilter {
    [self.videoCamera removeAllTargets];
    GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];

}

//褐色怀旧
- (void)FSKSepiaFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc]init];
    sepiaFilter.intensity = 0.4;
    [self.videoCamera addTarget:sepiaFilter];
    [sepiaFilter addTarget:self.filterView];
}
//单色过滤器
- (void)FSKMonochromeFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc]init];
    monochromeFilter.intensity = 0.4;
    monochromeFilter.color = (GPUVector4){
        1.f, 0.f, 1.f, 0.f
    };
    [monochromeFilter setColorRed:0.3 green:0.4 blue:0.5];
    [self.videoCamera addTarget:monochromeFilter];
    [monochromeFilter addTarget:self.filterView];
}
//灰度
- (void)FSKGrayscaleFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageGrayscaleFilter *grayscaleFilter = [[GPUImageGrayscaleFilter alloc]init];
    [self.videoCamera addTarget:grayscaleFilter];
    [grayscaleFilter addTarget:self.filterView];
}
//反色，颜色相反
- (void)FSKColorInvertFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageColorInvertFilter *colorInvertFilter = [[GPUImageColorInvertFilter alloc]init];
    [self.videoCamera addTarget:colorInvertFilter];
    [colorInvertFilter addTarget:self.filterView];
}
//查询过滤器
- (void)FSKLookupFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageLookupFilter *lookupFilter = [[GPUImageLookupFilter alloc]init];
    lookupFilter.intensity = 0.4;
    [self.videoCamera addTarget:lookupFilter];
    [lookupFilter addTarget:self.filterView];
}
//高亮投影过滤器
- (void)FSKHighlightShadowFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageHighlightShadowFilter *highlightShadowFilter = [[GPUImageHighlightShadowFilter alloc]init];
    highlightShadowFilter.shadows = 0.4;
    highlightShadowFilter.highlights = 0.4;
    [self.videoCamera addTarget:highlightShadowFilter];
    [highlightShadowFilter addTarget:self.filterView];
}
//柔化过滤器
- (void)FSKSoftEleganceFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageSoftEleganceFilter *softEleganceFilter = [[GPUImageSoftEleganceFilter alloc]init];
    [self.videoCamera addTarget:softEleganceFilter];
    [softEleganceFilter addTarget:self.filterView];
}
//彩色矩阵过滤器
- (void)FSKMatrixFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageColorMatrixFilter *matrixFilter = [[GPUImageColorMatrixFilter alloc]init];
    matrixFilter.colorMatrix = (GPUMatrix4x4){
        {1.f, 0.f, 1.f, 0.f},
        {0.f, 1.f, 0.f, 0.f},
        {0.f, 0.f, 1.f, 0.f},
        {0.f, 1.f, 0.f, 1.f}
    };
    matrixFilter.intensity = 0.5;
    [self.videoCamera addTarget:matrixFilter];
    [matrixFilter addTarget:self.filterView];
}
//曝光度
- (void)FSKExposureFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageExposureFilter *exposureFilte = [[GPUImageExposureFilter alloc]init];
    exposureFilte.exposure = 0.3;
    [self.videoCamera addTarget:exposureFilte];
    [exposureFilte addTarget:self.filterView];
}

//伽马线
- (void)FSKGammaFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc]init];
    gammaFilter.gamma = 0.2;
    [self.videoCamera addTarget:gammaFilter];[self.videoCamera removeAllTargets];
    [gammaFilter addTarget:self.filterView];
    
}
//美颜滤镜
- (void)FSKBeautifyFilter
{
    [self.videoCamera removeAllTargets];
    GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
    [self.videoCamera addTarget:beautifyFilter];
    [beautifyFilter addTarget:self.filterView];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
