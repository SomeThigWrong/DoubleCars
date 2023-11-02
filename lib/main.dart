import 'dart:math' as math;
import 'dart:math';

import 'package:double_cars/enum.dart';
import 'package:double_cars/gameover_menu.dart';
import 'package:double_cars/obtacle.dart';
import 'package:double_cars/constant.dart' as constant;
import 'package:double_cars/startmenu.dart';
import 'package:double_cars/difficulty_menu.dart';
import 'package:double_cars/enablegrid_menu.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'car.dart';
import 'grid.dart';


void main() {
  // runApp(
  //   GameWidget(
  //     game: DoubleCarsGame(),
  //     overlayBuilderMap: {
  //       'StartMenu': (_, game) => StartMenu(game:  DoubleCarsGame()),
  //     },
  //     initialActiveOverlays: const ['StartMenu'],
  //   ),
  // );

  runApp(
    GameWidget<DoubleCarsGame>.controlled(
      gameFactory: DoubleCarsGame.new,
      overlayBuilderMap: {
        'StartMenu': (_, game) => StartMenu(game: game),
        'DifficultyMenu': (_, game) => DifficultyMenu(game: game),
        'EnableGridMenu': (_, game) => EnableGridMenu(game: game),
      },
      initialActiveOverlays: const ['StartMenu'],

    ),
  );

}



/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
class DoubleCarsGame extends FlameGame  with TapCallbacks{

   static late Vector2 screenSize ;
   static late Car redCar;
   static late Car tealCar;
   late TextComponent _scoreTextComponent;
   static GameDifficulty difficulty = GameDifficulty.medium;
   static EnableGrid enableGrid = EnableGrid.yes;
  @override
  Future<void> onLoad() async {
    screenSize = size;
    final spriteTealCar = await Sprite.load('teal-car.png');

    final initXPosTealCar = (Rack.third.index+1) * (size.x/4) - constant.CarSize/2;
    final initPosTealCar = Vector2(initXPosTealCar, size.y - constant.CarSize/2);

    final carSize = Vector2.all(constant.CarSize);
    tealCar = Car(size, CarColor.teal,Rack.third,carSize,spriteTealCar,initPosTealCar);
    add(tealCar);

    final spriteRedCar = await Sprite.load('red-car.png');

    final initXPosRedCar = (Rack.first.index+1) * (size.x/4) - constant.CarSize/2;
    final initPositionRedCar = Vector2(initXPosRedCar, size.y - constant.CarSize/2);

    final redSize = Vector2.all(constant.CarSize);
    redCar =  Car(size, CarColor.red,Rack.first,carSize,spriteRedCar,initPositionRedCar);
    add(redCar);

    final greenCircle = await images.load('green-circle.png');
    final redSquare = await images.load('red-square.png');

    Sprite greenCircleSp = Sprite(greenCircle);
    Sprite redSquareSp = Sprite(redSquare);

    Random random =  Random();
    add(
        TimerComponent(
          period:  0.2,
          repeat: true,
          onTick:  (){
            if(Obstacle.blockMove == true){
              final smallestDistant = getSmallestBlockDistant();
              if(smallestDistant == 0  || smallestDistant > (1.75) * constant.CarSize){
                int randomRack= random.nextInt(Rack.values.length);
                int randomBlock= random.nextInt(ObstacleType.values.length);
                Sprite givenSprite = ObstacleType.values[randomBlock] == ObstacleType.circle ? greenCircleSp : redSquareSp;
                add(Obstacle(this,ObstacleType.values[randomBlock],Rack.values[randomRack],getInitBlockPos(Rack.values[randomRack]),givenSprite,Vector2.all(constant.BlockSize)));
                if(difficulty == GameDifficulty.nightmare){
                  int anotherBlock= random.nextInt(ObstacleType.values.length);
                  int anotherRack= random.nextInt(ObstacleType.values.length);
                  if(randomRack < Obstacle.boundaryCarRack){
                     anotherRack= random.nextInt(Obstacle.boundaryCarRack) + Obstacle.boundaryCarRack;
                  }else{
                    anotherRack= random.nextInt(Obstacle.boundaryCarRack);
                  }
                  Sprite anotherGivenSprite = ObstacleType.values[anotherBlock] == ObstacleType.circle ? greenCircleSp : redSquareSp;
                  add(Obstacle(this,ObstacleType.values[anotherBlock],Rack.values[anotherRack],getInitBlockPos(Rack.values[anotherRack]),anotherGivenSprite,Vector2.all(constant.BlockSize)));
                }
              }
            }
          }
        )
    );

    _scoreTextComponent = TextComponent(
      text: 'Score: ${Obstacle.gameScore}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x - 100, 60),
    );

    add(_scoreTextComponent);
  }

  void addGridLine(){
    if(enableGrid == EnableGrid.yes){
      const double lineWidth = 5;
      final  double lineHeight = size.y;
      for(int index = 1; index < Rack.values.length; ++index){
        double initPosX = (size.x/4) * index;
        print('addedVerticalLine ${size.y}');
        add(VerticalLine(Vector2(initPosX,0),Vector2(lineWidth,lineHeight)));
      }
    }
  }

   void removeAllGridLine(){
     if(enableGrid == EnableGrid.none){
       final allVerticalLines = children.query<VerticalLine>();
       removeAll(allVerticalLines);
     }
   }

   void removeAllObstacle(){
     final allObstacleComponents = children.query<Obstacle>();
     removeAll(allObstacleComponents);
     Obstacle.numberObstacle = 0;
     Obstacle.gameScore = 0;
   }
   double getSmallestBlockDistant(){
    if(Obstacle.numberObstacle > 0){
      List<Obstacle>? allObstacleComponents = children.query<Obstacle>();
      return allObstacleComponents.last.y;
    }else{
      return 0;
    }
   }
   @override
   void update(double dt) {
     _scoreTextComponent.text = 'Score : ${Obstacle.gameScore}';
     super.update(dt);
   }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      final redCarBoundary = size/2;
      if(touchPoint.x < redCarBoundary.x){
        redCar.updatePosition(CarColor.red);
      }else{
        tealCar.updatePosition(CarColor.teal);
      }
    }
  }
  Vector2 getInitBlockPos(Rack rack){
    final result = Vector2((rack.index+1) * (size.x/4)  - (size.x/8),constant.BlockSize/2) ;
    return result;
  }

}


class Square extends RectangleComponent with TapCallbacks {
  static const speed = 1;
  static const squareSize = 128.0;
  static const indicatorSize = 6.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();

  Square(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(squareSize),
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    print('tab');
    event.handled = true;
  }
}