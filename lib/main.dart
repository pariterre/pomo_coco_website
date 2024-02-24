import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pomo_coco_website/firebase_options.dart';
import 'package:pomo_coco_website/managers/config_manager.dart';
import 'package:pomo_coco_website/managers/schedule_manager.dart';
import 'package:pomo_coco_website/managers/theme_manager.dart';
import 'package:pomo_coco_website/managers/twitch_manager.dart';
import 'package:pomo_coco_website/screens/connect_streamers_page.dart';
import 'package:pomo_coco_website/screens/main_page.dart';
import 'package:pomo_coco_website/screens/server_login_page.dart';

void main() async {
  await _initializeIntl();
  await _initializeManagers(
      useTwitchMock: true,
      useDatabaseEmulator: true,
      useScheduleManagerMock: true);
  runApp(const MyApp(isServer: true));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isServer});

  final bool isServer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le ${ConfigManager.instance.eventName}',
      theme: ThemeManager.instance.themeData,
      routes: {
        ServerLoginPage.route: (context) => const ServerLoginPage(),
        ConnectedStreamersPage.route: (context) =>
            const ConnectedStreamersPage(),
        MainPage.route: (context) => MainPage(isServer: isServer),
      },
      initialRoute: isServer ? ServerLoginPage.route : MainPage.route,
    );
  }
}

Future<void> _initializeIntl() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fr_CA';
  await initializeDateFormatting();
}

Future<void> _initializeManagers(
    {bool useTwitchMock = false,
    bool useDatabaseEmulator = false,
    bool useScheduleManagerMock = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (useTwitchMock) TwitchManagerMock.initializeMock();
  TwitchManager.instance.initialize(
    useMock: useTwitchMock,
    debugOptions: ConfigManager.instance.twitchDebugPanel,
    appInfo: ConfigManager.instance.twichAppInfo,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (useDatabaseEmulator = true) {
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  if (useScheduleManagerMock) {
    ScheduleManagerMock.initializeMock();
  }
}
