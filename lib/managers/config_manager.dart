import 'package:pomo_de_paque_website/models/streamer_info.dart';
import 'package:twitch_manager/twitch_manager.dart';

class ConfigManager {
  ///
  /// Prepare the singleton
  ///
  static final ConfigManager _instance = ConfigManager._internal();
  static ConfigManager get instance => _instance;
  ConfigManager._internal();

  ///
  /// General information
  ///
  final eventName = 'Pomo de Paques - 48h - Relais';
  final facebookEventUrl = 'https://facebook.com/events/1557104731490847';
  String youtubeEventUrlId = 'eodaPPwvwxw';

  ///
  /// Streamers information
  ///
  final streamersInfo = [
    StreamerInfo(
      'Helene_Ducrocq',
      description:
          'Bienvenue dans mon studio de création ! Découvre mon quotidien de '
          'réalisatrice de films d\'animation, d\'illustratrice, d\'autrice '
          'de livres et d\'artiste. Ici, on coworke pou parler créativité, '
          'coups de coeur et je réalise en direct mes prochains projets '
          '(4 films en animation, 1 livre, 1 expo).',
      twitchUrl: 'https://twitch.tv/Helene_Ducrocq',
      personalWebSite: 'https://www.lesmalaimes.fr',
      presentationYoutubeId: 'wmozo8-xjTE',
      philosophyYoutubeId: 'zxv7PvuKWfM',
    ),
    StreamerInfo(
      'Le_Sketch',
      description:
          'Je parle de marketing en essayant de ne pas vous endormir, je '
          'découvre des jeux avec vous et je raconte des blagues nulles trop '
          'souvent. Je suis un consultant SEO qui tente de rendre le marketing '
          'Web plus sympathique et empathique.',
      twitchUrl: 'https://twitch.tv/Le_Sketch',
      presentationYoutubeId: '-L-6w6j5QqA',
      philosophyYoutubeId: 'b_tMzOHvulU',
    ),
    StreamerInfo(
      'LizEMyers',
      description:
          'French author living in the US / Auteur française - Fantasy - '
          'Urban Fantasy expatriée aux USA / Saga Mathilda Shade',
      twitchUrl: 'https://twitch.tv/LizEMyers',
      presentationYoutubeId: 'SkYBOe7RbFA',
    ),
    StreamerInfo(
      'Pariterre',
      description:
          'Étudiant en musique à une certaine époque, étudiant en kinésiologie '
          'à une autre...Alors pourquoi pas compléter un doctorat en Science '
          'de l\'Activité Physique chez les musiciens?',
      twitchUrl: 'https://twitch.tv/Pariterre',
      presentationYoutubeId: 'TJHV5L9P12k',
      philosophyYoutubeId: 'iwt_sJ5KFWM',
    ),
  ];

  ///
  /// Twitch information
  ///
  final twichAppInfo = TwitchAppInfo(
    appName: 'Pomo de Paque - 48h - Relais',
    twitchAppId: 'XXXXXXX',
    redirectDomain: 'twitchauthentication.pariterre.net',
    scope: [TwitchScope.chatters, TwitchScope.readFollowers],
  );
  final twitchDebugPanel = TwitchDebugPanelOptions(
    chatters: [
      TwitchChatterMock(displayName: 'Chatter1'),
      TwitchChatterMock(displayName: 'Chatter2'),
    ],
  );
}
