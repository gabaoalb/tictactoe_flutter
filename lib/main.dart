import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter/providers/game.dart';
import 'package:tictactoe_flutter/providers/theme.dart';

import 'dart:io';

import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_flutter/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final window = WindowManager.instance.getCurrent()!;
      window.setSize(const Size(400, 600).toNative(), false);
      window.center();
      window.isAlwaysOnTop = false;
      window.isVisibleInTaskbar = true;
      window.backgroundColor = Colors.transparent.toNative();
      window.hasShadow = false;
      window.setFrameless(true);
      window.show();
      window.focus();
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => Game()),
      ],
      child: const App(),
    ),
  );
}
