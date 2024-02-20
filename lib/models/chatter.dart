class Chatter {
  final String name;

  // _duration and _fromStreamers is expected to always be in sync
  bool isBanned;
  final List<int> _duration;
  final List<String> _fromStreamers;

  int get totalWatchingTime => _duration.fold(0, (prev, e) => prev + e);
  int watchingTime({required String of}) {
    final index = _fromStreamers.indexWhere((streamer) => streamer == of);
    return _duration[index];
  }

  List<String> get streamerNames => [..._fromStreamers];

  void addStreamer(String streamerName) {
    _duration.add(0);
    _fromStreamers.add(streamerName);
  }

  void incrementTimeWatching(int deltaTime, {required String of}) {
    final index = _fromStreamers.indexWhere((streamer) => streamer == of);
    _duration[index] += deltaTime;
  }

  bool get isEmpty => _fromStreamers.isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool hasStreamer(String streamerName) =>
      _fromStreamers.contains(streamerName);
  bool hasNotStreamer(String streamerName) => !hasStreamer(streamerName);

  Chatter({required this.name})
      : isBanned = false,
        _duration = [],
        _fromStreamers = [];

  Chatter.fromSerialized(map)
      : name = map['name'],
        isBanned = map['isBanned'] ?? false,
        _duration =
            (map['duration'] as List?)?.map<int>((e) => e).toList() ?? [],
        _fromStreamers =
            (map['fromStreamers'] as List?)?.map<String>((e) => e).toList() ??
                [];

  Map<String, dynamic> serializedMap() {
    return {
      'name': name,
      'isBanned': isBanned,
      'duration': _duration,
      'fromStreamers': _fromStreamers,
    };
  }
}
