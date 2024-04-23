import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';




class Alberto extends SpriteAnimationComponent with HasGameRef {


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



class Corredor extends FlameGame with DoubleTapDetector {

  Alberto albertoInstancia = Alberto();


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



    add (albertoInstancia);

    final Random rnd = Random();



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