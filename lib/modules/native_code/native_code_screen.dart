import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {
  @override
  _NativeCodeScreenState createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  String _batteryLevel = 'Unknown battery level.';
  static const platform = MethodChannel('samples.flutter.dev/battery');

  void _getBatteryLevel() {
    platform.invokeMethod('getBatteryLevel').then((value) {
      setState(() {
        _batteryLevel = 'Battery level at $value % .';
      });
    }).catchError((error) {
      setState(() {
        _batteryLevel = "Failed to get battery level: '${error.message}'.";
      });
    });

    // try {
    //   final int result = await NativeCodeScreen.platform.invokeMethod('getBatteryLevel');
    //   batteryLevel = 'Battery level at $result % .';
    // } on PlatformException catch (e) {
    //   batteryLevel = "Failed to get battery level: '${e.message}'.";
    // }
    //
    // setState(() {
    //   _batteryLevel = batteryLevel;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
