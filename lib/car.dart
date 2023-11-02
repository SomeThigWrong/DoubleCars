import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/animation.dart';
import 'dart:math' as math;
import 'enum.dart';
import 'main.dart';
import 'constant.dart' as constant;

class Car extends SpriteComponent{
  Rack rack ;
  Vector2 screenSize;
  CarColor color;

  Car(this.screenSize, this.color,this.rack,Vector2 size, Sprite sprite,Vector2 position) : super(anchor: Anchor.center, size: size, sprite: sprite, position: position);
  @override
  Future<void> onLoad() async{
    super.onLoad();
    angle = math.pi/2;
    add(MoveToEffect(
        Vector2(position.x, screenSize.y - constant.CarSize/2),
        EffectController(duration: 0.1)
    ));

  }

  updatePosition(CarColor color){
    double newXPosition = 0;
    int turnDirection = rack.index % 2 == 0 ? 1 : -1;
    if(color == CarColor.teal){
      rack = rack == Rack.third ? Rack.fourth : Rack.third;
      newXPosition = (rack.index+1) * (screenSize.x/4) - constant.CarSize/2;
    }else{
      rack = rack == Rack.first ? Rack.second : Rack.first;
      newXPosition = (rack.index+1) * (screenSize.x/4) - constant.CarSize/2;
    }
    //position =   Vector2(newXPosition, screenSize.y - constant.CarSize/2);

    add(
        SequenceEffect([
          RotateEffect.by(
            turnDirection * math.pi/8,
            EffectController(duration: 0.1),
          ),
          MoveToEffect(
              Vector2(newXPosition, screenSize.y - constant.CarSize/2),
              EffectController(duration: 0.05)
          ),
          RotateEffect.by(
            turnDirection * -math.pi/8,
            EffectController(duration: 0.05),
          ),
        ])
    );
  }
}