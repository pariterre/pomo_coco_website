import 'package:pomo_coco_website/models/item_serializable.dart';

class Chatter implements ItemSerializable {
  final String name;
  @override
  String get id => name;

  // _duration and _fromStreamers is expected to always be in sync
  bool isBanned;
  final Map<String, int> _watchTimes;

  int get totalWatchingTime =>
      _watchTimes.values.fold(0, (prev, e) => prev + e);
  int watchingTime({required String of}) {
    return _watchTimes[of] ?? -1;
  }

  List<String> get streamerNames => [..._watchTimes.keys];

  void addStreamer(String streamerName) => _watchTimes[streamerName] = 0;

  void incrementTimeWatching(int deltaTime, {required String of}) {
    if (!hasStreamer(of)) addStreamer(of);
    _watchTimes[of] = _watchTimes[of]! + deltaTime;
  }

  bool get isEmpty => _watchTimes.isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool hasStreamer(String streamerName) =>
      _watchTimes.containsKey(streamerName);
  bool hasNotStreamer(String streamerName) => !hasStreamer(streamerName);

  Chatter({required this.name})
      : isBanned = false,
        _watchTimes = {};

  Chatter.fromSerialized(id, map)
      : name = id,
        isBanned = map['isBanned'] ?? false,
        _watchTimes = (map['watchTimes'] as Map?)
                ?.map((key, value) => MapEntry(key as String, value as int)) ??
            {};

  @override
  Map<String, dynamic> get serializedMap =>
      {'isBanned': isBanned, 'watchTimes': _watchTimes};
}
