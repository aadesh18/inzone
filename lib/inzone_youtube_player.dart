import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class InZoneYoutubePlayer extends StatefulWidget {
  final String youtubeUrl;
  const InZoneYoutubePlayer({super.key, required this.youtubeUrl});

  @override
  State<InZoneYoutubePlayer> createState() => _InZoneYoutubePlayerState();
}

class _InZoneYoutubePlayerState extends State<InZoneYoutubePlayer> {
YoutubePlayerController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.youtubeUrl)??"",
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30)
      ),
      child: YoutubePlayerScaffold(
        controller: _controller!,
        aspectRatio: 16 / 9,
        builder: (context, player) {
          return Column(
            children: [
              player,
            ],
          );
        },
      ),
    );
  }
}
