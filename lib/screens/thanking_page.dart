import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pomo_coco_website/managers/config_manager.dart';
import 'package:pomo_coco_website/managers/theme_manager.dart';
import 'package:pomo_coco_website/models/prize.dart';
import 'package:pomo_coco_website/widgets/tab_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ThankingPage extends StatelessWidget {
  const ThankingPage({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final cm = ConfigManager.instance;

    return TabContainer(
      maxWidth: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('REMERCIMENTS', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const Text.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                  text: 'Un immense merci aux coanimatrices et coanimateurs de '
                      'l\'événement. Honnêtement, je suis sans mots face à la '
                      'confiance et l\'accueil que vous portez à chaque itération de ce projet. '
                      'Ça me touche sincèrement. Merci!')),
          const SizedBox(height: 12),
          const Text.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                  text:
                      'Merci aux animateurs et animatrices qui ont accepté de '
                      'de donner des prix de participation. Votre générosité '
                      'est sincèrement appréciée.')),
          const SizedBox(height: 12),
          const Text.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                  text:
                      'Finalement, un grand merci à tous les auditeurs et toutes '
                      'les auditrices pour votre présence et votre support, que '
                      'ce soit pendant ou à l\'extérieur de l\'événement. Vous '
                      'êtes tellement importants et importantes pour nous, vous '
                      'êtes notre motivation.\nUn grand merci à chacun et chacune '
                      'd\'entre vous \u2665')),
          const SizedBox(height: 40),
          Text.rich(TextSpan(
            children: [
              const TextSpan(text: '\n'),
              TextSpan(
                  text: 'Prix de participation',
                  style: ThemeManager.instance.themeData.textTheme.titleSmall),
              const TextSpan(text: '\n'),
              ...cm.prizes.asMap().keys.map((index) =>
                  _prizeToText(index: index + 1, prize: cm.prizes[index]))
            ],
          )),
          const SizedBox(height: 40),
          Text('Crédits', style: Theme.of(context).textTheme.titleSmall),
          // Put some bullet points
          Text.rich(TextSpan(
            children: [
              const TextSpan(text: 'Site web réalisé par Benjamin Michaud.'),
              const TextSpan(text: '\n'),
              const TextSpan(text: 'Les illustrations ont été produites par '),
              TextSpan(
                  text: 'Freepik',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrl(Uri.parse('https://freepik.com'));
                    },
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      decorationColor: Colors.black)),
              const TextSpan(text: '.'),
            ],
          )),
        ],
      ),
    );
  }

  TextSpan _prizeToText({required int index, required Prize prize}) {
    return TextSpan(
      children: [
        TextSpan(text: '    $index. '),
        TextSpan(
            text: prize.title,
            style: const TextStyle(fontStyle: FontStyle.italic)),
        const TextSpan(text: ', '),
        TextSpan(
            text: prize.person,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        if (prize.url != null)
          TextSpan(children: [
            const TextSpan(text: ' ('),
            TextSpan(
                text: 'Plus d\'info',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(Uri.parse(prize.url!));
                  },
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black)),
            const TextSpan(text: ')'),
          ]),
        const TextSpan(text: '\n'),
      ],
    );
  }
}
