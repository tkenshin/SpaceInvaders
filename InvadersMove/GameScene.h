//
//  GameScene.h
//  InvadersMove
//

//  Copyright (c) 2015年 zInox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

//オブジェクト名
#define	kPlayerName @"Player" // プレイヤー
#define kLazerName @"Lazer" // レーザー
#define kEnemyName @"Enemy" // 敵
#define kUfoName @"Ufo"
#define kEnemyLazerName @"EnemyLazer" // 敵レーザー
#define kBackGroundName @"BackGround" //背景
#define kScoreName @"Score" // スコア
#define kPlayerLivesName @"PlayerLives" // プレイヤー残機
#define kWallName @"wall" // 壁

//カテゴリビットマスク
static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t lazerCategory = 0x1 << 1;
static const uint32_t enemyCategory = 0x1 << 2;
static const uint32_t ufoCategory = 0x1 << 3;
static const uint32_t enemyLazerCategory = 0x1 << 4;
static const uint32_t wallCategory = 0x1 << 5;

static const CGFloat playerSpeed = 1.0f;

@interface GameScene : SKScene<SKPhysicsContactDelegate>
@property(assign, nonatomic) int score;
@property(assign, nonatomic) int lives;

@end
