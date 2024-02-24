import 'dart:async';

import 'package:pomo_coco_website/managers/twitch_manager.dart';
import 'package:pomo_coco_website/models/chatter.dart';
import 'package:pomo_coco_website/models/custom_listener.dart';
import 'package:pomo_coco_website/models/firebase_updater.dart';
import 'package:pomo_coco_website/models/streamer.dart';
import 'package:quiver/collection.dart';

class ChattersManager extends DelegatingList<Chatter>
    with CustomListener, FirebaseUpdater<Chatter> {
  final List<Chatter> _chatters = [];

  @override
  List<Chatter> get delegate => _chatters;

  @override
  String get pathToData => 'chatters';

  // Prepare the singleton
  static ChattersManager get instance => _instance;
  static final ChattersManager _instance = ChattersManager._internal();
  ChattersManager._internal() {
    initializeFirebaseUpdater();
  }

  @override
  void add(Chatter value) {
    super.add(value);
    setToDatabase(value);
    notifyListeners();
  }

  void toggleIsBan(Chatter chatter) {
    chatter.isBanned = !chatter.isBanned;
    setToDatabase(chatter);
    notifyListeners();
  }

  ///
  /// Time in seconds between each time the chatters are updated
  ///
  int get deltaTime => 10;

  void startMonitoring() async {
    for (final streamerId in TwitchManager.instance.streamerIds) {
      final streamer = Streamer(
          id: streamerId,
          name: await TwitchManager.instance.streamerLogin(streamerId));

      Timer.periodic(Duration(seconds: deltaTime),
          (timer) async => _addTime(streamer: streamer));
    }
  }

  void _addTime({required Streamer streamer}) async {
    // If the user is not live, do not add time to their viewers
    final tm = TwitchManager.instance;
    if (!(await tm.isStreamerLive(streamer.id))) return;

    final currentChatters = await tm.fetchChatters(streamer.id);
    if (currentChatters == null) return;

    // Get the followers of the current streamer
    final followers =
        (await tm.fetchFollowers(streamer.id, includeStreamer: true))!;

    for (final chatterName in currentChatters) {
      // Check if it is a new chatter
      if (!any((chatter) => chatter.name == chatterName)) {
        add(Chatter(name: chatterName));
      }
      final currentChatter =
          firstWhere((chatter) => chatter.name == chatterName);

      // The chatter must be a follower of the streamer
      if (!followers.contains(currentChatter.name)) continue;

      // Check if it is the first time on a specific chanel
      if (currentChatter.hasNotStreamer(streamer.name)) {
        currentChatter.addStreamer(streamer.name);
      }

      // Add one time increment to the user
      currentChatter.incrementTimeWatching(deltaTime, of: streamer.name);

      // Update the provider
      setToDatabase(currentChatter);
      notifyListeners();
    }
  }

  @override
  Chatter deserialize(String id, Map<String, dynamic> map) =>
      Chatter.fromSerialized(id, map);

  @override
  void updateAllItems(List<Chatter> items) {
    for (final chatter in items) {
      final index = indexWhere((element) => element.name == chatter.name);
      if (index == -1) {
        add(chatter);
      } else {
        _chatters[index] = chatter;
      }
    }
    notifyListeners();
  }
}
