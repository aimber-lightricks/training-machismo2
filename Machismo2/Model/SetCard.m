//
//  SetCard.m
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "SetCard.h"
static const int kSetScore = 1;

@interface SetCard ()
@property (nonatomic, readwrite) NSUInteger shape;
@property (nonatomic, readwrite) NSUInteger color;
@property (nonatomic, readwrite) NSUInteger stripping;

@end

@implementation SetCard

- (instancetype) initWithShape:(NSUInteger)shape
                     withColor:(NSUInteger)color
                 withStripping:(NSUInteger)stripping {
  if (self = [super init]){
    self.color = color;
    self.shape = shape;
    self.stripping = stripping;
  }
  return self;
}


- (id) getAttributeFromNSString:(NSString *)attributeString {
  return [self valueForKey:attributeString];
}


- (BOOL)isSet: (NSArray *)otherCards forAttribute:(NSString *)attributeString {
  NSMutableSet * attributeSet = [[NSMutableSet alloc] init];
  [attributeSet addObject: [self getAttributeFromNSString:attributeString]];
  for (SetCard *otherCard in otherCards){
    [attributeSet addObject: [otherCard getAttributeFromNSString:attributeString]];
  }
  BOOL allTheSame = [ attributeSet count ] == 1;
  BOOL allDifferent = [ attributeSet count ] == [otherCards count] + 1;
  
  return allTheSame || allDifferent;
}


- (BOOL)isSet:(NSArray *)otherCards {
  for (NSString *attributeString in [SetCard validAttributeStrings]){
    if (![self isSet:otherCards forAttribute:attributeString]){
      return NO;
    }
  }
  return YES;
}

- (int)match:(NSArray *)otherCards{
  if (![self isSet:otherCards]) return 0;
  return kSetScore;
    
}

- (NSString *)contents {
  return nil;
}


+ (NSArray *)validAttributeStrings {
  return @[@"shape", @"color", @"stripping"];
}

  
@end
