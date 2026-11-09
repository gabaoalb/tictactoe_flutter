import 'package:flutter/foundation.dart';
import 'package:tictactoe_flutter/models/game_result_enum.dart';
import 'package:tictactoe_flutter/models/game_state.dart';
import 'package:tictactoe_flutter/models/move_result.dart';
import 'package:tictactoe_flutter/models/player_enum.dart';

class GameViewModel with ChangeNotifier {
  final GameState _state = GameState();
  MoveResult? _lastMoveResult;

  List<List<Player>> get board => _state.board;
  GameResult get result => _state.result;
  Player get currentPlayer => _state.currentPlayer;
  Player get winner => _state.winner;
  List<(int, int)> get winningPositions => _state.winningPositions;

  MoveResult? get lastMoveResult => _lastMoveResult;

  void playAt(int index) {
    var moveResult = _state.playAt(index);
    _lastMoveResult = moveResult;
    notifyListeners();
  }

  void resetGame() {
    _state.reset();
    _lastMoveResult = null;
    notifyListeners();
  }
}
