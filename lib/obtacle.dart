import 'package:flame/components.dart';

import 'enum.dart';
import 'main.dart';
import 'constant.dart' as constant;

class Obstacle extends SpriteComponent{
  ObstacleType obstacleType;
  static double step = 5.0 ;
  static bool blockMove = false;
  static const boundaryCarRack = 2;
  static int numberObstacle = 0;
  static int gameScore = 0;
  Rack rack;
  static double collisionHeight = DoubleCarsGame.screenSize.y - constant.CarSize - step;
  static double circleMissHeight = DoubleCarsGame.screenSize.y - constant.CarSize/4;
  final DoubleCarsGame game;
  Obstacle(this.game,this.obstacleType,this.rack, Vector2 position,Sprite sprite,Vector2 size) : super(position: position,anchor: Anchor.center,sprite: sprite,size: size){
    numberObstacle +=1;
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(blockMove == true){
      position += Vector2(0,  step);
    }

    if(position.y > collisionHeight){

      if(rack.index < boundaryCarRack){
        if(obstacleType == ObstacleType.square && rack == DoubleCarsGame.redCar.rack){
          gameStop();
        }else if(obstacleType == ObstacleType.circle && rack != DoubleCarsGame.redCar.rack){
          if(position.y > circleMissHeight){
            gameStop();
          }
        } else{
          obstacleDisappear();
        }
      }else{
        if(obstacleType == ObstacleType.square && rack == DoubleCarsGame.tealCar.rack){
          gameStop();
        }else if(obstacleType == ObstacleType.circle && rack != DoubleCarsGame.tealCar.rack){
          if(position.y > circleMissHeight){
            gameStop();
          }
        } else{
          obstacleDisappear();
        }
      }
    }
  }

  void obstacleDisappear(){
    if(obstacleType == ObstacleType.square){
      if(position.y > DoubleCarsGame.screenSize.y){

        removeFromParent();
        gameScore += 1;
      }
    }else{
      removeFromParent();
      gameScore += 1;
    }
  }

  void missCircleObstacle(){

  }

  void gameStop(){
    blockMove = false;
    game.overlays.add('StartMenu');
  }
}