import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/models/game_entities.dart';

class GameCell extends StatelessWidget {
  final Player cellPlayer;
  final void Function() onTap;
  final bool isWinningCell;

  const GameCell({
    super.key,
    required this.cellPlayer,
    required this.onTap,
    required this.isWinningCell,
  });

  @override
  Widget build(BuildContext context) {
    String playerSymbol = switch (cellPlayer) {
      Player.x => cellPlayer.name.toUpperCase(),
      Player.o => cellPlayer.name.toUpperCase(),
      Player.none => '',
    };

    Color color = switch (cellPlayer) {
      Player.x => Colors.blue,
      Player.o => Colors.red,
      Player.none => Colors.white,
    };

    return GestureDetector(
      onTap: onTap,
      child: GridTile(
        child: Card(
          color: color,
          shape: isWinningCell
              ? RoundedRectangleBorder(
                  side: BorderSide(color: Colors.greenAccent, width: 4),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Center(
            child: Text(
              playerSymbol,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
