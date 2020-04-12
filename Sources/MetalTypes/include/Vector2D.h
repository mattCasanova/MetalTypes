//
//  Vector2D.h
//  LiquidMetal
//
//  Created by Matt Casanova on 2/9/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//

#ifndef Vector2D_h
#define Vector2D_h

#import <Foundation/Foundation.h>

@class Vector3D;

@interface Vector2D : NSObject

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic, readonly) float length;
@property (nonatomic, readonly) float lengthSquared;
@property (nonatomic, readonly) float angle;

- (_Nonnull instancetype) init;
- (_Nonnull instancetype) initX:(float)x y:(float)y;
- (_Nonnull instancetype) initWithVector2D:(const Vector2D* _Nonnull)vector;
- (_Nonnull instancetype) initWithVector3D:(const Vector3D* _Nonnull)vector;
- (_Nonnull instancetype) initWithAngle:(float)radians;
- (_Nonnull instancetype) copy;

- (Vector2D* _Nonnull)    setX:(float)x y:(float)y;
- (void)                  setX:(float)x;
- (void)                  setY:(float)y;
- (void)                  setAngle:(float)radians;

- (float)                 x;
- (float)                 y;
- (float)                 angle;

- (Vector2D* _Nonnull)    addToSelf:(const Vector2D* _Nonnull)rhs;
- (Vector2D* _Nonnull)    subtractFromSelf:(const Vector2D* _Nonnull)rhs;
- (Vector2D* _Nonnull)    scaleSelf:(float)scale;
- (Vector2D* _Nonnull)    negateSelf;
- (Vector2D* _Nonnull)    normalizeSelf;

- (Vector2D* _Nonnull)    add:(const Vector2D* _Nonnull)rhs;
- (Vector2D* _Nonnull)    subtract:(const Vector2D* _Nonnull)rhs;
- (Vector2D* _Nonnull)    scale:(float)scale;
- (Vector2D* _Nonnull)    negate;
- (Vector2D* _Nonnull)    normalize;
- (Vector2D* _Nonnull)    projectOnTo:(const Vector2D* _Nonnull)rhs;
- (Vector2D* _Nonnull)    perpendicularProjectOnTo:(const Vector2D* _Nonnull)rhs;
- (Vector2D* _Nonnull)    linearInterpolateTo:(const Vector2D* _Nonnull)rhs atTime:(float)t;

- (float)                 crossZ:(const Vector2D* _Nonnull)rhs;
- (float)                 dot:(const Vector2D* _Nonnull)rhs;
- (float)                 distanceTo:(const Vector2D* _Nonnull)rhs;
- (float)                 distanceSquaredTo:(const Vector2D* _Nonnull)rhs;

- (bool)                  isVectorEqual:(const Vector2D* _Nonnull)rhs;
- (bool)                  isVectorNotEqual:(const Vector2D* _Nonnull)rhs;
- (bool)                  isZero;


@end

#endif /* Vector2D_h */
