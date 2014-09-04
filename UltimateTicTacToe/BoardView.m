//
//  BoardView.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BoardView.h"
#import "CustomBoard.h"

@implementation BoardView
@synthesize board;
@synthesize xos;
@synthesize borderView;
@synthesize bigView;

- (id)initWithFramePlus:(CGRect)frame size:(int)s position:(int)pos width:(int)width {
    self = [super initWithFrame:frame];
    if (self) {
        size = s;
        position = pos;
        barRadiusW = width;
        barRadiusH = width;
        
        board = [[CustomBoard alloc] initWithFramePlus:self.bounds size:s verticalWidth:barRadiusW horizHeight:barRadiusH];
        [self addSubview:board];
        [self createXOSpaces];
        
//        self.borderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self.borderView setImage:[UIImage imageNamed:@"outline.png"]];
    }
    return self;
}

- (void)createXOSpaces {
    
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            [vals addObject:[[Piece alloc] initWithFrame:
                             CGRectMake(j*self.frame.size.width/size+barRadiusW/2.0, i*self.frame.size.height/size+barRadiusH/2.0,
                                        self.frame.size.width/size-barRadiusW, self.frame.size.height/size-barRadiusH) thickness:0.2 borderWidth:0.5]];
//            [vals addObject:[[UIImageView alloc] initWithFrame:
//                             CGRectMake(j*self.frame.size.width/size+barRadiusW/2.0, i*self.frame.size.height/size+barRadiusH/2.0,
//                                        self.frame.size.width/size-barRadiusW, self.frame.size.height/size-barRadiusH)]];
        }
    }
    [self setXos:vals];
}

- (void)setActive:(BOOL)active {
    if (active) {
        [self setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
    } else {
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)reset {
    for (UIView* v in self.xos) {
        [v removeFromSuperview];
    }
    [self.bigView removeFromSuperview];
//    [self.borderView removeFromSuperview];
}

- (void)reloadPieceColors {
    for (Piece* piece in self.xos) {
        [piece reloadColorValues];
        [piece setNeedsDisplay];
    }
    [self.bigView reloadColorValues];
    [self.bigView setNeedsDisplay];
}

- (void)reloadBarColors {
    [board reloadBarColors];
}

- (void)addXAt:(int)pos light:(BOOL)light {
    Piece* x =[self.xos objectAtIndex:pos];
    [x setType:@"X"];
    [x reloadColorValues];
//    UIImageView* x = [self.xos objectAtIndex:pos];
//    [x setImage:[UIImage imageNamed:@"X.png"]];
    [x setAlpha:(light?0.5:1)];
    [self addSubview:x];
}

- (void)removeXOAt:(int)pos {
    [[self.xos objectAtIndex:pos] removeFromSuperview];
}

- (void)addOAt:(int)pos light:(BOOL)light {
    Piece* o = [self.xos objectAtIndex:pos];
    [o setType:@"O"];
    [o reloadColorValues];
//    UIImageView* o = [self.xos objectAtIndex:pos];
//    [o setImage:[UIImage imageNamed:@"O.png"]];
    [o setAlpha:(light?0.5:1)];
    [self addSubview:o];
}

- (void)addBigX {
    self.bigView = [[Piece alloc] initWithFrame:self.bounds thickness:0.2 borderWidth:2.0];
    [self.bigView setType:@"X"];
    [self.bigView reloadColorValues];
//        self.bigView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [self.bigView setImage:[UIImage imageNamed:@"X.png"]];
        [self.bigView setAlpha:0.35];
        [self addSubview:self.bigView];
}

- (void)addBigO {
    self.bigView = [[Piece alloc] initWithFrame:self.bounds thickness:0.2 borderWidth:2.0];
    [self.bigView setType:@"O"];
    [self.bigView reloadColorValues];
//        self.bigView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [self.bigView setImage:[UIImage imageNamed:@"O.png"]];
        [self.bigView setAlpha:0.35];
        [self addSubview:self.bigView];
}

- (void)addWinnerLine:(int)pos {
    if (pos >= 0) {
//        int r = 3;
        if (pos < size) {
            for (int i = 0; i < size*size; i++) {
                [[self.xos objectAtIndex:i] setAlpha:0.5];
            }
            for (int i = pos*size; i < (pos+1)*size; i++) {
                [[self.xos objectAtIndex:i] setAlpha:1];
            }
//            double height = self.frame.size.height / size;
//            UIImageView* lineView = [[UIImageView alloc] initWithFrame:
//                                     CGRectMake(0, pos*height+height/2 - r, 
//                                                self.frame.size.width, r*2)];
//            [lineView setImage:[UIImage imageNamed:@"horizontalLine.png"]];
//            [lineView setAlpha:0.5];
//            [self addSubview:lineView];
//            [self sendSubviewToBack:lineView];
        } else if (pos < size*2) {
            for (int i = 0; i < size*size; i++) {
                [[self.xos objectAtIndex:i] setAlpha:0.5];
            }
            for (int i = pos-size; i < size*size; i += size) {
                [[self.xos objectAtIndex:i] setAlpha:1];
            }
//            double width = self.frame.size.width / size;
//            UIImageView* lineView = [[UIImageView alloc] initWithFrame:
//                                     CGRectMake((pos-size)*width+ width/2 - r, 
//                                                0, r*2, self.frame.size.height)];
//            [lineView setImage:[UIImage imageNamed:@"verticalLine.png"]];
//            [lineView setAlpha:0.5];
//            [self addSubview:lineView];
//            [self sendSubviewToBack:lineView];
        } else if (pos == size*2) {
            for (int i = 0; i < size*size; i++) {
                [[self.xos objectAtIndex:i] setAlpha:0.5];
            }
            for (int i = 0; i < size*size; i += size+1) {
                [[self.xos objectAtIndex:i] setAlpha:1];
            }
//            UIImageView* lineView = [[UIImageView alloc] initWithFrame:
//                                     CGRectMake(0, 0, self.frame.size.width, 
//                                                self.frame.size.height)];
//            [lineView setImage:[UIImage imageNamed:@"diagonal1.png"]];
//            [lineView setAlpha:0.5];
//            [self addSubview:lineView];
//            [self sendSubviewToBack:lineView];
        } else if (pos == size*2 + 1) {
            for (int i = 0; i < size*size; i++) {
                [[self.xos objectAtIndex:i] setAlpha:0.5];
            }
            for (int i = size-1; i < size*size-1; i += (size-1)) {
                [[self.xos objectAtIndex:i] setAlpha:1];
            }
//            UIImageView* lineView = [[UIImageView alloc] initWithFrame:
//                                     CGRectMake(0, 0, self.frame.size.width, 
//                                                self.frame.size.height)];
//            [lineView setImage:[UIImage imageNamed:@"diagonal2.png"]];
//            [lineView setAlpha:0.5];
//            [self addSubview:lineView];
//            [self sendSubviewToBack:lineView];
        }
    }
}

- (int)inBox:(CGPoint)touch {
    double marginX = self.frame.size.width/size;
    double marginY = self.frame.size.height/size;
    int x = touch.x - self.frame.origin.x;
    int i = floor(x / marginX);
    double difX = x - marginX*i;
    if (difX < barRadiusW*2) {
        return -1;
    } else if (difX > marginX) {
        return -1;
    }
    int y = touch.y - self.frame.origin.y;
    int j = floor(y / marginY);
    double difY = y - marginY*j;
    if (difY < barRadiusH*2) {
        return -1;
    } else if (difY > marginY) {
        return -1;
    }
    return j*size+i;
}

- (BOOL)pointInside:(CGPoint)touch {
    if (touch.x < self.frame.origin.x)
        return FALSE;
    if (touch.x > self.frame.origin.x + self.frame.size.width)
        return FALSE;
    if (touch.y < self.frame.origin.y)
        return FALSE;
    if (touch.y > self.frame.origin.y + self.frame.size.height)
        return FALSE;
    return TRUE;
}

- (void)removeBorder {
//    for (CustomBoard* vBar in verticalBars) {
//        [vBar setAlpha:0.5];
//    }
//    for (CustomBoard* hBar in horizontalBars) {
//        [hBar setAlpha:0.5];
//    }
    
//    [self.borderView removeFromSuperview];
    
    [self setAlpha:0.5];
}

- (void)addBorder {
//    [self addSubview:self.borderView];
    
//    for (CustomBoard* vBar in verticalBars) {
//        [vBar setAlpha:1.0];
//    }
//    for (CustomBoard* hBar in horizontalBars) {
//        [hBar setAlpha:1.0];
//    }
    
    [self setAlpha:1.0];
}

- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle
{
    
    CGFloat angleInRadians = angle * (M_PI / 180);
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGRect imgRect = CGRectMake(0, 0, width, height);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angleInRadians);
    CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, transform);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef bmContext = CGBitmapContextCreate(NULL, rotatedRect.size.width,
                                                   rotatedRect.size.height,
                                                   8, 0, colorSpace,
                                                   (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGContextSetAllowsAntialiasing(bmContext, YES);
    CGContextSetShouldAntialias(bmContext, YES);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM(bmContext, +(rotatedRect.size.width/2),
                          +(rotatedRect.size.height/2));
    CGContextRotateCTM(bmContext, angleInRadians);
    CGContextTranslateCTM(bmContext, -(rotatedRect.size.width/2),
                          -(rotatedRect.size.height/2));
    CGContextDrawImage(bmContext, CGRectMake(0, 0, rotatedRect.size.width, 
                                             rotatedRect.size.height), imgRef);
    
    CGImageRef rotatedImage = CGBitmapContextCreateImage(bmContext);
    CFRelease(bmContext);
    
    return rotatedImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
