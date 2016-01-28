//
//  ResultScene.m
//  InvadersMove
//
//  Created by zInox on 2015/02/04.
//  Copyright (c) 2015年 zInox. All rights reserved.
//

#import "ResultScene.h"
#import "GameScene.h"
#import "TitleScene.h"
#import "AppDelegate.h"

@implementation ResultScene {
    SKLabelNode *nextStageText;
    SKLabelNode *giveUpText;
    SKScene *scene;
    SKScene *scene1;
    SKTransition *transition;
    NSInteger _highScore;
}

- (void)didMoveToView:(SKView *)view {

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    scene = [GameScene sceneWithSize:self.size];
    scene1 = [TitleScene sceneWithSize:self.size];
    transition = [SKTransition fadeWithDuration:1.0];

    //背景
    SKSpriteNode* space = [SKSpriteNode spriteNodeWithImageNamed:@"resultBackGround"];
    space.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    space.xScale = space.yScale = 1.2;
    [self addChild:space];

    // 次にステーズへ
    nextStageText = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    nextStageText.fontSize = 15;
    nextStageText.fontColor = [SKColor blackColor];
    nextStageText.position = CGPointMake(CGRectGetMidX(self.frame) + 70,
                                         CGRectGetMidY(self.frame) - 50);
    nextStageText.text = @"NEXT STAGE!";

    [self addChild:nextStageText];

    // ギブアップ
    giveUpText = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    giveUpText.fontSize = 15;
    giveUpText.fontColor = [SKColor blackColor];
    giveUpText.position = CGPointMake(CGRectGetMidX(self.frame) - 70,
                                      CGRectGetMidY(self.frame) - 50);
    giveUpText.text = @"GIVE UP…";

    [self addChild:giveUpText];

    //スコア
    SKLabelNode *scoreTitleNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    scoreTitleNode.fontSize = 15;
    scoreTitleNode.fontColor = [SKColor blackColor];
    scoreTitleNode.position = CGPointMake(CGRectGetMidX(self.frame) - 70,
                                          CGRectGetMidY(self.frame) + 90);
    scoreTitleNode.text = @"SCORE";
    [self addChild:scoreTitleNode];

    //ハイスコア
    SKLabelNode *hiScoreTitleNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    hiScoreTitleNode.fontSize = 15;
    hiScoreTitleNode.fontColor = [SKColor blackColor];
    hiScoreTitleNode.text = @"HI-SCORE";
    hiScoreTitleNode.position = CGPointMake(CGRectGetMidX(self.frame) - 70,
                                            CGRectGetMidY(self.frame) + 140);
    [self addChild:hiScoreTitleNode];

    if (_highScore < delegate.score) {
        _highScore = delegate.score;
    }
    SKLabelNode *hiScoreNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    hiScoreNode.fontSize = 20;
    hiScoreNode.fontColor = [SKColor blackColor];
    hiScoreNode.position = CGPointMake(CGRectGetMidX(self.frame) + 70,
                                       CGRectGetMidY(self.frame) + 140);
    hiScoreNode.text = [NSString stringWithFormat:@"%ld", (long)_highScore];
    [self addChild:hiScoreNode];

    SKLabelNode *ScoreNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    ScoreNode.fontSize = 20;
    ScoreNode.name = kHighscoreName;
    ScoreNode.fontColor = [SKColor blackColor];
    ScoreNode.position = CGPointMake(CGRectGetMidX(self.frame) + 70,
                                     CGRectGetMidY(self.frame) + 90);
    ScoreNode.text = [NSString stringWithFormat:@"%d",delegate.score];
    [self addChild:ScoreNode];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [touch locationInNode:self];
    if ([nextStageText containsPoint:touchPos]) {
        NSLog(@"NextStage");
        [self.view presentScene:scene transition:transition];
        
    } else if ([giveUpText containsPoint:touchPos]){
        NSLog(@"GiveUp");
        [self.view presentScene:scene1 transition:transition];
    }
}

@end
