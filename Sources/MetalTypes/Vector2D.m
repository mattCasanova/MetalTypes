//
//  Vector2D.m
//  LiquidMetal
//
//  Created by Matt Casanova on 2/9/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//

#import "Vector2D.h"
#import "Vector3D.h"
#import <GLKit/GLKMath.h>

@implementation Vector2D  {
@private GLKVector2 glkVector2;
}

static const float EPSILON = 0.00001f;

/******************************************************************************/
/*!
 Initializes a Vector2D object
 
 \return
 A newly created Vector2D with x and y set to 0
 */
/******************************************************************************/
- (_Nonnull instancetype)init {
    self = [super init];
    if (self == nil)
        return self;
    
    memset(&glkVector2, 0, sizeof(glkVector2));
    return self;
}
/******************************************************************************/
/*!
 Initializes a Vector2D object
 
 \param x
 The value of x
 
 \param y
 The value of y
 
 \return
 A newly created Vector2D with x and y set to the given values
 */
/******************************************************************************/
- (_Nonnull instancetype)initX:(float)x y:(float)y {
    self = [super init];
    if (self == nil)
        return self;
    
    glkVector2.x = x;
    glkVector2.y = y;
    return self;
}
/**
 
 */
- (_Nonnull instancetype) initWithVector2D:(const Vector2D* _Nonnull)vector {
    self = [super init];
    if (self == nil)
        return self;
    
    glkVector2.x = vector->glkVector2.x;
    glkVector2.y = vector->glkVector2.y;
    return self;
}
/**
 
 */
- (_Nonnull instancetype) initWithVector3D:(const Vector3D* _Nonnull)vector {
    self = [super init];
    if (self == nil)
        return self;
    
    glkVector2.x = vector.x;
    glkVector2.y = vector.y;
    return self;
}

- (_Nonnull instancetype) initWithAngle:(float)radians {
    self = [super init];
    if (self == nil)
        return self;
    
    glkVector2.x = cosf(radians);
    glkVector2.y = sinf(radians);
    return self;
}

/******************************************************************************/
/*!
 Copies a Vector2D Object
 
 \return
 A newly created Vector2D with x and y set to the same values as self
 */
/******************************************************************************/
- (_Nonnull instancetype)copy {
    Vector2D* copy = [[Vector2D alloc] init];
    copy->glkVector2 = self->glkVector2;
    return copy;
}
/******************************************************************************/
/*!
 Sets the values of the vector to the given values.
 
 \param x
 The x value to copy.
 
 \param y
 The y value to copy.
 
 \return
 Self
 
 */
/******************************************************************************/
- (Vector2D* _Nonnull)setX:(float)x y:(float)y {
    glkVector2.x = x;
    glkVector2.y = y;
    return self;
}
/******************************************************************************/
/*!
 Sets the x value of the vector to the given value.
 
 \param x
 The x value to copy.
 
 */
/******************************************************************************/
- (void)setX:(float)x {
    glkVector2.x = x;
}
/******************************************************************************/
/*!
 Sets the y value of the vector to the given value.
 
 \param y
 The y value to copy.
 */
/******************************************************************************/
- (void)setY:(float)y {
    glkVector2.y = y;
}

- (void)setAngle:(float)radians {
    glkVector2.x = cosf(radians);
    glkVector2.y = sinf(radians);
}

/******************************************************************************/
/*!
 Gets the x component of the vector
 
 \return
 The x component of the vector
 */
/******************************************************************************/
- (float) x {
    return glkVector2.x;
}
/******************************************************************************/
/*!
 Gets the y component of the vector
 
 \return
 The y component of the vector
 */
/******************************************************************************/
- (float) y {
    return glkVector2.y;
}
/******************************************************************************/
/*!
 Adds x, y of the two vectors together.
 
 \param rhs
 The vector to add self to.
 
 \return
 self
 
 */
/******************************************************************************/
- (Vector2D* _Nonnull) addToSelf:(const Vector2D* _Nonnull)rhs {
    glkVector2.x += rhs->glkVector2.x;
    glkVector2.y += rhs->glkVector2.y;
    return self;
}
/******************************************************************************/
/*!
 This subtracts x, y of the two vectors. This will subtract
 the rhs from self:
 self = self - rhs;
 
 \param rhs
 The Vector2D to subtract.
 
 \return
 self
 */
/******************************************************************************/
- (Vector2D* _Nonnull) subtractFromSelf:(const Vector2D* _Nonnull)rhs {
    glkVector2.x -= rhs->glkVector2.x;
    glkVector2.y -= rhs->glkVector2.y;
    return self;
}
/******************************************************************************/
/*!
 This scales the x, y of a vector by a specified value.
 
 \param scale
 The value to scale by.
 
 \return
 self after being scaled
 */
/******************************************************************************/
- (Vector2D* _Nonnull) scaleSelf:(float)scale {
    glkVector2.x *= scale;
    glkVector2.y *= scale;
    return self;
}
/******************************************************************************/
/*!
 Negates each component of the Vector: Multiplies each component
 by -1
 
 \return
 A new vector that is a negated copy of self
 */
/******************************************************************************/
- (Vector2D* _Nonnull) negateSelf {
    glkVector2.x *= -1;
    glkVector2.y *= -1;
    return self;
}
/******************************************************************************/
/*!
 Normalizes this vector.
 
 \attention
 This function will crash if you normalize the zero vector.
 
 \return
 self after being normalized.
 
 */
/******************************************************************************/
- (Vector2D* _Nonnull) normalizeSelf {
    float length = sqrtf(glkVector2.x*glkVector2.x + glkVector2.y*glkVector2.y);
    glkVector2.x /= length;
    glkVector2.y /= length;
    return self;
}
/******************************************************************************/
/*!
 Calculates the projection vector of self onto rhs.
 
 \attention
 This function will crash if rhs is the zero vector
 
 \param rhs
 The vector you are projecting onto.
 
 \return
 self after projection of self onto rhs
 */
/******************************************************************************/
- (Vector2D* _Nonnull) projectSelfOnTo:(const Vector2D* _Nonnull)rhs {
    /*Projection is (v.w)/(w.w)*w */
    glkVector2 = GLKVector2Project(glkVector2, rhs->glkVector2);
    return self;
}
/******************************************************************************/
/*!
 Calculates the perpendicular projection vector of self onto rhs.
 
 \attention
 This function will crash if rhs is the zero vector
 
 \param rhs
 The vector you are projecting onto.
 
 \return
 self after the  perpendicular projection of self onto rhs
 */
/******************************************************************************/
- (Vector2D* _Nonnull) perpendicularProjectSelfOnTo:(const Vector2D* _Nonnull)rhs {
    return [self subtractFromSelf:[self projectOnTo:rhs]];
}
/******************************************************************************/
/*!
 Calculates a linear interpolation between two vectors.
 
 \param rhs
 The end vector.  A time of 1 will give you this vector as a result.
 
 \param t 
 The interpolation time.  Doesn't have to be between 0 and 1.
 
 \return
 self after the interpolation of self and rhs at time t
 */
/******************************************************************************/
- (Vector2D* _Nonnull) linearInterpolateSelfTo:(const Vector2D* _Nonnull)rhs atTime:(float)t {
    glkVector2 = GLKVector2Lerp(glkVector2, rhs->glkVector2, t);
    return self;
}
/******************************************************************************/
/*!
 Creates a new vector where the components of self and rhs are
 added together.
 
 \param rhs
 The vector to add to
 
 \return
 A new vector where the components of self and rhs are
 added together.
 
 */
/******************************************************************************/
- (Vector2D* _Nonnull) add:(const Vector2D* _Nonnull)rhs {
    return [[self copy] addToSelf:rhs];
}
/******************************************************************************/
/*!
 Creates a new vector where the components of self and rhs are
 subtracted:
 
 result = self - rhs
 
 \param rhs
 The vector to subtract
 
 \return
 A new vector where the components of self and rhs are
 subtracted:
 
 */
/******************************************************************************/
- (Vector2D* _Nonnull) subtract:(const Vector2D* _Nonnull)rhs {
    return [[self copy] subtractFromSelf:rhs];
}
/******************************************************************************/
/*!
 Creates a new vector where the components are scaled
 
 \param scale
 The value to scale by
 
 \return
 A new vector where the components are scaled
 
 */
/******************************************************************************/
- (Vector2D* _Nonnull) scale:(float)scale {
    return [[self copy] scaleSelf:scale];
}


- (Vector2D* _Nonnull) negate {
    return [[self copy] negateSelf];
}
/******************************************************************************/
/*!
 Returns a normalized copy of this vector
 
 \attention
 This function will crash if you normalize the zero vector.
 
 \return
 A normalized copy of this vector
 
 */
/******************************************************************************/
- (Vector2D* _Nonnull) normalize {
    return [[self copy] normalizeSelf];
}
/******************************************************************************/
/*!
 Calculates the projection vector of self onto rhs.
 
 \attention
 This function will crash if rhs is the zero vector
 
 \param rhs
 The vector you are projecting onto.
 
 \return
 A new vector that is the projection of self onto rhs
 */
/******************************************************************************/
- (Vector2D* _Nonnull) projectOnTo:(const Vector2D* _Nonnull)rhs {
    /*Projection is (v.w)/(w.w)*w */
    return [[self copy] projectSelfOnTo:rhs];
}
/******************************************************************************/
/*!
 Calculates the perpendicular projection vector of self onto rhs.
 
 \attention
 This function will crash if rhs is the zero vector
 
 \param rhs
 The vector you are projecting onto.
 
 \return
 A new vector that is the perpendicular projection of self onto rhs
 */
/******************************************************************************/
- (Vector2D* _Nonnull) perpendicularProjectOnTo:(const Vector2D* _Nonnull)rhs {
    return [[self copy] perpendicularProjectSelfOnTo:rhs];
}
/******************************************************************************/
/*!
 Calculates a linear interpolation between two vectors.
 
 \param rhs
 The end vector.  A time of 1 will give you this vector as a result.
 
 \param t
 The interpolation time.  Doesn't have to be between 0 and 1.
 
 \return
 A new vector that is the iterpolation of self and rhs at time t
 */
/******************************************************************************/
- (Vector2D* _Nonnull) linearInterpolateTo:(const Vector2D* _Nonnull)rhs atTime:(float)t {
    return [[self copy] linearInterpolateSelfTo:rhs atTime:t];
}
/******************************************************************************/
/*!
 Calculates the z value of the cross product between these self and
 rhs.
 
 \param rhs
 The vector2d to cross with.
 
 \return
 The z value of the cross product between the two vectors.
 */
/******************************************************************************/
- (float) crossZ:(const Vector2D* _Nonnull)rhs {
    return (glkVector2.x * rhs->glkVector2.y) - (rhs->glkVector2.x * glkVector2.y);
}
/******************************************************************************/
/*!
 Calculates the Dot Product of two vectors.
 
 \param rhs
 The Vector2D to dot with
 
 \return
 The Dot product of the two vectors.
 */
/******************************************************************************/
- (float) dot:(const Vector2D* _Nonnull)rhs {
    return GLKVector2DotProduct(glkVector2, rhs->glkVector2);
}
/******************************************************************************/
/*!
 Returns the length of the vector.
 
 \return
 The length of the vector.
 */
/******************************************************************************/
- (float) length {
    return GLKVector2Length(glkVector2);
}
/******************************************************************************/
/*!
 Returns the length of the vector squared.
 
 \return
 The length of the vector squared.
 */
/******************************************************************************/
- (float) lengthSquared {
    return GLKVector2DotProduct(glkVector2, glkVector2);
}
/******************************************************************************/
/*!
 Returns the distance between two points.
 
 \attention
 The function is meant to be used with points, not vectors.
 
 \param rhs
 The point to get the distance from
 
 \return
 The distance between to points.
 */
/******************************************************************************/
- (float) distanceTo:(const Vector2D* _Nonnull)rhs {
    return GLKVector2Distance(glkVector2, rhs->glkVector2);
}
/******************************************************************************/
/*!
 Returns the squared distance between two points.
 
 \attention
 The function is meant to be used with points, not vectors.
 
 \param rhs
 The point to get the distance from.
 
 \return
 The squared distance between to points.
 */
/******************************************************************************/
- (float) distanceSquaredTo:(const Vector2D* _Nonnull)rhs {
    return [[self subtract:rhs] lengthSquared];
}
/**
 
 */
- (float) angle {
    return atan2f(glkVector2.y, glkVector2.x);
}

/******************************************************************************/
/*!
 Tests if two Vector2D are  equal within the default epsilon.
 
 \param rhs
 The Vector2D to compare
 
 \return
 True if the Vec2 are  the same, false otherwise.
 */
/******************************************************************************/
- (bool) isVectorEqual:(const Vector2D* _Nonnull)rhs {
    return (fabsf(glkVector2.x - rhs->glkVector2.x) < EPSILON && fabsf(glkVector2.y - rhs->glkVector2.y) < EPSILON);
}
/******************************************************************************/
/*!
 Tests if two Vector2D are not equal within the default epsilon.
 
 \param rhs
 The Vector2D to compare
 
 \return
 True if the Vec2 are not the same, false otherwise.
 */
/******************************************************************************/
- (bool) isVectorNotEqual:(const Vector2D* _Nonnull)rhs {
    return ![self isVectorEqual:rhs];
}
/******************************************************************************/
/*!
 Tests if the x, y members are zero within epsilon
 
 \return
 Returns true if the x, y are zero. False otherwise
 */
/******************************************************************************/
- (bool) isZero {
    /*Test if they are really close to zero*/
    return (fabsf(glkVector2.x) < EPSILON && fabsf(glkVector2.y) < EPSILON);
}

@end
