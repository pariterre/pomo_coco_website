import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:pomo_coco_website/managers/theme_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeBox extends StatelessWidget {
  const YoutubeBox({
    super.key,
    required this.controller,
    required this.videoId,
    this.boxWidth,
    this.widthRatio = 1,
  });

  final double? boxWidth;
  final double widthRatio;
  final YoutubePlayerController controller;
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = boxWidth ?? constraints.maxWidth;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: DeviceInfoPlugin().webBrowserInfo,
              builder: (context, snapshot) {
                // Firefox does not support the youtube player nor that it
                // returns the browser info. So we assume that if the browser
                // is null, it is firefox.
                final browserInfo = snapshot.data?.browserName;
                if (browserInfo == null || browserInfo == BrowserName.firefox) {
                  return GestureDetector(
                    onTap: () => launchUrl(
                        Uri.parse('https://www.youtube.com/watch?v=$videoId')),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: width * widthRatio * 9 / 16,
                            width: width * widthRatio,
                            child: Image.network(
                              'https://i3.ytimg.com/vi/$videoId/hqdefault.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_fill,
                                size: 50,
                                color:
                                    ThemeManager.instance.colorButtonSelected,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SizedBox(
                    width: width * widthRatio,
                    child: YoutubePlayer(controller: controller));
              }),
          SizedBox(width: width)
        ],
      );
    });
  }
}
