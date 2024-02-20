import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pomo_de_paque_website/managers/config_manager.dart';
import 'package:pomo_de_paque_website/widgets/tab_container.dart';
import 'package:pomo_de_paque_website/widgets/youtube_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final cm = ConfigManager.instance;

    final youtubeController = YoutubePlayerController.fromVideoId(
      videoId: cm.youtubeEventUrlId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    return TabContainer(
      maxWidth: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('INTRODUCTION', style: Theme.of(context).textTheme.titleLarge),
          YoutubeBox(
            controller: youtubeController,
            widthRatio: 0.8,
          ),
          const SizedBox(height: 12),
          const Text(
              'Bienvenue au Pomo-de-Pâques-48h-Relais!! Yeah!! Heu... le quoi?'),
          const SizedBox(height: 12),
          const Text(
              'Le Pomo-de-Pâques-48h-Relais! Ça ne te dit toujours rien? Je t\'explique :'),
          const SizedBox(height: 12),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text:
                    'Alors «\u00a0Pomo\u00a0» pour Pomodoro, qui est une méthode '
                    'de travail par intervalles parfait pour le cotravail en ligne '
                    '(plus de détails sur la méthode pomodoro '),
            TextSpan(
              text: 'ici',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launchUrl(Uri.parse(
                    'https://fr.wikipedia.org/wiki/Technique_Pomodoro')),
            ),
            const TextSpan(
                text:
                    '), «\u00a0Pâques\u00a0» car l\'événement se tient tout prêt '
                    ' de la fête des oeufs et «\u00a048h\u00a0» pour...48 heures! '
                    'Il s\'agit de la troisième édition de l\'événement de '
                    'cotravail en ligne organisé par des animateurs\u00b7trices de la communauté '
                    'de cotravailleurs\u00b7ses francophones de la plateforme Twitch!'),
          ])),
          const SizedBox(height: 12),
          const Text(
              'Viens découvrir des animateurs et animatrices ainsi que des communautés de '
              'travail merveilleuses, en plus de découvrir différentes approches de '
              'la méthode pomodoro. Que ce soit des séances courtes (25 minutes '
              'travail/5 minutes de pause) ou longues (50/10), strictes ou plus...laxistes(!), '
              'il y en aura pour toutes les personnalités, dont la tienne.'),
          const SizedBox(height: 12),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text:
                    'Alors n\'hésite pas à nous joindre juste avant tes examens pour un '
                    'blitz d\'étude ou d\'écriture! Pour les plus vieux d\'entre-vous, '
                    'il y a un événement Facebook que vous pouvez joindre en '
                    'guise de rappel, à l\'adresse suivante : '),
            TextSpan(
              text: cm.facebookEventUrl,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launchUrl(Uri.parse(cm.facebookEventUrl)),
            ),
          ])),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
