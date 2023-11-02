import 'package:flutter/material.dart';

import 'main.dart';
import 'enum.dart';

class EnableGridMenu extends StatelessWidget {
  // Reference to parent game.
  final DoubleCarsGame game;

  const EnableGridMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 310,
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
                'Enable Grid Setting',
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
                    DoubleCarsGame.enableGrid = EnableGrid.none;
                    game.removeAllGridLine();
                    game.overlays.remove('EnableGridMenu');
                    game.overlays.add('StartMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'None',
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
                    DoubleCarsGame.enableGrid = EnableGrid.yes;
                    game.addGridLine();
                    game.overlays.remove('EnableGridMenu');
                    game.overlays.add('StartMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Yes',
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