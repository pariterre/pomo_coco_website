import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pomo_de_paque_website/managers/chatters_manager.dart';
import 'package:pomo_de_paque_website/managers/config_manager.dart';
import 'package:pomo_de_paque_website/managers/schedule_manager.dart';
import 'package:pomo_de_paque_website/managers/theme_manager.dart';
import 'package:pomo_de_paque_website/models/chatter.dart';
import 'package:pomo_de_paque_website/managers/twitch_manager.dart';
import 'package:pomo_de_paque_website/screens/connect_streamers_page.dart';
import 'package:pomo_de_paque_website/screens/main_page.dart';

Future<void> _initializeIntl() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fr_CA';
  await initializeDateFormatting();
}

Future<void> _initializeManagers({bool useMock = false}) async {
  if (useMock) TwitchManagerMock.initializeMock();
  TwitchManager.instance.initialize(
    useMock: useMock,
    debugOptions: ConfigManager.instance.twitchDebugPanel,
    appInfo: ConfigManager.instance.twichAppInfo,
  );

  if (useMock) {
    ScheduleManagerMock.initializeMock();

    final chatters = ChattersManager.instance;
    chatters.add(Chatter(name: 'coucou'));
    chatters.add(Chatter(name: 'bonjour'));
    chatters[0].addStreamer('Pariterre');
    chatters[1].addStreamer('Pariterre');
    chatters[0].incrementTimeWatching(7200, of: 'Pariterre');
    chatters[1].incrementTimeWatching(3600, of: 'Pariterre');
    chatters[1].isBanned = true;
  }
}

void main() async {
  await _initializeIntl();
  await _initializeManagers(useMock: false);
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
