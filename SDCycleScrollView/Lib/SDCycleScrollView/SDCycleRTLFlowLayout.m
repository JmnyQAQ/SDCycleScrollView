//
//  SDCycleRTLFlowLayout.m
//  SDCycleScrollView
//
//  Created by Jmny on 2024/10/11.
//  Copyright © 2024 com.jmny.qaq. All rights reserved.
//

#import "SDCycleRTLFlowLayout.h"

@implementation SDCycleRTLFlowLayout

- (BOOL)flipsHorizontallyInOppositeLayoutDirection {
    return (UIApplication.sharedApplication.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft);
}

@end


@interface YYAnimatedImageView (SDCycle)
@end

@implementation YYAnimatedImageView (SDCycle)

+ (void)load {
    
    Method displayLayerMethod = class_getInstanceMethod(self, @selector(displayLayer:));
   
    Method displayLayerNewMethod = class_getInstanceMethod(self, @selector(cycle_displayLayer:));
 
    method_exchangeImplementations(displayLayerMethod, displayLayerNewMethod);
}

- (void)cycle_displayLayer:(CALayer *)layer {
    
    Ivar imgIvar = class_getInstanceVariable([self class], "_curFrame");
    UIImage *img = object_getIvar(self, imgIvar);
    if (img) {
        layer.contents = (__bridge id)img.CGImage;
    } else {
        if (@available(iOS 14.0, *)) {
            [super displayLayer:layer];
        }
    }
}

@end


