//
//  GameScene.m
//  InvadersMove
//
//  Created by zInox on 2015/01/20.
//  Copyright (c) 2015年 zInox. All rights reserved.
//

#import "TitleScene.h"
#import "GameScene.h"
#import "ResultScene.h"
#import "InvadersGrid.h"

@implementation GameScene {
    SKSpriteNode *player;
    SKSpriteNode *invaders;
    SKSpriteNode *invaders2;
    SKSpriteNode *invaders3;
    SKSpriteNode *playerLives;
    SKSpriteNode *playerLives2;

    SKAction *shootSound;
    SKAction *invaderKillSound;
    SKAction *playerDeadSound;
    SKAction *ufoSound;

    SKTexture *ufoTexture;
    SKTexture *lazerTexture;
    SKTexture *invader1Texture1;
    SKTexture *invader1Texture2;
    SKTexture *invader2Texture1;
    SKTexture *invader2Texture2;
    SKTexture *invader3Texture1;
    SKTexture *invader3Texture2;
    SKTexture *enemyLazerTexture1;
    SKTexture *enemyLazerTexture2;

    NSMutableArray *invaderCount;
    SKEmitterNode *particle;
    SKScene *scene;
    SKScene *scene1;
    SKTransition *transition;

    float speed;
    BOOL playerTouch;
    BOOL shoot;
    BOOL gameOver;

}

- (void)didMoveToView:(SKView *)view {

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.score = 0;
    self.physicsWorld.contactDelegate = self;
    self.backgroundColor = [SKColor blackColor];

    scene = [ResultScene sceneWithSize:self.size];
    scene1 = [TitleScene sceneWithSize:self.size];
    transition = [SKTransition fadeWithDuration:1.0];
    self.lives = 3;

    shoot = YES;
    playerTouch = YES;
    gameOver = YES;

    //=============================================
    // スコア
    SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    score.text = @"SCORE : ";
    score.fontSize = 15;
    score.fontColor = [SKColor whiteColor];
    score.position = CGPointMake(40, 10);
    [self addChild:score];

    SKLabelNode *scoreNode = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
    scoreNode.text = @"0";
    scoreNode.fontSize = 15;
    scoreNode.name = kScoreName;
    self.score = 0;
    scoreNode.fontColor = [SKColor whiteColor];
    scoreNode.position = CGPointMake(score.position.x + 55, score.position.y);
    [self addChild:scoreNode];


    //==============================================
    // テクスチャ
    invader1Texture1 = [SKTexture textureWithImageNamed:@"invader1Open"];
    invader1Texture2 = [SKTexture textureWithImageNamed:@"invader1Close"];
    invader2Texture1 = [SKTexture textureWithImageNamed:@"invader2Open"];
    invader2Texture2 = [SKTexture textureWithImageNamed:@"invader2Close"];
    invader3Texture1 = [SKTexture textureWithImageNamed:@"invader3Open"];
    invader3Texture2 = [SKTexture textureWithImageNamed:@"invader3Close"];

    enemyLazerTexture1 = [SKTexture textureWithImageNamed:@"enemyLazer"];
    enemyLazerTexture2 = [SKTexture textureWithImageNamed:@"enemyLazerTurn"];

    lazerTexture = [SKTexture textureWithImageNamed:@"playerLazer"];
    ufoTexture = [SKTexture textureWithImageNamed:@"invader4"];

    //==============================================

    shootSound = [SKAction playSoundFileNamed:@"shoot.wav" waitForCompletion:YES];
    invaderKillSound = [SKAction playSoundFileNamed:@"invaderkilled.wav" waitForCompletion:YES];
    playerDeadSound = [SKAction playSoundFileNamed:@"explosion.wav" waitForCompletion:YES];
    ufoSound = [SKAction playSoundFileNamed:@"ufo_lowpitch.wav" waitForCompletion:YES];

    speed = 0.2;

    //==============================================
    // プレイヤー
    player = [SKSpriteNode spriteNodeWithImageNamed:@"playerShip"];
    player.position = CGPointMake(self.size.width / 2, self.size.height / 7);
    player.name = kPlayerName;

    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.physicsBody.affectedByGravity = NO;//重力適用なし
    player.physicsBody.allowsRotation = NO;	//衝突による角度変更なし

    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.collisionBitMask = 0;

    [self addChild:player];

    //==============================================
    // 壁
    for (int x = 0; x < 4 ; x++) {
        for (int y = 0; y < 2; y++) {
            SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(10, 10)];
            wall.xScale = wall.yScale = 1.1;
            wall.position = CGPointMake(self.size.width / 6 + x * 10, player.position.y + y * 10 + 70);
            wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.frame.size];
            wall.physicsBody.affectedByGravity = NO;
            wall.physicsBody.allowsRotation = NO;
            wall.name = kWallName;

            wall.physicsBody.categoryBitMask = wallCategory;
            wall.physicsBody.collisionBitMask = 0;
            wall.physicsBody.contactTestBitMask = 0;

            [self addChild:wall];
        }
    }

    for (int x = 0; x < 4 ; x++) {
        for (int y = 0; y < 2; y++) {
            SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(10, 10)];
            wall.xScale = wall.yScale = 1.1;
            wall.position = CGPointMake(self.size.width / 1.3 + x * 10, player.position.y + y * 10 + 70);
            wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.frame.size];
            wall.physicsBody.affectedByGravity = NO;
            wall.physicsBody.allowsRotation = NO;
            wall.name = kWallName;

            wall.physicsBody.categoryBitMask = wallCategory;
            wall.physicsBody.collisionBitMask = 0;
            wall.physicsBody.collisionBitMask = 0;
            [self addChild:wall];
        }
    }

    for (int x = 0; x < 4 ; x++) {
        for (int y = 0; y < 2; y++) {
            SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(10, 10)];
            wall.xScale = wall.yScale = 1.1;
            wall.position = CGPointMake(self.size.width / 2.15 + x * 10, player.position.y + y * 10 + 70);
            wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.frame.size];
            wall.physicsBody.affectedByGravity = NO;
            wall.physicsBody.allowsRotation = NO;
            wall.name = kWallName;

            wall.physicsBody.categoryBitMask = wallCategory;
            wall.physicsBody.collisionBitMask = 0;
            wall.physicsBody.collisionBitMask = 0;
            [self addChild:wall];
        }
    }


    //==============================================
    // 残機
    playerLives = [SKSpriteNode node];
    playerLives = [SKSpriteNode spriteNodeWithImageNamed:@"playerShip"];
    playerLives.name = kPlayerLivesName;
    playerLives.xScale = playerLives.yScale = 0.7;
    playerLives.position = CGPointMake(self.size.width - 80, 20);

    playerLives2 = [SKSpriteNode node];
    playerLives2 = [SKSpriteNode spriteNodeWithImageNamed:@"playerShip"];
    playerLives2.name = kPlayerLivesName;
    playerLives2.xScale = playerLives2.yScale = 0.7;
    playerLives2.position = CGPointMake(playerLives.position.x + 50, 20);

    [self addChild:playerLives];
    [self addChild:playerLives2];


    //==============================================
    // インベーダー
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 8; j++) {
            invaders = [SKSpriteNode node];
            invaders = [SKSpriteNode spriteNodeWithTexture:invader1Texture2];

            invaders.position = CGPointMake(self.frame.size.width / 7.5 + j * 40,
                                            self.frame.size.height / 1.5 + i * 30);
            invaders.name = kEnemyName;

            invaders.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(invaders.frame.size.width + 15,
                                                                                     invaders.frame.size.height + 10)];
            invaders.physicsBody.affectedByGravity = NO;    
            invaders.physicsBody.allowsRotation = NO;

            invaders.physicsBody.categoryBitMask = enemyCategory;
            invaders.physicsBody.contactTestBitMask = 0;
            invaders.physicsBody.collisionBitMask = 0;

            [self addChild:invaders];

            SKAction *animation = [SKAction animateWithTextures:@[invader1Texture1, invader1Texture2] timePerFrame:0.6];
            [invaders runAction:[SKAction repeatActionForever:animation]];

        }
    }

    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 8; j++) {
            invaders2 = [SKSpriteNode node];
            invaders2 = [SKSpriteNode spriteNodeWithTexture:invader2Texture2];

            invaders2.position = CGPointMake(self.frame.size.width / 7.5 + j * 40,
                                            self.frame.size.height / 1.5 + i * 30 + 62.5);
            invaders2.name = kEnemyName;

            invaders2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(invaders2.frame.size.width + 15,
                                                                                     invaders2.frame.size.height + 10)];
            invaders2.physicsBody.affectedByGravity = NO;
            invaders2.physicsBody.allowsRotation = NO;

            invaders2.physicsBody.categoryBitMask = enemyCategory;
            invaders2.physicsBody.contactTestBitMask = 0;
            invaders2.physicsBody.collisionBitMask = 0;

            [self addChild:invaders2];

            SKAction *animation = [SKAction animateWithTextures:@[invader2Texture1, invader2Texture2] timePerFrame:0.6];
            [invaders2 runAction:[SKAction repeatActionForever:animation]];
            
        }
    }

    for (int i = 0; i < 1; i++) {
        for (int j = 0; j < 8; j++) {
            invaders3 = [SKSpriteNode node];
            invaders3 = [SKSpriteNode spriteNodeWithTexture:invader3Texture2];

            invaders3.position = CGPointMake(self.frame.size.width / 7.5 + j * 40,
                                            self.frame.size.height / 1.5 + i * 30 + 122.5);
            invaders3.name = kEnemyName;

            invaders3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(invaders3.frame.size.width + 15,
                                                                                     invaders3.frame.size.height + 10)];
            invaders3.physicsBody.affectedByGravity = NO;
            invaders3.physicsBody.allowsRotation = NO;

            invaders3.physicsBody.categoryBitMask = enemyCategory;
            invaders3.physicsBody.contactTestBitMask = 0;
            invaders3.physicsBody.collisionBitMask = 0;

            [self addChild:invaders3];

            SKAction *animation = [SKAction animateWithTextures:@[invader3Texture1,invader3Texture2] timePerFrame:0.6];
            [invaders3 runAction:[SKAction repeatActionForever:animation]];
            
        }
    }

    //==============================================
    // UFO
    [NSTimer scheduledTimerWithTimeInterval:arc4random() % 20 + 10
                                     target:self
                                   selector:@selector(ufoSpawn)
                                   userInfo:nil
                                    repeats:YES];


    //==============================================
}

- (void)playerSpawn {
    player.hidden = NO;
    
}

- (void)ufoSpawn {
    if (gameOver) {
        SKSpriteNode *ufo = [SKSpriteNode spriteNodeWithTexture:ufoTexture];
        ufo.position = CGPointMake(self.size.width / 1.05 , self.size.height / 1.05);
        ufo.xScale = ufo.yScale = 1.2;
        ufo.name = kUfoName;

        ufo.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ufo.frame.size];
        ufo.physicsBody.affectedByGravity = NO;
        ufo.physicsBody.allowsRotation = NO;

        ufo.physicsBody.categoryBitMask = ufoCategory;
        ufo.physicsBody.contactTestBitMask = 0;
        ufo.physicsBody.collisionBitMask = 0;

        SKAction *moveUfo = [SKAction moveToX:-25 duration:2];

        [self addChild:ufo];
        [self runAction:ufoSound];
        [ufo runAction:moveUfo];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (gameOver) {
            if ([player containsPoint:location]) {
                if (player.hidden == NO) {
                    if (playerTouch == YES) {
                        NSLog(@"PlayerTouch");

                        playerTouch = NO;

                        CGPoint player_pt = player.position;    
                        SKSpriteNode *lazer = [SKSpriteNode spriteNodeWithTexture:lazerTexture];
                        lazer.position = CGPointMake(player_pt.x, player_pt.y + 10);
                        lazer.name = kLazerName;
                        lazer.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:lazer.frame.size];
                        lazer.physicsBody.velocity = CGVectorMake(0, 1200);
                        lazer.physicsBody.affectedByGravity = NO;//重力適用なし
                        lazer.physicsBody.allowsRotation = NO;	//衝突による角度変更なし

                        lazer.physicsBody.categoryBitMask = lazerCategory;
                        lazer.physicsBody.contactTestBitMask = enemyCategory | wallCategory | ufoCategory;
                        lazer.physicsBody.collisionBitMask = enemyCategory | wallCategory | ufoCategory;

                        [self addChild:lazer];
                        [lazer runAction:shootSound];

                        SKAction *dura = [SKAction waitForDuration:1];
                        [player runAction:dura completion:^{
                            playerTouch = YES;

                        }];
                }
            }

            } else {
                NSLog(@"OtherTouch");
                CGFloat x = location.x;
                CGFloat diff = fabs(player.position.x - x);
                CGFloat duration = playerSpeed * diff / self.frame.size.height;
                SKAction *move = [SKAction moveToX:x duration:duration];
                [player runAction:move];
            }
        } else if (!gameOver) {
            [self.view presentScene:scene1 transition:transition];
        }
    }
}

- (void)particle:(CGPoint)point {
    if (particle == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"];
        particle = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        particle.numParticlesToEmit = 50;
        [self addChild:particle];
    } else {
        [particle resetSimulation];
    }
    particle.position = point;
}

- (void)update:(NSTimeInterval)currentTime {
    if(gameOver) {
        [self invadersMove:currentTime];
        [self invadersShooting:currentTime];
    }
}

- (void)invadersMove:(NSTimeInterval)currentTime {
    BOOL __block contact = NO;
    [self enumerateChildNodesWithName:kEnemyName usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x + speed, node.position.y);
        if (CGRectGetMaxX(node.frame) > node.scene.size.width) {
            contact = YES;

        } else if (CGRectGetMinX(node.frame) < 0) {
            contact = YES;
        }

    }];

    if (contact) {
        speed *= -1;
        [self enumerateChildNodesWithName:kEnemyName usingBlock:^(SKNode *node, BOOL *stop) {
            node.position = CGPointMake(node.position.x, node.position.y - 10);

        }];
    }
}   

- (void)invadersShooting:(NSTimeInterval)currentTime {
    invaderCount = [NSMutableArray array];
    [self enumerateChildNodesWithName:kEnemyName usingBlock:^(SKNode *node, BOOL *stop) {
        [invaderCount addObject:node];
    }];
    if ([invaderCount count] > 0) {
        if (shoot) {
            NSUInteger randomInva = arc4random_uniform((int32_t)invaderCount.count);
            SKNode *invader = [invaderCount objectAtIndex:randomInva];
            SKSpriteNode *enemyLazer = [SKSpriteNode spriteNodeWithTexture:enemyLazerTexture1];
            enemyLazer.position = CGPointMake(invader.position.x, invader.position.y);
            enemyLazer.name = kEnemyLazerName;
            enemyLazer.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemyLazer.frame.size];
            enemyLazer.physicsBody.affectedByGravity = NO;
            enemyLazer.physicsBody.allowsRotation = NO;
            enemyLazer.physicsBody.velocity = CGVectorMake(0, -300);

            enemyLazer.physicsBody.categoryBitMask = enemyLazerCategory;
            enemyLazer.physicsBody.collisionBitMask = playerCategory | wallCategory;
            enemyLazer.physicsBody.contactTestBitMask = playerCategory | wallCategory;

            [self addChild:enemyLazer];
            SKAction *animation = [SKAction animateWithTextures:@[enemyLazerTexture2, enemyLazerTexture1] timePerFrame:0.1];
            [enemyLazer runAction:[SKAction repeatActionForever:animation]];
            shoot = NO;
            SKAction *dura = [SKAction waitForDuration:2 withRange:1];
            [self runAction:dura completion:^{
                shoot = YES;

            }];
        }

    }

}

- (void)setScore:(int)score {
    _score = score;

    SKLabelNode *scoreNode;
    scoreNode = (SKLabelNode*)[self childNodeWithName:kScoreName];
    scoreNode.text = [NSString stringWithFormat:@"%d", _score];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *bodyNameA = contact.bodyA.node.name;
    NSString *bodyNameB = contact.bodyB.node.name;
    NSLog(@"bodyA = %@",bodyNameA);
    NSLog(@"bodyB = %@",bodyNameB);

    if ([bodyNameA isEqualToString:kEnemyName] | [bodyNameA isEqualToString:kLazerName] | [bodyNameA isEqualToString:kUfoName]) {
        if ([bodyNameB isEqualToString:kLazerName] | [bodyNameB isEqualToString:kEnemyName] | [bodyNameB isEqualToString:kUfoName]) {
            [contact.bodyA.node removeFromParent];
            [contact.bodyB.node removeFromParent];
            [self runAction:invaderKillSound];
            [self particle:contact.contactPoint];
            speed *= 1.06;
            delegate.score += 10;
            self.score += 10;

            //=====================================
            // Game Clear
            invaderCount = [NSMutableArray array];
            [self enumerateChildNodesWithName:kEnemyName usingBlock:^(SKNode *node, BOOL *stop) {
                [invaderCount addObject:node];
            }];

            if (invaderCount.count == 0) {
                [self.view presentScene:scene transition:transition];
            }
            //=====================================
        }

    } else if ([bodyNameA isEqualToString:kPlayerName] | [bodyNameA isEqualToString:kEnemyLazerName]) {
        if ([bodyNameB isEqualToString:kEnemyLazerName] | [bodyNameB isEqualToString:kPlayerName]) {
            if (player.hidden == NO) {
                player.hidden = YES;
                [contact.bodyB.node removeFromParent];
                [self particle:contact.contactPoint];
                [self runAction:playerDeadSound];

                self.lives -= 1;
                if (self.lives == 2) {
                    [playerLives removeFromParent];
                    SKAction *waitAndSpawn = [SKAction sequence:@[[SKAction waitForDuration:1.0],
                                                                  [SKAction performSelector:@selector(playerSpawn) onTarget:self]]];
                    [self runAction:waitAndSpawn];
                } else if (self.lives == 1) {
                    [playerLives2 removeFromParent];
                    SKAction *waitAndSpawn = [SKAction sequence:@[[SKAction waitForDuration:1.0],
                                                                  [SKAction performSelector:@selector(playerSpawn) onTarget:self]]];
                    [self runAction:waitAndSpawn];

                } else if (self.lives == 0) {
                    gameOver = NO;

                    SKLabelNode *gameOverText = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
                    gameOverText.text = @"GAME OVER";
                    gameOverText.fontColor = [UIColor redColor];
                    gameOverText.position = CGPointMake(CGRectGetMidX(self.frame),
                                                        CGRectGetMidY(self.frame) + 50);

                    SKLabelNode *pleaseTouch = [SKLabelNode labelNodeWithFontNamed:@"Space-Invaders"];
                    pleaseTouch.text = @"Please, touch the screen";
                    pleaseTouch.fontSize = 10;
                    pleaseTouch.fontColor = [UIColor redColor];
                    pleaseTouch.position = CGPointMake(gameOverText.position.x, gameOverText.position.y - 50);

                    NSArray *actions = @[[SKAction fadeAlphaTo:0.0 duration:0.75],
                                         [SKAction fadeAlphaTo:1.0 duration:0.75]];
                    SKAction *action = [SKAction repeatActionForever:[SKAction sequence:actions]];
                    [pleaseTouch runAction:action];

                    [self addChild:pleaseTouch];
                    [self addChild:gameOverText];

                }
            }
        }

    } else if ([bodyNameA isEqualToString:kWallName] | [bodyNameA isEqualToString:kEnemyLazerName] | [bodyNameA isEqualToString:kLazerName] | [bodyNameA isEqualToString:nil]) {
        if ([bodyNameB isEqualToString:kWallName] | [bodyNameB isEqualToString:kEnemyLazerName] | [bodyNameB isEqualToString:kLazerName] | [bodyNameB isEqualToString:nil]) {
            [contact.bodyA.node removeFromParent];
            [contact.bodyB.node removeFromParent];
        }
        
    }
}



@end
