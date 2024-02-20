import 'package:pomo_de_paque_website/models/chatter.dart';
import 'package:pomo_de_paque_website/models/custom_listener.dart';
import 'package:pomo_de_paque_website/models/streamer.dart';
import 'package:pomo_de_paque_website/models/twitch_interface.dart';
import 'package:quiver/collection.dart';

class ChattersManager extends DelegatingList<Chatter> with CustomListener {
  final List<Chatter> _chatters = [];

  @override
  List<Chatter> get delegate => _chatters;

  // Prepare the singleton
  static ChattersManager get instance => _instance;
  static final ChattersManager _instance = ChattersManager._internal();
  ChattersManager._internal();

  @override
  void add(Chatter value) {
    super.add(value);
    notifyListeners();
  }

  void addChatterTime(
      {required Streamer streamer, required int deltaTime}) async {
    // If the user is not live, do not add time to their viewers
    final api = TwitchInterface.instance.managers[streamer.streamerId]?.api;
    if (api == null) return;
    if (!(await api.isUserLive(api.streamerId))!) return;

    final currentChatters = await api.fetchChatters();
    if (currentChatters == null) return;

    // Get the followers of the current streamer
    final followers = (await api.fetchFollowers(includeStreamer: true))!;

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
      notifyListeners();
    }
  }
}
