//
//  TitleScene.m
//  InvadersMove
//
//  Created by zInox on 2015/02/03.
//  Copyright (c) 2015年 zInox. All rights reserved.
//

#import "TitleScene.h"
#import "GameScene.h"
#import "AppDelegate.h"

@implementation TitleScene {
    SKScene *scene;
    SKTransition *transition;

}

- (void)didMoveToView:(SKView *)view {

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    scene = [GameScene sceneWithSize:self.size];
    transition = [SKTransition fadeWithDuration:1.0];

    SKSpriteNode *titleBack = [SKSpriteNode spriteNodeWithImageNamed:@"titleBackGround"];
    titleBack.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    titleBack.xScale = titleBack.yScale = 1.2;

    [self addChild:titleBack];

    //ハイスコアテキスト
    SKLabelNode *scoreTitleNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    scoreTitleNode.fontSize = 15;
    scoreTitleNode.text = @"HI-SCORE";
    scoreTitleNode.fontColor = [UIColor blackColor];
    scoreTitleNode.position = CGPointMake((scoreTitleNode.frame.size.width / 2) + 20,
                                          self.frame.size.height - 30);
    [self addChild:scoreTitleNode];


    //得点
//    SKLabelNode *hiScoreNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
//    hiScoreNode.fontSize = 15;
//    hiScoreNode.fontColor = [UIColor blackColor];
//    [self addChild:hiScoreNode];
//    hiScoreNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 30);


    SKLabelNode *ScoreNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    ScoreNode.fontSize = 15;
    ScoreNode.name = kHighscoreName;
    ScoreNode.fontColor = [SKColor blackColor];
    ScoreNode.position = CGPointMake(CGRectGetMidX(self.frame),
                                     self.frame.size.height - 30);

    ScoreNode.text = [NSString stringWithFormat:@"%d",delegate.score];
    [self addChild:ScoreNode];


    //点滅アクション
    SKLabelNode *pleaseTouch = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    pleaseTouch.text = @"GAME START";
    pleaseTouch.fontSize = 15;
    pleaseTouch.fontColor = [UIColor blackColor];
    pleaseTouch.position = CGPointMake(CGRectGetMidX(self.frame),100);
    [self addChild:pleaseTouch];
    NSArray *actions = @[[SKAction fadeAlphaTo:0.0 duration:0.75],
                         [SKAction fadeAlphaTo:1.0 duration:0.75]];
    SKAction *action = [SKAction repeatActionForever:[SKAction sequence:actions]];
    [pleaseTouch runAction:action];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.view presentScene:scene transition:transition];
}

- (void)update:(NSTimeInterval)currentTime {

}
@end
