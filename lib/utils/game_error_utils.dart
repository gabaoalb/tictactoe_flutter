import 'package:tictactoe_flutter/models/game_error_enum.dart';

String gameErrorToString(GameError error) {
  switch (error) {
    case GameError.gameNotOngoing:
      return 'O jogo não está em andamento';
    case GameError.noCurrentPlayer:
      return 'Não há jogador atual';
    case GameError.invalidCoordinates:
      return 'Coordenadas inválidas';
    case GameError.cellOccupied:
      return 'A célula já está ocupada';
  }
}
