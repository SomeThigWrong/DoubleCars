import 'package:double_cars/obtacle.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'enum.dart';

class DifficultyMenu extends StatelessWidget {
  // Reference to parent game.
  final DoubleCarsGame game;

  const DifficultyMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 330,
          width: 410,
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Difficulty Setting',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    DoubleCarsGame.difficulty = GameDifficulty.easy;
                    Obstacle.step =  5.0 * (DoubleCarsGame.difficulty.index + 1);
                    game.overlays.remove('DifficultyMenu');
                    game.overlays.add('StartMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Easy',
                    style: TextStyle(
                      fontSize: 24,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    DoubleCarsGame.difficulty = GameDifficulty.medium;
                    Obstacle.step =  5.0 * (DoubleCarsGame.difficulty.index + 1);
                    game.overlays.remove('DifficultyMenu');
                    game.overlays.add('StartMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Medium',
                    style: TextStyle(
                      fontSize: 24,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    DoubleCarsGame.difficulty = GameDifficulty.hard;
                    Obstacle.step =  5.0 * (DoubleCarsGame.difficulty.index + 1);
                    game.overlays.remove('DifficultyMenu');
                    game.overlays.add('StartMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Hard',
                    style: TextStyle(
                      fontSize: 24,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    DoubleCarsGame.difficulty = GameDifficulty.nightmare;
                    Obstacle.step =  5.0 * (GameDifficulty.hard.index + 1);
                    game.overlays.remove('DifficultyMenu');
                    game.overlays.add('StartMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'NightMare',
                    style: TextStyle(
                      fontSize: 24,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}