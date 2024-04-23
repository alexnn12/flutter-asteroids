import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class Goomba extends SpriteComponent with HasHitboxes, Collidable, HasGameRef {
  static const speed = 20;
  static const squareSize = 20.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  bool derecha=true;

  @override

  Future<void>? onLoad() async {
    sprite = await Sprite.load('goomba.png');
    size = Vector2.all(60.0);
    debugMode=true;
    addHitbox(HitboxRectangle());
    return super.onLoad();
  }


  @override
  void update(double dt) {
    super.update(dt);
    //  angle += speed * dt;
    angle %= 2 * math.pi;

    if (derecha)
      {
        if (x<300) x=x+1;
        else
          derecha=false;
      }else
        {
          if (x>0) x=x-1;
          else
            derecha=true;

        }




 }




}


class Mario extends SpriteComponent with HasHitboxes, Collidable, HasGameRef{
  static const speed = 20;
  static const squareSize = 80.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  @override

  Future<void>? onLoad() async {
    sprite = await Sprite.load('mario.png');
    size = Vector2.all(60.0);

    debugMode=true;
    addHitbox(HitboxRectangle());


    return super.onLoad();
  }


  @override
  void update(double dt) {
    super.update(dt);
    //  angle += speed * dt;
    angle %= 2 * math.pi;
    if (y<720) y=y+1;

  }


  @override
  void onCollisionEnd(Collidable other) {

    print (" hit");
    x=200;
    y=550;


  }


  Future<void> saltarizquierda() async {
    sprite = await Sprite.load('mario.png');

    y=y-50;
    if ((x-30)>30) x=x-30;
    print (" salto izqueirda");

  }

  Future<void> saltarderecha() async {
    sprite = await Sprite.load('mario2.png');

    y=y-50;
    if ((x+30)<350) x=x+30;


  }




}

class Bola2 extends FlameGame with  TapDetector, HasCollidables {
  bool running = true;
  Mario MarioInstance =  Mario();

  Goomba GoombaInstance =  Goomba();
  Goomba GoombaInstance2 =  Goomba();



  SpriteComponent player= SpriteComponent();


  @override
  Future<void> onLoad() async {
    print (" arrancp");
    await super.onLoad();

    MarioInstance..x=200;
    MarioInstance..y=550;
    add (MarioInstance);

    GoombaInstance..x=100;
    GoombaInstance..y=250;
    add (GoombaInstance);

    GoombaInstance2..x=300;
    GoombaInstance2..y=350;
    GoombaInstance2..derecha=false;
    add (GoombaInstance2);

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




  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  void onTapUp(TapUpInfo info) {
    final touchPoint = info.eventPosition.game;


    player.position.y=player.position.y-5;



    print (player.position.x.toString());


    if (MarioInstance.y>0)
    {
      if (touchPoint.x<160)
        MarioInstance.saltarizquierda();
      else
        MarioInstance.saltarderecha();



    }

  }

  @override
  void onDoubleTap( ) {


    if (running) {
      //  pauseEngine();
    } else {
      //   resumeEngine();
    }

    running = !running;
  }
}