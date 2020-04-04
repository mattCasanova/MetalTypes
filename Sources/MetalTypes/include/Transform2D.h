//
//  Transform2D.h
//  LiquidMetal
//
//  Created by Matt Casanova on 2/8/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//


#ifndef Transform2D_h
#define Transform2D_h

#import <Foundation/Foundation.h>

@class Vector2D;

@interface Transform2D : NSObject 

// Creation Methods
+ (Transform2D* _Nonnull) initPerspective:(float)angleRad aspectRatio:(float)aspect nearZ:(float)nearZ farZ:(float)farZ;
+ (Transform2D* _Nonnull) initOrtho:(float)left right:(float)right top:(float)top bottom:(float)bottom near:(float)near far:(float)far;
+ (Transform2D* _Nonnull) initLookAt:(Vector2D* _Nonnull)eye distance:(float)distance;
+ (Transform2D* _Nonnull) initIdentity;
+ (Transform2D* _Nonnull) initZero;
+ (Transform2D* _Nonnull) initTransposeOf:(Transform2D* _Nonnull)transform;
+ (Transform2D* _Nonnull) initScale:(float)x y:(float)y;
+ (Transform2D* _Nonnull) initScale:(const Vector2D* _Nonnull)vector;
+ (Transform2D* _Nonnull) initRotateZ:(float)radians;
+ (Transform2D* _Nonnull) initTranslate:(float)x y:(float)y zOrder:(float)zOrder;
+ (Transform2D* _Nonnull) initTranslate:(const Vector2D* _Nonnull)vector zOrder:(float)zOrder;
+ (Transform2D* _Nonnull) initScaleX:(float)scaleX scaleY:(float)scaleY radians:(float)radians transX:(float)transX transY:(float)transY zOrder:(float)zOrder;
+ (Transform2D* _Nonnull) initScale:(const Vector2D* _Nonnull)scale radians:(float)radians translate:(const Vector2D* _Nonnull)translate zOrder:(float)zOrder;

 
//Basic Init
- (_Nonnull instancetype)init;
- (_Nonnull instancetype)copy;

- (Transform2D* _Nonnull) setToScale:(float)x y:(float)y;
- (Transform2D* _Nonnull) setToScale:(const Vector2D* _Nonnull)scale ;
- (Transform2D* _Nonnull) setToRotateZ:(float)radians;
- (Transform2D* _Nonnull) setToTranslate:(const Vector2D* _Nonnull)translate zOrder:(float)zOrder;
- (Transform2D* _Nonnull) setToTranslate:(float)x y:(float)y zOrder:(float)zOrder;
- (Transform2D* _Nonnull) setToScaleX:(float)scaleX scaleY:(float)scaleY radians:(float)radians transX:(float)transX transY:(float)transY zOrder:(float)zOrder;
- (Transform2D* _Nonnull) setToScale:(const Vector2D* _Nonnull)scale radians:(float)radians translate:(const Vector2D* _Nonnull)translate zOrder:(float)zOrder;

- (Transform2D* _Nonnull) transposeSelf;
- (Transform2D* _Nonnull) scaleSelf:(float)x y:(float)y;
- (Transform2D* _Nonnull) rotateZSelf:(float)radians;
- (Transform2D* _Nonnull) translateSelf:(float)x y:(float)y zOrder:(float)zOrder;
- (Transform2D* _Nonnull) multiplyLeftSelf:(const Transform2D* _Nonnull)transform;
- (Transform2D* _Nonnull) multiplyRightSelf:(const Transform2D* _Nonnull)transform;

- (void* _Nonnull)        raw;
- (void)                  set:(int)row col:(int)col value:(float)value;
- (float)                 get:(int)row col:(int)col;

- (Transform2D* _Nonnull) transpose;
- (Transform2D* _Nonnull) multiplyLeft:(const Transform2D* _Nonnull)transform;
- (Transform2D* _Nonnull) multiplyRight:(const Transform2D* _Nonnull)transform;
@end

#endif /* Transform2D_h */
