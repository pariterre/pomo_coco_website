import 'package:pomo_coco_website/models/streamer_info.dart';
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
  final eventName = 'PomoCoco - 48h - Relais';
  final facebookEventUrl = 'https://facebook.com/events/930492188475716';
  String youtubeEventUrlId = 'eodaPPwvwxw';

  ///
  /// Streamers information
  ///
  final streamersInfo = [
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
    StreamerInfo('LaQueteDuBois',
        description:
            'Étant concepteur ébéniste je veux vous présenter mon atelier, '
            'partagé mon savoir et si le temps si prête jouer a quelque jeux '
            'qui m\'inspire.',
        twitchUrl: 'https://www.twitch.tv/LaQueteDuBois'),
    StreamerInfo('Eli\'délivre',
        description:
            '👩🏻‍💻Chroniqueuse littéraire, 21 ans📚Lectures en tous genres '
            '📍Suisse ✉️ Contact pro: elidelivre@gmail.com',
        twitchUrl: 'https://www.twitch.tv/elidelivre'),
    StreamerInfo('LaLoutreBurlesque',
        description: 'Tant qu\'il y a de la loutre il y a de l\'espoir.',
        twitchUrl: 'https://www.twitch.tv/LaLoutreBurlesque'),
    StreamerInfo('lejournaldaely',
        description:
            'Amoureuse des livres 📚, du café ☕, du chocolat 🍫 et des chats '
            '😻Tricoteuse compulsive 🧶Vous trouverez ici des lives '
            'principalement autour de la lecture (RWM, Bookhaul, Challenges '
            'Littéraires, Bilan du mois etc), des séances papotage, des sessions '
            'de loisirs créatifs et un peu de gaming !',
        twitchUrl: 'https://www.twitch.tv/lejournaldaely'),
    StreamerInfo('MemepAuteure',
        description:
            'Salut ! Moi c\'est MemepAuteure ! J\'ai 28 ans et je suis auteure '
            'de fantasy. Sur ma chaîne, tu découvriras des sessions de '
            'co-working et parfois des jeux vidéos.',
        twitchUrl: 'https://www.twitch.tv/MemepAuteure'),
    StreamerInfo('Piickwiic',
        description:
            'Coucou par ici, moi c\'est Anais. J\'ai 37 ans, deux enfants, et '
            'un chat qui répond au doux nom de Minette. C\'est même devenue la '
            'mascotte de la chaine ! Cette chaine parle de livres, mais pas que !'
            ' Si le coeur vous en dit, venez me faire un petit coucou pendant un '
            'live :) Possible coupure à 19h 🤓',
        twitchUrl: 'https://www.twitch.tv/piickwiic'),
    StreamerInfo('AudreyAMA',
        description:
            'Audrey AMA, je me suis lancée sur la folle aventure de l\'écriture '
            'depuis quelques années déjà et j\'espère que mes histoires en feront '
            'voyager plus d\'un ! Bienvenue sur cette chaine, où l\'objectif '
            'est de créer un espace pour écrire ensemble et se motiver.',
        twitchUrl: 'https://www.twitch.tv/audreyama'),
  ];

  ///
  /// Twitch information
  ///
  final twichAppInfo = TwitchAppInfo(
    appName: 'PomoCoco - 48h - Relais',
    twitchAppId: 'wuxnu9zxzhgu3noztxtgdsulk4c950',
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
