//
//  Float2.h
//  
//
//  Created by Matt Casanova on 4/6/20.
//

#ifndef Float2_h
#define Float2_h

#import <Foundation/Foundation.h>


@interface Float2 : NSObject

//@property (nonatomic) float x;
//@property (nonatomic) float y;
@property (nonatomic, readonly) float length;
//@property (nonatomic, readonly) float lengthSquared;
@property (nonatomic, readonly) float angle;

//- (_Nonnull instancetype) init;
- (_Nonnull instancetype) initX:(float)x y:(float)y;
//- (_Nonnull instancetype) initWithFloat2:(const Float2* _Nonnull)vector;
//- (_Nonnull instancetype) initWithAngle:(float)radians;
- (_Nonnull instancetype) copy;

//- (Float2* _Nonnull)    setX:(float)x y:(float)y;
//- (void)                  setX:(float)x;
//- (void)                  setY:(float)y;
//- (void)                  setAngle:(float)radians;


//- (Float2* _Nonnull)    addToSelf:(const Float2* _Nonnull)rhs;
//- (Float2* _Nonnull)    subtractFromSelf:(const Float2* _Nonnull)rhs;
//- (Float2* _Nonnull)    scaleSelf:(float)scale;
//- (Float2* _Nonnull)    negateSelf;
//- (Float2* _Nonnull)    normalizeSelf;

//- (Float2* _Nonnull)    add:(const Float2* _Nonnull)rhs;
//- (Float2* _Nonnull)    subtract:(const Float2* _Nonnull)rhs;
//- (Float2* _Nonnull)    scale:(float)scale;
//- (Float2* _Nonnull)    negate;
//- (Float2* _Nonnull)    normalize;
- (Float2* _Nonnull)    projectOnTo:(const Float2* _Nonnull)rhs;
//- (Float2* _Nonnull)    perpendicularProjectOnTo:(const Float2* _Nonnull)rhs;
//- (Float2* _Nonnull)    linearInterpolateTo:(const Float2* _Nonnull)rhs atTime:(float)t;

//- (float)                 crossZ:(const Float2* _Nonnull)rhs;
//- (float)                 dot:(const Float2* _Nonnull)rhs;
//- (float)                 distanceTo:(const Float2* _Nonnull)rhs;
//- (float)                 distanceSquaredTo:(const Float2* _Nonnull)rhs;

//- (bool)                  isVectorEqual:(const Float2* _Nonnull)rhs;
//- (bool)                  isVectorNotEqual:(const Float2* _Nonnull)rhs;
//- (bool)                  isZero;


@end

#endif /* Float2_h */
