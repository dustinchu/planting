import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Provider.debugCheckInvalidValueType = null;
  runApp(App());
}
