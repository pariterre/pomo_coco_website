import 'package:flutter/material.dart';
import 'package:pomo_de_paque_website/managers/config_manager.dart';
import 'package:pomo_de_paque_website/managers/theme_manager.dart';
import 'package:pomo_de_paque_website/models/streamer_info.dart';
import 'package:pomo_de_paque_website/widgets/animated_expanding_card.dart';
import 'package:pomo_de_paque_website/widgets/tab_container.dart';
import 'package:pomo_de_paque_website/widgets/youtube_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class StreamersPage extends StatelessWidget {
  const StreamersPage({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final cm = ConfigManager.instance;

    final streamerInfoSorted = [...cm.streamersInfo]..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

    return TabContainer(
        maxWidth: maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                child: Text('ANIMATEUR ET ANIMATRICES',
                    style: Theme.of(context).textTheme.titleLarge)),
            ...streamerInfoSorted
                .map((e) => _StreamerCard(streamerInfo: e))
                .toList(),
            const SizedBox(height: 50),
          ],
        ));
  }
}

class _StreamerCard extends StatelessWidget {
  const _StreamerCard({required this.streamerInfo});

  final StreamerInfo streamerInfo;
  @override
  Widget build(BuildContext context) {
    final tm = ThemeManager.instance;

    return AnimatedExpandingCard(
      expandedColor: tm.colorButtonSelected,
      closedColor: tm.colorButtonUnselected,
      header: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            streamerInfo.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          InkWell(
              onTap: () {
                launchUrl(Uri.parse(streamerInfo.twitchUrl));
              },
              child: Text(
                streamerInfo.twitchUrl,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black),
              )),
        ]),
      ),
      builder: (context, isExpanded) => isExpanded
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(streamerInfo.description),
                      if (streamerInfo.personalWebSite != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            InkWell(
                                onTap: () {
                                  launchUrl(
                                      Uri.parse(streamerInfo.personalWebSite!));
                                },
                                child: Text(
                                  streamerInfo.personalWebSite!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.black),
                                )),
                          ],
                        ),
                      const SizedBox(height: 12),
                      if (streamerInfo.presentationYoutubeId == null &&
                          streamerInfo.philosophyYoutubeId == null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vidéo de présentation',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const Text('À venir'),
                          ],
                        ),
                      if (streamerInfo.presentationYoutubeId != null)
                        _VideoWithTitle(
                            title: 'Qui suis-je?',
                            videoId: streamerInfo.presentationYoutubeId!),
                      if (streamerInfo.presentationYoutubeId != null &&
                          streamerInfo.philosophyYoutubeId != null)
                        const SizedBox(height: 24),
                      if (streamerInfo.philosophyYoutubeId != null)
                        _VideoWithTitle(
                          title: 'Mon approche du cotravail en pomodoro',
                          videoId: streamerInfo.philosophyYoutubeId!,
                          delayBeforeLoading: 3000,
                        ),
                    ],
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}

class _VideoWithTitle extends StatelessWidget {
  const _VideoWithTitle({
    required this.title,
    required this.videoId,
    this.delayBeforeLoading = 0,
  });

  final String title;
  final String videoId;
  final int delayBeforeLoading;

  ///
  /// For some reason, if two videos are loaded at the same time, one does not
  /// load. This method along with [delayBeforeLoading] allows to delay the
  /// loading of the video while another one is loading
  Future<bool> _wait() async {
    if (delayBeforeLoading != 0) {
      await Future.delayed(Duration(milliseconds: delayBeforeLoading));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final tm = ThemeManager.instance;

    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    return FutureBuilder(
      future: _wait(),
      builder: (context, snapshot) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          if (!snapshot.hasData)
            Center(
              child: CircularProgressIndicator(color: tm.titleColor),
            ),
          if (snapshot.hasData)
            YoutubeBox(controller: controller, widthRatio: 0.8),
        ],
      ),
    );
  }
}
