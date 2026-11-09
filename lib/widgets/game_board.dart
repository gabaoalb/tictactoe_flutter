import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/models/game_result_enum.dart';
import 'package:tictactoe_flutter/models/player_enum.dart';

import 'game_status.dart';
import 'game_cell.dart';

import 'dart:math';

import 'package:provider/provider.dart';
import 'package:tictactoe_flutter/providers/game.dart';

class GameBoard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameViewModel>();
    final List<List<Player>> board = game.board;
    final GameResult result = game.result;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const GameStatus(),
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.height * 0.6,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: pow(board.length, 2) as int,
              itemBuilder: (context, index) {
                int x = (index / 3).floor();
                int y = index % 3;

                return GameCell(
                  cellPlayer: board[x][y],
                  onTap: () => game.playAt(index),
                  isWinningCell: game.winningPositions.contains((x, y)),
                );
              },
            ),
          ),
          if (result != GameResult.ongoing)
            IconButton(
              onPressed: () => context.read<GameViewModel>().resetGame(),
              icon: const Icon(Icons.replay),
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
