import 'package:pomo_coco_website/managers/config_manager.dart';
import 'package:pomo_coco_website/models/schedule_info.dart';

class ScheduleManager {
  /// Prepare the singleton
  static ScheduleManager _instance = ScheduleManager._internal();
  static ScheduleManager get instance => _instance;
  ScheduleManager._internal();

  bool get hasEventStarted =>
      DateTime.now().compareTo(DateTime(2024, 3, 27, 0)) > 0;
  bool get hasEventFinished =>
      DateTime.now().compareTo(DateTime(2024, 3, 29, 14)) > 0;

  final eventSchedule = [
    ScheduleInfo(
        title: 'On est fébrile en attendant le Jour-J!',
        url: ConfigManager.instance.facebookEventUrl,
        starting: DateTime(2024, 03),
        length: const Duration()),
    ScheduleInfo(
        title: 'Cérémonie d\'ouverture',
        url: 'https://twitch.tv/pariterre',
        starting: DateTime(2024, 03, 27, 9, 15),
        length: const Duration(minutes: 45)),
    ScheduleInfo(
        title: 'Pomodoro - Éli\'délivre',
        starting: DateTime(2024, 03, 27, 10, 0),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/elidelivre'),
    ScheduleInfo(
        title: 'Pause discussion',
        starting: DateTime(2024, 03, 27, 14, 0),
        url: 'https://twitch.tv/pariterre',
        length: const Duration(minutes: 30)),
    ScheduleInfo(
        title: 'Pomodoro - lejournaldaely',
        starting: DateTime(2024, 03, 27, 14, 30),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/lejournaldaely'),
    ScheduleInfo(
        title: 'Pause discussion',
        starting: DateTime(2024, 03, 27, 18, 30),
        url: 'https://twitch.tv/pariterre',
        length: const Duration(minutes: 30)),
    ScheduleInfo(
        title: 'Pomodoro - Le_Sketch',
        starting: DateTime(2024, 03, 27, 19, 0),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/le_sketch'),
    ScheduleInfo(
        title: 'Pomo-tricot',
        starting: DateTime(2024, 03, 27, 23, 0),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/pariterre'),
    ScheduleInfo(
        title: 'Pomodoro - MemepAuteure',
        starting: DateTime(2024, 03, 28, 3, 0),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/MemepAuteure'),
    ScheduleInfo(
        title: 'Pause discussion',
        starting: DateTime(2024, 03, 28, 7, 0),
        url: 'https://twitch.tv/pariterre',
        length: const Duration(minutes: 30)),
    ScheduleInfo(
        title: 'Pomodoro - LaLoutreBurlesque',
        starting: DateTime(2024, 03, 28, 7, 30),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/LaLoutreBurlesque'),
    ScheduleInfo(
        title: 'Table ronde',
        starting: DateTime(2024, 03, 28, 11, 30),
        url: 'https://twitch.tv/pariterre',
        length: const Duration(hours: 1, minutes: 30)),
    ScheduleInfo(
        title: 'Pomodoro - LaQueteDuBois',
        starting: DateTime(2024, 03, 28, 13, 0),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/LaQueteDuBois'),
    ScheduleInfo(
        title: 'Pause discussion',
        starting: DateTime(2024, 03, 28, 17, 0),
        url: 'https://twitch.tv/pariterre',
        length: const Duration(minutes: 30)),
    ScheduleInfo(
        title: 'Pomodoro - Pariterre',
        starting: DateTime(2024, 03, 28, 17, 30),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/Pariterre'),
    ScheduleInfo(
        title: 'Activité mystère',
        starting: DateTime(2024, 03, 28, 21, 30),
        length: const Duration(hours: 5, minutes: 30),
        url: 'https://twitch.tv/pariterre'),
    ScheduleInfo(
        title: 'Pomodoro - AudreyAMA',
        starting: DateTime(2024, 03, 29, 3, 0),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/AudreyAMA'),
    ScheduleInfo(
        title: 'Pause discussion',
        starting: DateTime(2024, 03, 29, 7, 0),
        url: 'https://twitch.tv/pariterre',
        length: const Duration(minutes: 30)),
    ScheduleInfo(
        title: 'Pomodoro - Piickwiic',
        starting: DateTime(2024, 03, 29, 7, 30),
        length: const Duration(hours: 4),
        url: 'https://twitch.tv/Piickwiic'),
    ScheduleInfo(
        title: 'Cérémonie de fermeture',
        url: 'https://twitch.tv/pariterre',
        starting: DateTime(2024, 03, 29, 11, 30),
        length: const Duration(minutes: 30)),
  ];
}

class ScheduleManagerMock extends ScheduleManager {
  /// Prepare the singleton
  ScheduleManagerMock._internal() : super._internal();

  static void initializeMock() {
    ScheduleManager._instance = ScheduleManagerMock._internal();
  }

  @override
  bool get hasEventStarted => true;
  @override
  bool get hasEventFinished => true;
}
