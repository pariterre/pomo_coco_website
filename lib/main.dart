import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pomo_coco_website/firebase_options.dart';
import 'package:pomo_coco_website/managers/chatters_manager.dart';
import 'package:pomo_coco_website/managers/config_manager.dart';
import 'package:pomo_coco_website/managers/schedule_manager.dart';
import 'package:pomo_coco_website/managers/theme_manager.dart';
import 'package:pomo_coco_website/models/chatter.dart';
import 'package:pomo_coco_website/managers/twitch_manager.dart';
import 'package:pomo_coco_website/screens/connect_streamers_page.dart';
import 'package:pomo_coco_website/screens/main_page.dart';

Future<void> _initializeIntl() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fr_CA';
  await initializeDateFormatting();
}

Future<void> _initializeManagers(
    {bool useTwitchMock = false,
    bool useDatabaseEmulator = false,
    bool useManagerMock = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (useTwitchMock) TwitchManagerMock.initializeMock();
  TwitchManager.instance.initialize(
    useMock: useTwitchMock,
    debugOptions: ConfigManager.instance.twitchDebugPanel,
    appInfo: ConfigManager.instance.twichAppInfo,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (useDatabaseEmulator = true) {
    // FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  if (useManagerMock) {
    ScheduleManagerMock.initializeMock();

    final chatters = ChattersManager.instance;
    chatters.add(Chatter(name: 'coucou')
      ..addStreamer('Pariterre')
      ..incrementTimeWatching(7200, of: 'Pariterre'));
    chatters.add(Chatter(name: 'bonjour')
      ..addStreamer('Pariterre')
      ..incrementTimeWatching(3600, of: 'Pariterre')
      ..isBanned = true);
  }
}

void main() async {
  await _initializeIntl();
  await _initializeManagers(
      useTwitchMock: true, useDatabaseEmulator: true, useManagerMock: true);
  runApp(const MyApp(isServer: false));
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
        ConnectedStreamersPage.route: (context) =>
            const ConnectedStreamersPage(),
        MainPage.route: (context) => MainPage(isServer: isServer),
      },
      initialRoute: isServer ? ConnectedStreamersPage.route : MainPage.route,
    );
  }
}
