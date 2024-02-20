import 'dart:async';

import 'package:pomo_de_paque_website/managers/chatters_manager.dart';
import 'package:pomo_de_paque_website/models/streamer.dart';
import 'package:pomo_de_paque_website/models/twitch_interface.dart';
import 'package:quiver/collection.dart';

class StreamersManager extends DelegatingList<Streamer> {
  final List<Streamer> _streamers = [];

  @override
  List<Streamer> get delegate => _streamers;

  // Prepare the singleton
  static StreamersManager get instance => _instance;
  static final StreamersManager _instance = StreamersManager._internal();
  StreamersManager._internal();

  ///
  /// Time in seconds between each time the chatters are updated
  ///
  int get deltaTime => 60;

  void startWatchingChatters() async {
    for (final streamerId in TwitchInterface.instance.connectedStreamerIds) {
      final streamerLogin =
          (await TwitchInterface.instance.managers[streamerId]!.api.login(
              TwitchInterface.instance.managers[streamerId]!.api.streamerId))!;

      if (!any((e) => e.name == streamerLogin)) {
        add(Streamer(streamerId: streamerId, name: streamerLogin));
      }

      Timer.periodic(Duration(seconds: deltaTime), (timer) async {
        ChattersManager.instance.addChatterTime(
            streamer: firstWhere((e) => e.streamerId == streamerId),
            deltaTime: deltaTime);
      });
    }
  }
}
