import 'package:tictactoe_flutter/models/game_error_enum.dart';

sealed class MoveResult {}

class ValidMove extends MoveResult {}

class InvalidMove extends MoveResult {
  final GameError error;
  InvalidMove(this.error);
}
