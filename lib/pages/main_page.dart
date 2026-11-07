import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tictactoe_flutter/builders/build_main_content.dart';
import 'package:tictactoe_flutter/builders/build_color_dialog.dart';

class MainPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: kIsWeb || Platform.isAndroid || Platform.isIOS
          ? primaryColor
          : Colors.transparent,
      body: kIsWeb
          ? buildMainContent(context)
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                WindowManager.instance.getCurrent()?.minimize(),
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all(
                                Colors.white38,
                              ),
                            ),
                            child: const Icon(
                              Icons.minimize,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              final window = WindowManager.instance
                                  .getCurrent();
                              if (window == null) return;
                              if (window.isMaximized) {
                                window.unmaximize();
                              } else {
                                window.maximize();
                              }
                            },
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all(
                                Colors.white38,
                              ),
                            ),
                            child: const Icon(
                              Icons.maximize,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                WindowManager.instance.getCurrent()?.close(),
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all(
                                Colors.white38,
                              ),
                              shape:
                                  WidgetStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(18),
                                      ),
                                    ),
                                  ),
                            ),
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  buildMainContent(context),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => buildColorDialog(context),
        backgroundColor: Colors.white,
        child: Icon(Icons.settings, color: primaryColor),
      ),
    );
  }
}
