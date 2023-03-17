import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'json/tv.dart';


class Television extends StatefulWidget {
  final TvItem tvItem;
  final void Function(Function(int i) func)? setFunc;

  const Television({Key? key,this.setFunc, required this.tvItem}) : super(key: key);

  @override
  State<Television> createState() => TelevisionState();
}

class TelevisionState extends State<Television>  with AutomaticKeepAliveClientMixin<Television> {
  @override
  bool get wantKeepAlive => true;

   VideoPlayerController? _videoPlayerController;
   Future<void>? _initializeVideoPlayerFuture;

  void playVid(String url){
    if( _videoPlayerController != null ) return;

    _videoPlayerController =
        VideoPlayerController.network(url);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
    controller = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: 3 / 2,
      showControls: true,
      autoPlay: true,
      isLive: true,
      //allowFullScreen: widget.user.paid() || !widget.video.isPremium(),
      looping: true,
    );
    // Use the controller to loop the video.
    _videoPlayerController!.setLooping(true);
    setState(() {
      _videoPlayerController!.play();
    });
    widget.setFunc?.call((i){
      if(i == 0) {
        _videoPlayerController!.play();
      } else {
        _videoPlayerController!.pause();
      }
    });
  }


  @override
  void didUpdateWidget(covariant Television oldWidget) {
    if(oldWidget.tvItem.url != widget.tvItem.url){
      playVid(widget.tvItem.url);
    }
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => playVid(widget.tvItem.url));
    super.initState();
  }

  late ChewieController controller;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return SizedBox(
      height: 300,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && _videoPlayerController != null) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Chewie(
                controller: controller);
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}