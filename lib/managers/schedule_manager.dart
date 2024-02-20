import 'package:pomo_de_paque_website/managers/config_manager.dart';
import 'package:pomo_de_paque_website/models/schedule_info.dart';

class ScheduleManager {
  /// Prepare the singleton
  static ScheduleManager _instance = ScheduleManager._internal();
  static ScheduleManager get instance => _instance;
  ScheduleManager._internal();

  bool get hasEventStarted =>
      DateTime.now().compareTo(DateTime(2024, 4, 10, 14)) > 0;
  bool get hasEventFinished =>
      DateTime.now().compareTo(DateTime(2024, 4, 12, 12)) > 0;

  final eventSchedule = [
    ScheduleInfo(
        title: 'On est fébrile en attendant le Jour-J!',
        url: ConfigManager.instance.facebookEventUrl,
        starting: DateTime.now(),
        length: DateTime(2024, 03, 27, 13, 30).difference(DateTime.now())),
    ScheduleInfo(
        title: 'Ouverture',
        url: 'https://twitch.tv/pariterre',
        starting: DateTime(2024, 03, 27, 13, 30),
        length: const Duration(minutes: 30)),
    ScheduleInfo(
        title: 'Horaire à venir',
        starting: DateTime(2024, 03, 27, 13, 30),
        length: const Duration(days: 2, minutes: 30)),
    ScheduleInfo(
        title: 'Cérémonie de fermeture',
        url: 'https://twitch.tv/pariterre',
        starting: DateTime(2024, 03, 29, 14, 0),
        length: const Duration(minutes: 10)),
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
