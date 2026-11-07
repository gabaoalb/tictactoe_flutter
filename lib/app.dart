import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter/pages/main_page.dart';
import 'package:tictactoe_flutter/providers/theme.dart';

class App extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: themeProvider.selectedPrimaryColor),
      home: const MainPage(),
    );
  }
}
