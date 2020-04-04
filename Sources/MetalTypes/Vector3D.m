//
//  Vector3D.m
//  LiquidMetal
//
//  Created by Matt Casanova on 2/24/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//

#import "Vector3D.h"
#import <GLKit/GLKMath.h>
#import "Vector2D.h"
#import "Transform2D.h"

@implementation Vector3D  {
  @private GLKVector3 glkVector3;
}

- (_Nonnull instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }\
    
      memset(&glkVector3, 0, sizeof(glkVector3));
    return self;
}

- (_Nonnull instancetype) initVector2D:(const Vector2D* _Nonnull)vector; {
  self = [super init];
  if (!self) {
      return nil;
  }
  
  glkVector3.x = vector.x;
  glkVector3.y = vector.y;
  glkVector3.z = 0;
  
  return self;
}

- (_Nonnull instancetype) initVector3D:(const Vector3D* _Nonnull)vector {
  self = [super init];
  if (!self) {
      return nil;
  }
  
  glkVector3.x = vector.x;
  glkVector3.y = vector.y;
  glkVector3.z = vector.z;
  
  return self;
}

- (_Nonnull instancetype) initScreenProject:(const Vector3D* _Nonnull)point modelView:(const Transform2D* _Nonnull)modelView projection:(const Transform2D* _Nonnull)projection viewPort:(int* _Nonnull)viewPort {
  
  GLKMatrix4* mv = (GLKMatrix4*)modelView.raw;
  GLKMatrix4* p = (GLKMatrix4*)projection.raw;
  
  Vector3D* vec = [[Vector3D alloc] init];
  vec->glkVector3 = GLKMathProject(point->glkVector3, *mv, *p, viewPort);
  return vec;
}
- (_Nonnull instancetype) initScreenUnproject:(const Vector3D* _Nonnull)point modelView:(const Transform2D* _Nonnull)modelView projection:(const Transform2D* _Nonnull)projection viewPort:(int* _Nonnull)viewPort {
  
  GLKMatrix4* mv = (GLKMatrix4*)modelView.raw;
  GLKMatrix4* p = (GLKMatrix4*)projection.raw;
  
  GLKVector3 zero;
  
  bool success = false;
  
  GLKVector3 projected = GLKMathProject(point->glkVector3, *mv, *p, viewPort);
  
  point.z = projected.z;
  
  Vector3D* vec = [[Vector3D alloc] init];
  vec->glkVector3 = GLKMathUnproject(point->glkVector3, *mv, *p, viewPort, &success);
  return vec;
}

- (_Nonnull instancetype)copy {
    Vector3D* copy = [[Vector3D alloc] init];
    copy->glkVector3 = self->glkVector3;
    return copy;
}

- (void)                  setX:(float)x {
    glkVector3.x = x;
}
- (void)                  setY:(float)y {
    glkVector3.y = y;
}
- (void)                  setZ:(float)z {
    glkVector3.z = z;
}

- (void)                  setR:(float)r {
    glkVector3.r = r;
}
- (void)                  setG:(float)g {
    glkVector3.g = g;
}
- (void)                  setB:(float)b {
    glkVector3.b = b;
}


- (float)                 r {
    return glkVector3.r;
}
- (float)                 g {
    return glkVector3.g;
}
- (float)                 b {
    return glkVector3.b;
}

- (float)                 x {
    return glkVector3.x;
}
- (float)                 y {
    return glkVector3.y;
}
- (float)                 z {
    return glkVector3.z;
}

- (Vector3D* _Nonnull) linearInterpolateSelfTo:(const Vector3D* _Nonnull)rhs atTime:(float)t {
    glkVector3 = GLKVector3Lerp(glkVector3, rhs->glkVector3, t);
    return self;
}

- (Vector3D* _Nonnull)    linearInterpolateTo:(const Vector3D* _Nonnull)rhs atTime:(float)t {
    return [[self copy] linearInterpolateSelfTo:rhs atTime:t];
}

@end
