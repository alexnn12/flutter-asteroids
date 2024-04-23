import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';


class JoystickExample extends FlameGame with HasDraggables {
  static const String description = '''
    In this example we showcase how to use the joystick by creating simple
    `CircleComponent`s that serve as the joystick's knob and background.
    Steer the player by using the joystick.
  ''';

  late final JoystickPlayer player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 70, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    player = JoystickPlayer(joystick);

    add(player);
    add(joystick);
  }
}

class JoystickPlayer extends SpriteComponent with HasGameRef {
  /// Pixels/s
  double maxSpeed = 100.0;

  final JoystickComponent joystick;

  JoystickPlayer(this.joystick)
      : super(
    size: Vector2.all(100.0),
  ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 2;
    size = Vector2.all(50.0);

  }

  @override
  void update(double dt) {
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
  }
}
