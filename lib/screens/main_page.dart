import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomo_de_paque_website/managers/chatters_manager.dart';
import 'package:pomo_de_paque_website/managers/schedule_manager.dart';
import 'package:pomo_de_paque_website/managers/theme_manager.dart';
import 'package:pomo_de_paque_website/screens/introduction_page.dart';
import 'package:pomo_de_paque_website/screens/prize_page.dart';
import 'package:pomo_de_paque_website/screens/schedule_page.dart';
import 'package:pomo_de_paque_website/screens/streamers_page.dart';
import 'package:pomo_de_paque_website/screens/thanking_page.dart';
import 'package:pomo_de_paque_website/screens/viewers_page.dart';
import 'package:pomo_de_paque_website/widgets/background.dart';
import 'package:pomo_de_paque_website/widgets/menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.isServer});

  static const route = '/main-page';
  final bool isServer;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  bool _isInitialized = false;
  late final _tabMenu = widget.isServer
      ? ['Auditeurs &\nAuditrices', 'Tirage']
      : [
          'Introduction',
          'Animateurs &\nAnimatrices',
          'Horaire',
          'Auditeurs &\nAuditrices',
          'Remerciements'
        ];
  late final _openingTabIfEventIsFinished = widget.isServer ? 0 : 3;

  late final _tabController =
      TabController(length: _tabMenu.length, vsync: this);

  @override
  void initState() {
    super.initState();
    _prepareListTwitchInterface(maxRetries: 10, maxWaitingTime: 2000);

    // The page should open on the last tab at the event
    final sm = ScheduleManager.instance;
    if (sm.hasEventStarted && !sm.hasEventFinished) {
      _tabController.animateTo(_openingTabIfEventIsFinished);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bandWidth = min(750.0, MediaQuery.of(context).size.width * 0.9);
    final columnWidth = bandWidth * 0.9;

    return Scaffold(
      body: Background(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      ThemeManager.instance.boxBackgroundColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                width: bandWidth,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 130),
                Menu(items: _tabMenu, tabController: _tabController),
                const SizedBox(height: 36),
                Expanded(
                  child: Center(
                    child: TabBarView(
                      controller: _tabController,
                      children: widget.isServer
                          ? [
                              ViewersPage(
                                maxWidth: columnWidth,
                                isInitialized: _isInitialized,
                                isServer: widget.isServer,
                              ),
                              PrizePage(maxWidth: columnWidth),
                            ]
                          : [
                              IntroductionPage(maxWidth: columnWidth),
                              StreamersPage(maxWidth: columnWidth),
                              SchedulePage(maxWidth: columnWidth),
                              ViewersPage(
                                maxWidth: columnWidth,
                                isInitialized: _isInitialized,
                                isServer: widget.isServer,
                              ),
                              ThankingPage(maxWidth: columnWidth),
                            ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _prepareListTwitchInterface({
    int retries = 0,
    required int maxWaitingTime,
    required int maxRetries,
  }) async {
    final chatters = ChattersManager.instance;

    // Wait for at least X seconds to load data. If none are received thed,
    // we can assume it is a fresh loading
    if (retries < maxRetries && chatters.isEmpty) {
      await Future.delayed(
          Duration(milliseconds: maxWaitingTime ~/ maxRetries));
      _prepareListTwitchInterface(
        retries: retries + 1,
        maxRetries: maxRetries,
        maxWaitingTime: maxWaitingTime,
      );
      return;
    }

    if (widget.isServer) chatters.startMonitoring();
    _isInitialized = true;
    setState(() {});
  }
}
