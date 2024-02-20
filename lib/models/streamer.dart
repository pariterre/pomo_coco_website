class Streamer {
  final String streamerId;
  final String name;

  Streamer({required this.streamerId, required this.name});

  Streamer.fromSerialized(map)
      : streamerId = map['streamerId'],
        name = map['name'];

  Map<String, dynamic> serializedMap() => {
        'streamerId': streamerId,
        'name': name,
      };
}
