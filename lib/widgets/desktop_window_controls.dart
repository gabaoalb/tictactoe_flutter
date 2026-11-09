import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DesktopWindowControls extends StatelessWidget {
  DesktopWindowControls({super.key});

  final window = WindowManager.instance.getCurrent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => window?.minimize(),
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.white38),
            ),
            child: const Icon(Icons.minimize, color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              if (window == null) return;
              if (window?.isMaximized ?? false) {
                window?.unmaximize();
              } else {
                window?.maximize();
              }
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.white38),
            ),
            child: const Icon(Icons.maximize, color: Colors.white),
          ),
          TextButton(
            onPressed: () => window?.close(),
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.white38),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}
