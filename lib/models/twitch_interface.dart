import 'package:twitch_manager/twitch_manager.dart';

class TwitchInterface {
  /// Prepare the singleton
  static TwitchInterface get instance => _instance;
  static final TwitchInterface _instance = TwitchInterface._internal();
  TwitchInterface._internal();

  late final TwitchDebugPanelOptions debugOptions;
  late final TwitchAppInfo appInfo;
  late final bool useMock;
  final Map<String, TwitchManager> managers = {};

  void initialize({
    required TwitchDebugPanelOptions debugOptions,
    required TwitchAppInfo appInfo,
    required bool useMock,
  }) {
    this.debugOptions = debugOptions;
    this.appInfo = appInfo;
    this.useMock = useMock;
  }

  List<String> get connectedStreamerIds => managers.keys.toList();

  Future<void> addStreamer(
          {required String streamerId, required TwitchManager manager}) async =>
      managers[streamerId] = manager;
}
