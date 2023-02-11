import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v_media/json/radio.dart';
import 'package:audioplayers/audioplayers.dart';

class RadioPlayer extends StatefulWidget{
  final RadioItem radioItem;
  const RadioPlayer({super.key, required this.radioItem});

  @override
  State<RadioPlayer> createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer> {

  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>startAudioPlayer());
  }


  void startAudioPlayer()async {
    try{
      await _audioPlayer.play(UrlSource(widget.radioItem.url));
      setState(() {

      });
    }catch(_){

    }
  }

  @override
  void didUpdateWidget(covariant RadioPlayer oldWidget) {
    if(widget.radioItem.url != oldWidget.radioItem.url){
      startAudioPlayer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.radioItem;
    bool playing = _audioPlayer.state == PlayerState.playing;
    return Card(
      elevation: 19,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          item.thumbnail == null ? const SizedBox(
            height: 60,
            width: 60,
            child: Center(
              child: Icon(Icons.wifi,size: 25,),
            ),
          ) : Image(image: CachedNetworkImageProvider(item.thumbnail!),width: 60,fit: BoxFit.cover,height: 60,),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(item.name,style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                ),
                const Text("100.7 Mhz - Kigali - Rwanda",style: TextStyle(
                    color: Color(0xff8F8D8D),
                    fontSize: 12
                ),),
              ],
            ),
          )),
          IconButton(onPressed: ()async{
            if(playing){
              await _audioPlayer.pause();
            }else{
              await _audioPlayer.resume();
            }
            setState(() {

            });
          },color: Colors.red, icon: Icon(playing ? Icons.pause_circle_rounded : Icons.play_circle_fill_rounded))
        ],
      ),
    );
  }
}