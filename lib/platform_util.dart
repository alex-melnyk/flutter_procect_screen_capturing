import 'package:flutter/services.dart';

class PlatformUtil {
  static const methodChannelName = 'io.alexmelnyk.utils';
  static const  methodChannel = MethodChannel(methodChannelName);

  static Future<void> preventScreenCapture({bool enable = false}) {
    return methodChannel.invokeMethod<void>('preventScreenCapture', {
      'enable': enable,
    });
  }
}
