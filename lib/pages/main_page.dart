import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter/providers/game.dart';
import 'package:tictactoe_flutter/widgets/desktop_window_controls.dart';
import 'package:tictactoe_flutter/widgets/game_board.dart';
import 'package:tictactoe_flutter/widgets/theme_picker.dart';

class MainPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
      child: Scaffold(
        backgroundColor: kIsWeb || Platform.isAndroid || Platform.isIOS
            ? primaryColor
            : Colors.transparent,
        body: kIsWeb
            ? const GameBoard()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: primaryColor,
                  border: Border.all(color: Colors.transparent),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    if (!kIsWeb &&
                        (Platform.isWindows ||
                            Platform.isMacOS ||
                            Platform.isLinux))
                      DesktopWindowControls(),
                    const GameBoard(),
                  ],
                ),
              ),
        floatingActionButton: ThemePicker(),
      ),
    );
  }
}
