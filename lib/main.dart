import 'package:flutter/material.dart';
import 'package:keeply/app.dart';
import 'package:keeply/core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const KeeplyApp());
}
