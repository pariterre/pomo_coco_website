import 'package:flutter/material.dart';
import 'package:pomo_coco_website/widgets/tab_container.dart';
import 'package:pomo_coco_website/widgets/youtube_box.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MysteryEventPage extends StatelessWidget {
  const MysteryEventPage({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return TabContainer(
      maxWidth: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ACTIVITÉ MYSTÈRE',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                  text:
                      'Une activité mystère se déroulera lors de la seconde nuit '
                      'de l\'événement. Cette activité est maintenant révélée!\n'
                      '\n'
                      'Il s\'agit d\'une quête de Donjons & Dragons! Nous continuerons '
                      'l\'aventure de la troupe de héros qui a été lancée depuis un peu plus '
                      'd\'un an maintenant. Afin que vous ne soyez pas trop perdu\u00b7e\u00b7s, '
                      'voici un résumé de la quête jusqu\'à maintenant :')),
          const SizedBox(height: 36),
          Text('RÉSUMÉ DE LA QUÊTE DE DONJONS & DRAGONS',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: maxWidth * 0.75,
              child: Column(
                children: [
                  YoutubeBox(
                      controller: YoutubePlayerController.fromVideoId(
                        videoId: 'RyuOX4Hed6Y',
                        autoPlay: false,
                        params: const YoutubePlayerParams(
                          mute: false,
                          showControls: true,
                          showFullscreenButton: true,
                        ),
                      ),
                      videoId: 'RyuOX4Hed6Y'),
                  const SizedBox(height: 8),
                  const Text.rich(
                      textAlign: TextAlign.justify,
                      TextSpan(children: [
                        TextSpan(text: 'Au cœur des terres de '),
                        TextSpan(
                            text: 'Mëolan-Tir',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ', le destin du '),
                        TextSpan(
                            text: 'Royaume Garnan',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ' vacillait sous une épée de Damoclès. Sous la férule de son '
                                'maître éponyme, le '),
                        TextSpan(
                            text: 'Seigneur Garnan',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ', les tensions entre le '
                                'Nord et le Sud menaçaient d\'engloutir la contrée dans un '
                                'tourbillon de violence. Pour conjurer le péril, le Seigneur '
                                'dépêcha une troupe d\'élite, fraîchement diplômée de l\'École '
                                'des Héros de Somalion, afin d\'éclaircir les mystères qui '
                                'planaient sur le Nord rebelle, et de ramener à la Tour Garnan, '
                                'morts ou vifs, les responsables de la gangrène qui gagnait le '
                                'Royaume.\n'
                                '\n'
                                'Composée de l\'ensorceleuse '),
                        TextSpan(
                            text: 'Filiwi',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ' et sa fidèle chouette '),
                        TextSpan(
                            text: 'Amwebile',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ', de la roublarde '),
                        TextSpan(
                            text: 'Valériane',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ', de la druidesse '),
                        TextSpan(
                            text: 'Freydr',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ' et du rôdeur '),
                        TextSpan(
                            text: 'Igramule II',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ', la troupe se lança dans une quête périlleuse. '
                                'Dès la première ville qu\'ils croisèrent, '),
                        TextSpan(
                            text: 'Meÿor',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ', les premières esquisses du conflit se révélèrent. Lors d\'une rencontre avec '),
                        TextSpan(
                            text: 'Grämmy',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ', le seul représentant du Nord au festival du Royaume, '
                                'celui-ci dévoila les tensions raciales entre les humains du '
                                'Sud et les gnomes et haflings du Nord. La mort attendait '
                                'cependant le pauvre '),
                        TextSpan(
                            text: 'Grämmy',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ', qui fut assassiné dans une ruelle sombre sous les yeux des aventuriers.\n'
                                '\n'
                                'Au fil de leur voyage vers le Nord, les héros découvrirent '
                                'que la responsable de la rébellion n\'était nulle autre '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ', la sœur de feu '),
                        TextSpan(
                            text: 'Grämmy',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                '. Celle-ci semblait également être accompagnée '
                                'dans ses plans par la mystérieuse '),
                        TextSpan(
                            text: 'J',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: '. '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ' invita enfin les aventuriers à assister à une rencontre des rebelles, où un des gnomes, '),
                        TextSpan(
                            text: 'Cyrus',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ', chuchotait constamment à son oreille et semblait '
                                's\'en prendre aux aventuriers. Cependant, durant la nuit, les paroles '
                                'de '),
                        TextSpan(
                            text: 'Cyrus',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ', tel un venin pour l\'âme, avaient fait leur œuvre dans '
                                'l\'esprit de '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ', qui fit emprisonner le groupe. Là, les '
                                'aventuriers rencontrèrent '),
                        TextSpan(
                            text: 'Dolmor',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ', un nain jeté en prison dans '
                                'des circonstances obscures qui accepta de se joindre à l\'équipe '
                                'dans leur quête de la vérité.\n'
                                '\n'
                                'Le chaos de la guerre en préparation fut une couverture suffisante '
                                'pour permettre aux aventuriers de s\'évader et de mettre tout en '
                                'œuvre pour convaincre '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ' de la dangerosité de son principal acolyte, le traître '),
                        TextSpan(
                            text: 'Cyrus',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: '. '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ' écouta les doléances du groupe et accepta finalement que les '
                                'aventuriers soient à ses côtés \u2014 mais accompagnés de '),
                        TextSpan(
                            text: 'Cyrus',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ' \u2014 pour marcher sur '),
                        TextSpan(
                            text: 'Balmoral',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ', la ville voisine. C\'est au château de '),
                        TextSpan(
                            text: 'Balmoral',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ' que la trahison de '),
                        TextSpan(
                            text: 'Cyrus',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ' fut révélée alors qu\'il captura '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ' pour la remettre aux mains de la cheffe de la milice, la puissante orc '),
                        TextSpan(
                            text: 'Thidon',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: '. '),
                        TextSpan(
                            text: 'Phimmuth ',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: 'fut torturée par '),
                        TextSpan(
                            text: 'Thidon',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ' qui tentait de réveiller la nature lycanthrope '
                                'de la rebelle. Soupçonneuse que le groupe avait tourné le dos au '),
                        TextSpan(
                            text: 'Seigneur Garnan',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ', elle leur donna une occasion de racheter leur '
                                'honneur en étant ceux qui planteraient un pieu d\'argent dans le '
                                'cœur de '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ', la rebelle du Nord.\n'
                                '\n'
                                'Face à ce dilemme, les héros firent un choix : défendre l\'honneur '
                                'et la vie de '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: '. Sauvée, elle mit à mort '),
                        TextSpan(
                            text: 'Cyrus',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                ' puis donna la mission au groupe d\'aller porter une missive à son amie, la '
                                'fameuse\u00a0'),
                        TextSpan(
                            text: 'J',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: '\u00a0:\u00a0'),
                        TextSpan(
                            text: 'Jeanne la Vigilente',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ', puissante paladine et mairesse de '),
                        TextSpan(
                            text: 'Cár',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                '. La missive que le groupe devait porter était simple : '
                                'l\'attaque du Nord aurait lieu dans deux semaines, lors du banquet '
                                'annuel tenu à la '),
                        TextSpan(
                            text: 'Tour Garnan',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: ', et '),
                        TextSpan(
                            text: 'Phimmuth',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: ' espérait des renforts.\n'
                                '\n'
                                'La bataille finale approchait, et avec elle, le destin de tout '
                                'un royaume, mais avant toute chose, le groupe devait se rendre '
                                'à Cár pour rencontrer '),
                        TextSpan(
                            text: 'Jeanne',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(text: '...'),
                      ])),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
