import 'dart:io';
import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


JoystickComponent joystick = JoystickComponent();


class Asteroide extends SpriteComponent with HasHitboxes, Collidable, HasGameRef {
  static const speed = 20;
  static const squareSize = 20.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();
  var box;

  bool derecha=true;

  @override

  Future<void>? onLoad() async {
    Random random = Random();

    sprite = await Sprite.load('asteroide.png');
    size = Vector2.all(random.nextInt(70)+30);
    debugMode=false;

    angle = 1 * math.pi*random.nextDouble();
    final shape = HitboxPolygon([
      Vector2(0, 0.7),
      Vector2(0.8, 0),
      Vector2(0, -0.7),
      Vector2(-0.8, 0),
    ]);
    addHitbox(shape);

    box = await Hive.openBox('nave');


    return super.onLoad();
  }


  @override
  void update(double dt) {
    super.update(dt);
    //  angle += speed * dt;
    int puntos = box.get('puntos');

    double velocidad=5+5*(puntos/100);
    x=x-velocidad;

    if (x<50){
      int puntos = box.get('puntos');
      puntos=puntos+1;

      box.put('puntos', puntos);




      removeFromParent();
    }




 }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

    if (other is Disparo)
    {
      int puntos = box.get('puntos');
      puntos=puntos+1;
      box.put('puntos', puntos);


      removeFromParent();
    }


    super.onCollision(intersectionPoints, other);
  }




}


class Disparo extends SpriteComponent with HasHitboxes, Collidable, HasGameRef {
  static const speed = 20;
  static const squareSize = 20.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  bool derecha=true;

  @override

  Future<void>? onLoad() async {
    Random random = Random();

    sprite = await Sprite.load('zap.png');
    size = Vector2.all(30);
    debugMode=false;

    angle = 1 ;
    final shape = HitboxPolygon([
      Vector2(0, 0.7),
      Vector2(0.8, 0),
      Vector2(0, -0.7),
      Vector2(-0.8, 0),
    ]);
    addHitbox(shape);
    return super.onLoad();
  }


  @override
  void update(double dt) {
    super.update(dt);
    //  angle += speed * dt;


    x=x+3;
    if (x>800) removeFromParent();




  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

    if (other is Asteroide)
    {
      print ("disparo acerto");
      removeFromParent();
    }


    super.onCollision(intersectionPoints, other);
  }




}


class Nave extends SpriteComponent with HasHitboxes, Collidable, HasGameRef{
  static const speed = 20;
  static const squareSize = 100.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();
  int imagen=1;
  var box;

  @override

  Future<void>? onLoad() async {
    sprite = await Sprite.load('vehicle-1.png');
    size = Vector2.all(110.0);

    debugMode=false;
    final shape = HitboxPolygon([
      Vector2(0, 0.6),
      Vector2(0.8, 0),
      Vector2(0, -0.6),
      Vector2(-0.8, 0),
    ]);
    addHitbox(shape);


    //llamo a hive
    Directory directory = await getApplicationDocumentsDirectory();
    Hive..init(directory.path);
    box = await Hive.openBox('nave');


    return super.onLoad();
  }

  Future<void> cambiarimagen()
  async {
    switch(imagen)
    {
      case 1: sprite = await Sprite.load('vehicle-1.png'); imagen=2; break;
      case 2: sprite = await Sprite.load('vehicle-2.png'); imagen=3; break;
      case 3: sprite = await Sprite.load('vehicle-3.png'); imagen=4; break;
      case 4: sprite = await Sprite.load('vehicle-2.png'); imagen=1; break;

    }

  }


  @override
  void update(double dt) {
    super.update(dt);
    //  angle += speed * dt;
    angle %= 2 * math.pi;
        if (!joystick.delta.isZero()) {


          Vector2 nuevo = Vector2(x,y);
          nuevo.add(joystick.relativeDelta * 500 * dt);
          if ((nuevo.x>0)&&(nuevo.y>0)&&(nuevo.y<280)&&(nuevo.x<720))
            {
              position.add(joystick.relativeDelta * 500 * dt);
            }


          //    angle = joystick.delta.screenAngle();
        }



  }



@override
void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

  if (other is Asteroide)
  {
    print ("choquee");
    Random random = Random();

    if (random.nextBool())
    y=y+random.nextInt(3);
else
      y=y-random.nextInt(3);
    //    gameRef.camera.shake(intensity: 20);
    int armadura = box.get('armadura');
    armadura=armadura-1;
    box.put('armadura', armadura);

  }


    super.onCollision(intersectionPoints, other);
  }
  @override
  void onCollisionEnd(Collidable other) {

  //  gameRef.camera.shake(intensity: 5);
  //  vidas=vidas-1;





    //  print (vidas.toString()+" vidas");

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





class NaveHorizontal extends FlameGame with  HasDraggables,HasTappables, HasCollidables {
  bool running = true;
  Nave NaveInstancia =  Nave();

  Asteroide Asteroideinstancia =  Asteroide();
  TextComponent TextoEscudo=TextComponent();

  TextComponent TextoPuntacion=TextComponent();

  TextComponent TextGameOver=TextComponent();

  HudButtonComponent shapeButton=HudButtonComponent(
      button: CircleComponent(radius: 35,paint: BasicPalette.blue.paint(),),

      buttonDown: CircleComponent(
        radius: 35,
        paint: BasicPalette.blue.paint(),
      ),
      margin: const EdgeInsets.only(
        right: 85,
        bottom: 60,
      ),

  );

  int jugando=1;

  int movimiento=0;

  SpriteComponent player= SpriteComponent();
  var box;


  void agregarenemigo()
  {

    if (jugando==1)
      {
        Asteroide GoombaInstance =  Asteroide();
        Random random = Random();

        GoombaInstance..y=random.nextDouble() * size.y;
        GoombaInstance..x=850;
        add (GoombaInstance);

      }


  }

  void disparo()
  {
    Disparo disparoinstancia =  Disparo();

    disparoinstancia.x=NaveInstancia.x+90;
    disparoinstancia.y=NaveInstancia.y+30;

    add (disparoinstancia);

  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Directory directory = await getApplicationDocumentsDirectory();
    Hive..init(directory.path);
     box = await Hive.openBox('nave');


    box.put('armadura', 100);
    box.put('puntos', 0);



    int vidas = box.get('armadura');


    add(
        TimerComponent(
          period: 0.7,
          repeat: (jugando==1),
          onTick: () => agregarenemigo(),
        ));

    Flame.device.fullScreen();
    Flame.device.setLandscape();



    ParallaxComponent _stars = await ParallaxComponent.load(
      [
        ParallaxImageData('stars1.png'),
        ParallaxImageData('stars2.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.5, 0),


    );
    add(_stars);

    NaveInstancia..x=size.x/2.5;
    NaveInstancia..y=050;
    add (NaveInstancia);



    add(
        TimerComponent(
          period: 1,
          repeat: true,
          onTick: () => NaveInstancia.cambiarimagen(),
        ));


    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 70, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    add (joystick);

      TextoEscudo = TextComponent();
    TextoEscudo.text="Escudo "+vidas.toString()+ " %";
    TextoEscudo.x=100;
    TextoEscudo.y=15;

    TextoPuntacion = TextComponent();
    TextoPuntacion.text="Puntos: 0";
    TextoPuntacion.x=220;
    TextoPuntacion.y=15;

     TextPaint textPaint = TextPaint(
      style: TextStyle(
        fontSize: 15.0,
          color:Colors.blueGrey,
      ),
    );

     TextoEscudo.textRenderer=textPaint;
    TextoPuntacion.textRenderer=textPaint;

    TextGameOver = TextComponent();
    TextGameOver.x=260;
    TextGameOver.y=155;
    TextPaint textPaint2 = TextPaint(
      style: TextStyle(
        fontSize: 40.0,
        color:Colors.white,
      ),
    );
    TextGameOver.textRenderer=textPaint2;



    add(TextoEscudo);
    add(TextoPuntacion);



     shapeButton = HudButtonComponent(
      button: CircleComponent(radius: 35,paint: BasicPalette.blue.paint(),),

        buttonDown: CircleComponent(
          radius: 35,
        paint: BasicPalette.blue.paint(),
      ),
      margin: const EdgeInsets.only(
        right: 85,
        bottom: 60,
      ),
      onPressed: () => disparo()
        );
    add (shapeButton);

  }

  @override
  void update(double dt) {
    // TODO: implement update
    int vidas = box.get('armadura');
    TextoEscudo.text="Escudo "+vidas.toString()+ " %";

    int puntos = box.get('puntos');
    TextoPuntacion.text="Puntos: "+puntos.toString();


    if (vidas<=0)
    {
      Perdio();
    }

    super.update(dt);
  }

  void Perdio()
  {
    TextGameOver.text="Juego Terminado\n Puntos: "+ box.get('puntos').toString();

    add(TextGameOver);

    remove(NaveInstancia);


    jugando=0;
remove(joystick);
remove (shapeButton);


  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    // TODO: implement onTapUp

if (jugando==0)
  {
    add(joystick);
    add (shapeButton);
    add (NaveInstancia);
    remove (TextGameOver);
    box.put('puntos', 0);
    box.put('armadura', 100);
    jugando=1;

  }


    super.onTapUp(pointerId, info);
  }




}