import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';



class Square1 extends PositionComponent {
  static const speed = 20;
  static const squareSize = 80.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  @override
  void render(Canvas c) {
  //  c.drawRect(size.toRect(), red);

    Rect circulo = size.toRect();



    //c.drawCircle(size.toOffset(), 20, white);
    c.drawOval(size.toRect(), blue);
    c.drawOval(circulo, white);
    //c.drawRect(const Rect.fromLTWH(0, 0, 0, 5), red);
 //   c.drawRect(Rect.fromLTWH(width / 2, height / 2, 10, 10), blue);
  }

  @override
  void update(double dt) {
    super.update(dt);
  //  angle += speed * dt;
    angle %= 2 * math.pi;
    if (y<720) y=y+3;

  }


  void saltarizquierda(){

    y=y-50;
    if ((x-30)>30) x=x-30;
    print (" salto izqueirda");

  }

  void saltarderecha(){

    y=y-50;
    if ((x+30)<350) x=x+30;


  }



  @override
  Future<void> onLoad() async {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
  }
}

class MyGame extends FlameGame with  TapDetector {
  bool running = true;
  Square1 circulo =  Square1();

    SpriteComponent player= SpriteComponent();


  @override
  Future<void> onLoad() async {
    print (" arrancp");
    await super.onLoad();

    circulo..x=200;
    circulo..y=650;
    add (circulo);

    final sprite = await Sprite.load('mario.png');
    final size = Vector2.all(100.0);
     player = SpriteComponent(size: size, sprite: sprite);

    // screen coordinates
    player.position.x=133;
    player.position.y=321;// Vector2(0.0, 0.0) by default, can also be set in the constructor
     // 0 by default, can also be set in the constructor

    add(player);




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


    if (circulo.y>0)
      {
        if (touchPoint.x<160)
          circulo.saltarizquierda();
        else
          circulo.saltarderecha();



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