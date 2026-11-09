import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter/models/game_entities.dart';
import 'package:tictactoe_flutter/providers/game.dart';

class GameStatus extends StatefulWidget {
  const GameStatus({super.key});

  @override
  State<GameStatus> createState() => _GameStatusState();
}

class _GameStatusState extends State<GameStatus> {
  late GameViewModel _game;

  @override
  void initState() {
    super.initState();
    _game = context.read<GameViewModel>();
    _game.addListener(showErrorMessage);
  }

  void showErrorMessage() {
    final lastMoveResult = _game.lastMoveResult;

    // Avalia se há um aviso para exibir
    if (lastMoveResult != null && lastMoveResult is InvalidMove && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(gameErrorToString(lastMoveResult.error)),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _game.removeListener(showErrorMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameViewModel>();
    final GameResult result = game.result;
    final Player currentPlayer = game.currentPlayer;
    final Player winner = game.winner;

    if (result == GameResult.ongoing && currentPlayer != Player.none) {
      return Text(
        'Vez do (${currentPlayer.name}) jogar',
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    if (result == GameResult.ongoing && currentPlayer == Player.none) {
      return const Text(
        'Aguardando jogador...',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    if (result != GameResult.ongoing) {
      return Text(
        winner == Player.none
            ? 'Empate!'
            : 'O player ${winner.name.toUpperCase()} venceu!',
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
