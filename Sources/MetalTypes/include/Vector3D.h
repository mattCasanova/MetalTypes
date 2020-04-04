//
//  Vector3D.h
//  LiquidMetal
//
//  Created by Matt Casanova on 2/24/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//

#ifndef Vector3D_h
#define Vector3D_h

#import <Foundation/Foundation.h>

@class Vector2D;
@class Transform2D;

@interface Vector3D : NSObject

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float z;

@property (nonatomic) float r;
@property (nonatomic) float g;
@property (nonatomic) float b;

- (_Nonnull instancetype) init;
//- (_Nonnull instancetype) initX:(float)x y:(float)y;
//- (_Nonnull instancetype) initWithRotation:(float)radians;
- (_Nonnull instancetype) copy;
- (_Nonnull instancetype) initVector2D:(const Vector2D* _Nonnull)vector;
- (_Nonnull instancetype) initVector3D:(const Vector3D* _Nonnull)vector;
- (_Nonnull instancetype) initScreenProject:(const Vector3D* _Nonnull)point
                                  modelView:(const Transform2D* _Nonnull)modelView
                                 projection:(const Transform2D* _Nonnull)projection
                                   viewPort:(int* _Nonnull)viewPort;

- (_Nonnull instancetype) initScreenUnproject:(const Vector3D* _Nonnull)point
                                    modelView:(const Transform2D* _Nonnull)modelView
                                   projection:(const Transform2D* _Nonnull)projection
                                     viewPort:(int* _Nonnull)viewPort;

//- (Vector2D* _Nonnull)    setX:(float)x andY:(float)y;
- (void)                  setX:(float)x;
- (void)                  setY:(float)y;
- (void)                  setZ:(float)z;
- (void)                  setR:(float)r;
- (void)                  setG:(float)g;
- (void)                  setB:(float)b;
//- (void)                  setRotation:(float)radians;

- (float)                 x;
- (float)                 y;
- (float)                 z;
- (float)                 r;
- (float)                 g;
- (float)                 b;

/*
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
 */
- (Vector3D* _Nonnull)    linearInterpolateTo:(const Vector3D* _Nonnull)rhs atTime:(float)t;

/*
 - (float)                 crossZ:(const Vector2D* _Nonnull)rhs;
 - (float)                 dot:(const Vector2D* _Nonnull)rhs;
 - (float)                 length;
 - (float)                 lengthSquared;
 - (float)                 distanceTo:(const Vector2D* _Nonnull)rhs;
 - (float)                 distanceSquaredTo:(const Vector2D* _Nonnull)rhs;
 - (float)                 getAngle;
 
 - (bool)                  isVectorEqual:(const Vector2D* _Nonnull)rhs;
 - (bool)                  isVectorNotEqual:(const Vector2D* _Nonnull)rhs;
 - (bool)                  isZero;
 */

@end

#endif /* Vector3D_h */
