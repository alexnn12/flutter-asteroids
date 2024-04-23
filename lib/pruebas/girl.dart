import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';

// https://github.com/codetricity/flutter_flame_tutorial/tree/4_sprite_animation/lib




class Player extends SpriteAnimationComponent
    with HasGameRef {


  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(image: await Images().load('girl_spritesheet.png'), srcSize: Vector2(152.0, 142.0));
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.03);

    position = gameRef.size / 2;
    width = 80;
    height = 120;
    size=     Vector2(152 * 1.4, 142 * 1.4);

    anchor = Anchor.center;

  }


}



class GirlGame extends FlameGame with DoubleTapDetector {
  SpriteComponent girl = SpriteComponent();

  Player chicaconclase = Player();


  bool running = true;
  String direction = 'down';
  SpriteAnimationComponent girlAnimation = SpriteAnimationComponent();
  double speed = 0.6;

  @override
  Future<void> onLoad() async {
    print('loading assets');
    ParallaxComponent _stars = await ParallaxComponent.load(
      [
        ParallaxImageData('stars1.png'),
        ParallaxImageData('stars2.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(10, 20),
      velocityMultiplierDelta: Vector2(0, 1.5),



    );
    add(_stars);

    var spriteSheet = await images.load('girl_spritesheet.png');
    final spriteSize = Vector2(152 * 1.4, 142 * 1.4);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 9, stepTime: 0.03, textureSize: Vector2(152.0, 142.0));
    girlAnimation =
    SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
      ..x = 50
      ..y = 30
      ..size = spriteSize;
 //   add(girlAnimation);

    add (chicaconclase);

    final Random rnd = Random();

    /*
    add(
        ParticleComponent(
          TranslatedParticle(
            lifespan: 12,
            offset:Vector2.random() ,
            child:  MovingParticle(
              to: randomCellVector2(),
              child: CircleParticle(
                radius: 225 + rnd.nextDouble() * 25,
                paint: Paint()..color = Colors.red,
              ),
            ),
          ),
        )
    );

     */

  }

  Vector2 randomCellVector2() {
    return (Vector2.random() - Vector2.random())..multiply(Vector2.random());
  }

  @override
  update(double dt) {
    super.update(dt);

    switch (direction) {
      case 'down':
        girlAnimation.y += speed;
        break;
      case 'up':
        girlAnimation.y -= speed;
        break;
    }

    if (girlAnimation.y > 500) {
      direction = 'up';
    }
    if (girlAnimation.y < 10) {
      direction = 'down';
    }
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    running = !running;



  }
}