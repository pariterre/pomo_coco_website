class Streamer {
  final String id;
  final String name;

  Streamer({required this.id, required this.name});

  Streamer.fromSerialized(map)
      : id = map['id'],
        name = map['name'];

  Map<String, dynamic> serializedMap() => {
        'id': id,
        'name': name,
      };
}
