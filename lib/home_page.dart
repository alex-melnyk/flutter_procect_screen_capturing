import 'package:flutter/material.dart';
import 'package:prevent_screen_capture/platform_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screenCaptureProtected = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prevent Screen Capture"),
      ),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: screenCaptureProtected,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  value ? Icons.lock : Icons.lock_open,
                  size: 50,
                  color: value ? Colors.red : null,
                ),
                Text(
                  'Screen capture protection is ${value ? 'ON' : 'OFF'}',
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleScreenCaptureTogglePressed,
        child: const Icon(Icons.key),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _handleScreenCaptureTogglePressed() async {
    final nextValue = !screenCaptureProtected.value;
    await PlatformUtil.preventScreenCapture(enable: nextValue);
    screenCaptureProtected.value = nextValue;
  }
}
