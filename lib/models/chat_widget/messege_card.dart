import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inzone/constants.dart';
import '../auth_work.dart';
import '../messege.dart';
import '../widgets/date_time_util.dart';
import 'package:video_player/video_player.dart';

class MessgeCard extends StatefulWidget {
  final Messges messegs;

  const MessgeCard({Key? key, required this.messegs}) : super(key: key);

  @override
  State<MessgeCard> createState() => _MessgeCardState();
}

class _MessgeCardState extends State<MessgeCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = AuthWork.user.uid == widget.messegs.fromId;
    //
    return InkWell(
      onTap: () {},
      child: isMe ? _redMessege() : _blackMessege(),
    );
  }

  Widget _blackMessege() {
    //update read status yani blue tick ta ky pta lagy msg seen ho gya ky nai
    if (widget.messegs.read!.isEmpty) {
      AuthWork.updateMessageReadStatus(widget.messegs);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //body
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: barUnselectedColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: widget.messegs.type == Typee.text
                        ?
                        //for text in chat
                        Text(
                            '${widget.messegs.msg!.trim()}',
                            style: GoogleFonts.openSans(
                                fontSize: 14, color: Colors.white),
                          )
                        :
                        //for image in chat
                        widget.messegs.type == Typee.video
                            ? InkWell(
                                onTap: () {
                                  // Play video
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerWidget(
                                          widget.messegs.msg!),
                                    ),
                                  );
                                },
                                child:Stack(
                                  children: [
                                    CachedNetworkImage(
                                      height: 250,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      imageUrl: "${widget.messegs.thumbnailUrl}",
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      widget.messegs.type == Typee.video
                                          ? Icon(Icons
                                          .video_camera_back_outlined)
                                          : Icon(Icons.error),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: Icon(Icons.play_arrow,
                                            size: 50, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : widget.messegs.type == Typee.image
                                ? CachedNetworkImage(
                          height: 250,
                          width: 150,
                          fit: BoxFit.fill,
                          imageUrl: "${widget.messegs.msg}",
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                          widget.messegs.type == Typee.video
                              ? Icon(Icons
                              .video_camera_back_outlined)
                              : Icon(Icons.error),
                        )
                                : Container(), // Placeholder for other message types
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  MyDateUtil.getFormattedTime(
                      context: context, time: '${widget.messegs.sent}'),
                  style: TextStyle(fontSize: 10, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _redMessege() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //double tick or msg time
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: barSelectedColor.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                      ),
                    ),
                    child: widget.messegs.type == Typee.text
                        ?
                        //for text in chat
                        Text(
                            '${widget.messegs.msg!.trim()}',
                            style: GoogleFonts.openSans(
                                fontSize: 14, color: Colors.white),
                          )
                        :
                        //for image in chat
                        widget.messegs.type == Typee.video
                            ? InkWell(
                                onTap: () {
                                  // Play video
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerWidget(
                                          widget.messegs.msg!),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      height: 250,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      imageUrl: "${widget.messegs.thumbnailUrl}",
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          widget.messegs.type == Typee.video
                                              ? Icon(Icons
                                                  .video_camera_back_outlined)
                                              : Icon(Icons.error),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: Icon(Icons.play_arrow,
                                            size: 50, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : widget.messegs.type == Typee.image
                                ? CachedNetworkImage(
                                    height: 250,
                                    width: 150,
                                    fit: BoxFit.fill,
                                    imageUrl: "${widget.messegs.msg}",
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) => widget
                                                .messegs.type ==
                                            Typee.image
                                        ? Icon(Icons.video_camera_back_outlined)
                                        : Icon(Icons.error),
                                  )
                                : Container(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  MyDateUtil.getFormattedTime(
                      context: context, time: '${widget.messegs.sent}'),
                  style: TextStyle(fontSize: 10, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget(this.videoUrl);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late bool _isPlaying;
  bool _showControls = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
        });
      });

    _isPlaying = false;
    _controller.addListener(_videoListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _videoListener() {
    final bool isPlaying = _controller.value.isPlaying;
    if (isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    }
  }

  void _togglePlay() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _toggleControlsVisibility() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = _controller.value.aspectRatio;
    return GestureDetector(
      onTap: () {
        _togglePlay();
        _toggleControlsVisibility();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: VideoPlayer(_controller),
              ),
              if (_isLoading)
                CircularProgressIndicator(
                  color: Colors.red,
                ),
              if (_showControls)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: _togglePlay,
                          icon: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: backgroundColor,
                              bufferedColor: Colors.white.withOpacity(0.3),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            _formatDuration(_controller.value.duration),
                            style: TextStyle(color: Colors.white, fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!_controller.value.isPlaying && !_isPlaying && !_showControls)
                Icon(
                  Icons.play_circle_filled,
                  size: 64,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
