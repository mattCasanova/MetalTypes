//
//  Transform2D.m
//  LiquidMetal
//
//  Created by Matt Casanova on 2/8/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//

#import "Transform2D.h"
#import <GLKit/GLKMath.h>
#import "Vector2D.h"

@implementation Transform2D {
@public GLKMatrix4 glkMatrix;
}

#pragma mark - Transform2D creation

-(instancetype)init {
  self = [super init];
  
  if (self == nil) {
    return self;
  }
  
  memset(&glkMatrix, 0, sizeof(glkMatrix));
  return self;
}

- (instancetype)copy{
  Transform2D* copy = [[Transform2D alloc] init];
  copy->glkMatrix = self->glkMatrix;
  return copy;
}

+ (Transform2D* _Nonnull)  initPerspective:(float)angleRad aspectRatio:(float)aspect nearZ:(float)nearZ farZ:(float)farZ {
  Transform2D* transform = [[Transform2D alloc] init];
  transform->glkMatrix = GLKMatrix4MakePerspective(angleRad, aspect, nearZ, farZ);
  return transform;
}

+ (Transform2D* _Nonnull) initOrtho:(float)left right:(float)right top:(float)top bottom:(float)bottom near:(float)near far:(float)far {
  Transform2D* transform = [[Transform2D alloc] init];
  transform->glkMatrix = GLKMatrix4MakeOrtho(left, right, bottom, top, near, far);
  return transform;
}

+ (Transform2D* _Nonnull) initLookAt:(Vector2D* _Nonnull)eye distance:(float)distance {
  //This is what the 3D code should look like.
  
  //vec3 zaxis = normal(eye - target);    // The "forward" vector.
  //vec3 xaxis = normal(cross(up, zaxis));// The "right" vector.
  //vec3 yaxis = cross(zaxis, xaxis);     // The "up" vector.
  
  //Create a 4x4 view matrix from the right, up, forward and eye position vectors
  //(      xaxis.x,            yaxis.x,            zaxis.x,       0 ),
  //(      xaxis.y,            yaxis.y,            zaxis.y,       0 ),
  //(      xaxis.z,            yaxis.z,            zaxis.z,       0 ),
  //(-dot( xaxis, eye ), -dot( yaxis, eye ), -dot( zaxis, eye ),  1 )
  
  //Since this is a 2D only game, I can make some assumptions
  Transform2D* transform = Transform2D.initIdentity;
  transform->glkMatrix.m30 = -[eye x];
  transform->glkMatrix.m31 = -[eye y];
  transform->glkMatrix.m32 = -distance;
  
  return transform;
}

+ (Transform2D* _Nonnull) initIdentity {
  Transform2D* transform = [[Transform2D alloc] init];
  transform->glkMatrix = GLKMatrix4Identity;
  return transform;
}

+ (Transform2D* _Nonnull) initZero {
  return [[Transform2D alloc] init];
}

+ (Transform2D* _Nonnull) initTransposeOf:(Transform2D* _Nonnull)transform {
  Transform2D* obj = [[Transform2D alloc] init];
  obj->glkMatrix = GLKMatrix4Transpose(transform->glkMatrix);
  return obj;
}

+ (Transform2D* _Nonnull) initScale:(float)x y:(float)y {
  Transform2D* transform = [[Transform2D alloc] init];
  return [transform setToScale:x y:y];
}

+ (Transform2D *) initScale:(const Vector2D *)vector {
  Transform2D* transform = [[Transform2D alloc] init];
  return [transform setToScale:vector];
}

+ (Transform2D* _Nonnull) initRotateZ:(float)radians {
  Transform2D* transform = [[Transform2D alloc] init];
  return [transform setToRotateZ:radians];
}

+ (Transform2D* _Nonnull) initTranslate:(float)x y:(float)y zOrder:(float)zOrder {
  Transform2D* transform = [[Transform2D alloc] init];
  return [transform setToTranslate:x y:y zOrder:zOrder];
}

+ (Transform2D* _Nonnull) initTranslate:(const Vector2D *)translate zOrder:(float)zOrder {
  Transform2D* transform = [[Transform2D alloc] init];
  return [transform setToTranslate:translate zOrder:zOrder];
}

+ (Transform2D* _Nonnull) initScaleX:(float)scaleX scaleY:(float)scaleY radians:(float)radians transX:(float)transX transY:(float)transY zOrder:(float)zOrder {
  Transform2D* transform = [[Transform2D alloc] init];
  return [transform setToScaleX:scaleX scaleY:scaleY radians:radians transX:transX transY:transY zOrder:zOrder];
}

+ (Transform2D *)initScale:(const Vector2D *)scale radians:(float)radians translate:(const Vector2D *)translate zOrder:(float)zOrder {
  Transform2D* transform = [[Transform2D alloc] init];
  return [transform setToScale:scale radians:radians translate:translate zOrder:zOrder];
}

- (Transform2D* _Nonnull) setToScale:(float)x y:(float)y {
  glkMatrix = GLKMatrix4MakeScale(x, y, 1);
  return self;
}

- (Transform2D *)setToScale:(const Vector2D *)scale {
  glkMatrix = GLKMatrix4MakeScale(scale.x, scale.y, 1);
  return self;
}

- (Transform2D* _Nonnull) setToRotateZ:(float)radians {
  glkMatrix = GLKMatrix4MakeZRotation(radians);
  return self;
}
- (Transform2D* _Nonnull) setToTranslate:(float)x y:(float)y zOrder:(float)zOrder {
  glkMatrix = GLKMatrix4MakeTranslation(x, y, zOrder);
  return self;
}

- (Transform2D *)setToTranslate:(const Vector2D *)translate zOrder:(float)zOrder {
  glkMatrix = GLKMatrix4MakeTranslation(translate.x, translate.y, zOrder);
  return self;
}

- (Transform2D* _Nonnull) setToScaleX:(float)scaleX scaleY:(float)scaleY radians:(float)radians transX:(float)transX transY:(float)transY zOrder:(float)zOrder {
  
  float sinAngle = sinf(radians);
  float cosAngle = cosf(radians);
  
  
  glkMatrix.m00 = scaleX * cosAngle;
  glkMatrix.m01 = scaleX * sinAngle;
  glkMatrix.m02 = 0;
  glkMatrix.m03 = 0;
  
  glkMatrix.m10 = scaleY * -sinAngle;
  glkMatrix.m11 = scaleY *  cosAngle;
  glkMatrix.m12 = 0;
  glkMatrix.m13 = 0;
  
  glkMatrix.m20 = 0;
  glkMatrix.m21 = 0;
  glkMatrix.m22 = 1;
  glkMatrix.m23 = 0;
  
  glkMatrix.m30 = transX;
  glkMatrix.m31 = transY;
  glkMatrix.m32 = zOrder;
  glkMatrix.m33 = 1;
  
  
  return self;
}

- (Transform2D *)setToScale:(const Vector2D *)scale radians:(float)radians translate:(const Vector2D *)translate zOrder:(float)zOrder {
  [self setToScaleX:scale.x scaleY:scale.y radians:radians transX:translate.x transY:translate.y zOrder:zOrder];
  return self;
}

- (void* _Nonnull)raw {
  return glkMatrix.m;
}

- (Transform2D* _Nonnull) transposeSelf {
  glkMatrix = GLKMatrix4Transpose(glkMatrix);
  return self;
}

- (Transform2D* _Nonnull) scaleSelf:(float)x y:(float)y {
  glkMatrix = GLKMatrix4Scale(glkMatrix, x, y, 1);
  return self;
}

- (Transform2D* _Nonnull) rotateZSelf:(float)radians {
  glkMatrix = GLKMatrix4RotateZ(glkMatrix, radians);
  return self;
}

- (Transform2D* _Nonnull) translateSelf:(float)x y:(float)y zOrder:(float)zOrder {
  glkMatrix = GLKMatrix4Translate(glkMatrix, x, y, zOrder);
  return self;
}

- (Transform2D* _Nonnull) multiplyLeftSelf:(const Transform2D* _Nonnull)transform {
  glkMatrix = GLKMatrix4Multiply(transform->glkMatrix, glkMatrix);
  return self;
}

- (Transform2D* _Nonnull) multiplyRightSelf:(const Transform2D* _Nonnull)transform {
  glkMatrix = GLKMatrix4Multiply(glkMatrix, transform->glkMatrix);
  return self;
}

- (void)set:(int)row col:(int)col value:(float)value {
  glkMatrix.m[row * 4 + col] = value;
}

- (float)get:(int)row col:(int)col {
  return glkMatrix.m[row * 4 + col];
}

- (Transform2D* _Nonnull) transpose {
  return [[self copy] transposeSelf];
}

- (Transform2D* _Nonnull) multiplyLeft:(const Transform2D* _Nonnull)transform {
  return [[self copy] multiplyLeftSelf:transform];
}

- (Transform2D* _Nonnull) multiplyRight:(const Transform2D* _Nonnull)transform {
  return [[self copy] multiplyRightSelf:transform];
}



@end
