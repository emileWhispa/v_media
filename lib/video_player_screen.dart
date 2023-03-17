import 'package:flutter/material.dart';
import 'package:v_media/json/tv.dart';
import 'package:v_media/super_base.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerScreen extends StatefulWidget {
  final TvItem video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends Superbase<VideoPlayerScreen> {


  late YoutubePlayerController _controller;



  @override
  void initState() {
    super.initState();
    initVideo();

  }

  void initVideo(){
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant VideoPlayerScreen oldWidget) {
    if(oldWidget.video.url != widget.video.url){
    _controller.load(YoutubePlayer.convertUrlToId(widget.video.url)!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return player;
            }),
      ),
    );
  }
}
