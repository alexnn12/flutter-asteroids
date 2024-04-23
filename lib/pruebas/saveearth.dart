import 'dart:math' as math;
import 'dart:math';
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
    sprite = await Sprite.load('asteroide.png');
    size = Vector2.all(60.0);
    debugMode=false;
    Random random = Random();

    angle = 1 * math.pi*random.nextDouble();

    addHitbox(HitboxRectangle());
    return super.onLoad();
  }


  @override
  void update(double dt) {
    super.update(dt);
    //  angle += speed * dt;


    y=y-3;
    if (y<50) removeFromParent();




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
    sprite = await Sprite.load('tierra.png');
    size = Vector2.all(80.0);

    debugMode=false;
    addHitbox(HitboxRectangle());


    return super.onLoad();
  }


  @override
  void update(double dt) {
    super.update(dt);
    //  angle += speed * dt;
    angle %= 2 * math.pi;
    if (y<320) y=y+1;

  }



@override
void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

  if (other is Goomba)
  {
  //  print ("goomba");
    //    gameRef.camera.shake(intensity: 20);


  }


    super.onCollision(intersectionPoints, other);
  }
  @override
  void onCollisionEnd(Collidable other) {

    gameRef.camera.shake(intensity: 5);
    print (" termino el hit");

  }


  Future<void> saltarizquierda() async {

    y=y-50;
    if ((x-30)>30) x=x-30;
    print (" salto izqueirda");

  }

  Future<void> saltarderecha() async {

    y=y-50;
    if ((x+30)<350) x=x+30;


  }




}

class FreeFall extends FlameGame with  TapDetector, HasCollidables,LongPressDetector {
  bool running = true;
  Mario MarioInstance =  Mario();

  Goomba GoombaInstance2 =  Goomba();

  int movimiento=0;

  SpriteComponent player= SpriteComponent();



  void agregarenemigo()
  {
    Goomba GoombaInstance =  Goomba();
    Random random = Random();

    GoombaInstance..x=random.nextDouble() * size.x;
    GoombaInstance..y=750;
    add (GoombaInstance);

  }

  @override
  Future<void> onLoad() async {
    print (" arrancp");
    await super.onLoad();



    add(
        TimerComponent(
          period: 2,
          repeat: true,
          onTick: () => agregarenemigo(),
        ));





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

    MarioInstance..x=200;
    MarioInstance..y=050;
    add (MarioInstance);




  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

@override
  void onLongPressStart(LongPressStartInfo info) {
  print (" empezar");

  super.onLongPressStart(info);

  }
@override
  void onLongPressEnd(LongPressEndInfo info) {
    print (" ff");
    super.onLongPressEnd(info);
  }

  @override
  void onTapUp(TapUpInfo info) {
    final touchPoint = info.eventPosition.game;


    player.position.y=player.position.y-5;

  //  print (" aprete");



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