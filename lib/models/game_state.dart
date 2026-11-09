import 'package:tictactoe_flutter/models/player_enum.dart';
import 'package:tictactoe_flutter/models/game_result_enum.dart';
import 'package:tictactoe_flutter/models/move_result.dart';
import 'package:tictactoe_flutter/models/game_error_enum.dart';

class GameState {
  List<List<Player>> _board;
  Player _currentPlayer;
  GameResult _result;
  (Player, List<int>) _winner;

  static const List<List<(int, int)>> _winningPositionsMatrix = [
    [(0, 0), (0, 1), (0, 2)],
    [(1, 0), (1, 1), (1, 2)],
    [(2, 0), (2, 1), (2, 2)],
    [(0, 0), (1, 0), (2, 0)],
    [(0, 1), (1, 1), (2, 1)],
    [(0, 2), (1, 2), (2, 2)],
    [(0, 0), (1, 1), (2, 2)],
    [(0, 2), (1, 1), (2, 0)],
  ];

  GameState()
    : _board = List.generate(3, (_) => List.generate(3, (_) => Player.none)),
      _currentPlayer = Player.x,
      _result = GameResult.ongoing,
      _winner = (Player.none, []);

  List<List<Player>> get board => List<List<Player>>.unmodifiable(
    _board.map((row) => List<Player>.unmodifiable(row)),
  );
  Player get currentPlayer => _currentPlayer;
  GameResult get result => _result;
  Player get winner => _winner.$1;
  List<(int, int)> get winningPositions =>
      _winner.$2.expand((index) => _winningPositionsMatrix[index]).toList();

  MoveResult isValidMove(int x, int y) {
    if (_result != GameResult.ongoing) {
      return InvalidMove(GameError.gameNotOngoing);
    }

    if (_currentPlayer == Player.none) {
      return InvalidMove(GameError.noCurrentPlayer);
    }

    if (x < 0 || x > 2 || y < 0 || y > 2) {
      return InvalidMove(GameError.invalidCoordinates);
    }

    if (_board[x][y] != Player.none) return InvalidMove(GameError.cellOccupied);

    return ValidMove();
  }

  MoveResult playAt(int index) {
    int gridStateLength = _board.length;
    int x = (index / gridStateLength).floor();
    int y = (index % gridStateLength);
    var moveResult = isValidMove(x, y);
    if (moveResult is InvalidMove) return moveResult;

    _board[x][y] = _currentPlayer;
    _checkWinner();

    if (_result == GameResult.ongoing) _changePlayer();
    return ValidMove();
  }

  void _changePlayer() {
    _currentPlayer = _currentPlayer == Player.x ? Player.o : Player.x;
  }

  void _checkWinner() {
    var winners = _winningPositionsMatrix
        .map((line) => line.map((pos) => _board[pos.$1][pos.$2]).toList())
        .toList();

    List<int> winningLines = [];

    for (var entry in winners.asMap().entries) {
      var line = entry.value;
      var index = entry.key;
      if (line.every((element) => element == _currentPlayer)) {
        _result = GameResult.win;
        winningLines.add(index);
      }
    }

    if (winningLines.isNotEmpty) {
      _winner = (_currentPlayer, winningLines.toSet().toList());
    }

    if (_board.expand((e) => e).every((element) => element != Player.none) &&
        _result == GameResult.ongoing &&
        _winner.$2.isEmpty) {
      _result = GameResult.draw;
      _winner = (Player.none, []);
      return;
    }

    return;
  }

  void reset() {
    _currentPlayer = Player.x;
    _board = List.generate(3, (_) => List.generate(3, (_) => Player.none));
    _result = GameResult.ongoing;
    _winner = (Player.none, []);
  }
}
