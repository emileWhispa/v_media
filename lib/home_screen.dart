import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v_media/json/radio.dart';
import 'package:v_media/json/tv.dart';
import 'package:v_media/super_base.dart';
import 'package:v_media/television.dart';
import 'package:v_media/tv_player.dart';
import 'package:v_media/video_player_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<TvItem> tvs0;
  final List<TvItem> tvs;
  final List<RadioItem> radios;
  final void Function(RadioItem item) onSelectRadio;
  final void Function(TvItem item) onSelectTv;
  final TvItem? tvItem;
  const HomeScreen({super.key, required this.tvs, required this.radios, required this.onSelectRadio, required this.onSelectTv, this.tvItem, required this.tvs0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends Superbase<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var list0 = widget.tvs0;
    var list = widget.tvs;
    var radios = widget.radios;
    var tvItem = widget.tvItem;
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: Image.asset(
          "assets/logo.png",
          height: 40,
        ),
      ),
      body: ListView(
        children: [
          tvItem != null ? tvItem.category == 'youtube' ? VideoPlayerScreen(video: tvItem) : !tvItem.url.startsWith("rtsp") ? Television(tvItem: tvItem,) : RemoteTvPlayer(tvItem: tvItem) : Image.asset("assets/slider.png"),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sports",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              // TextButton(onPressed: (){}, child: const Text("View All >"))
            ],
          ),
          SizedBox(
            height: 130,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list0.length,
                itemBuilder: (context, index) {
                  var item = list0[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 5,bottom: 5),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      child: InkWell(
                        onTap: (){
                          widget.onSelectTv(item);
                        },
                        child: SizedBox(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image(
                                image: (item.thumbnail == null
                                    ? const AssetImage("assets/slider.png")
                                    : CachedNetworkImageProvider(
                                        item.thumbnail!)) as ImageProvider,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "TV stations",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              // TextButton(onPressed: (){}, child: const Text("View All >"))
            ],
          ),
          SizedBox(
            height: 130,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var item = list[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 5,bottom: 5),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      child: InkWell(
                        onTap: (){
                          widget.onSelectTv(item);
                        },
                        child: SizedBox(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image(
                                image: (item.thumbnail == null
                                    ? const AssetImage("assets/slider.png")
                                    : CachedNetworkImageProvider(
                                    item.thumbnail!)) as ImageProvider,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Radio Stations",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              // TextButton(onPressed: (){}, child: const Text("View All >"))
            ],
          ),
          SizedBox(
            height: 130,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: radios.length,
                itemBuilder: (context, index) {
                  var item = radios[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 5,bottom: 5),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      child: InkWell(
                        onTap: (){
                          widget.onSelectRadio(item);
                        },
                        child: SizedBox(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image(
                                image: (item.thumbnail == null
                                    ? const AssetImage("assets/slider.png")
                                    : CachedNetworkImageProvider(
                                    item.thumbnail!)) as ImageProvider,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
