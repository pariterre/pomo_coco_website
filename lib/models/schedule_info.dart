class ScheduleInfo {
  final String title;
  final DateTime starting;
  final Duration length;
  final String? url;

  const ScheduleInfo({
    required this.title,
    this.url,
    required this.starting,
    required this.length,
  });

  DateTime get ending => starting.add(length);
}
