//
//  File.swift
//  
//
//  Created by Matt Casanova on 4/6/20.
//

#import "Float2.h"
#import <simd/Simd.h>

@implementation Float2  {
@private simd_float2 data;
}

- (float)length {
    return simd_length(data);
}

- (_Nonnull instancetype)initX:(float)x y:(float)y {
    self = [super init];
    if (self == nil)
        return self;
    
    data.x = x;
    data.y = y;
    return self;
}

- (_Nonnull instancetype) copy {
    return [[Float2 alloc] initX:data.x y:data.y];
}

- (Float2* _Nonnull) projectSelfOnTo:(const Float2* _Nonnull)rhs {
    /*Projection is (v.w)/(w.w)*w */
    data = simd_project(data, rhs->data);
    return self;
}

- (Float2* _Nonnull)projectOnTo:(const Float2* _Nonnull)rhs {
    return [[self copy] projectSelfOnTo:rhs];
}

@end
