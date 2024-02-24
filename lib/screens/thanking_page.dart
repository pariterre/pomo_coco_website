import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pomo_coco_website/widgets/tab_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ThankingPage extends StatelessWidget {
  const ThankingPage({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return TabContainer(
      maxWidth: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('REMERCIMENTS', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const Text('Un immense merci aux coanimatrices et coanimateurs de '
              'l\'événement. Honnêtement, je suis sans mots face à la '
              'confiance et l\'accueil que vous portez à chaque itération de ce projet. '
              'Ça me touche sincèrement. Merci!'),
          const SizedBox(height: 12),
          const Text(
              'Finalement, un grand merci à tous les auditeurs et toutes '
              'les auditrices pour votre présence et votre support, que '
              'ce soit pendant ou à l\'extérieur de l\'événement. Vous '
              'êtes tellement importants et importantes pour nous, vous '
              'êtes notre motivation.\nUn grand merci à chacun et chacune '
              'd\'entre vous \u2665'),
          const SizedBox(height: 50),
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
}
