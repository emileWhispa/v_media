import 'package:flutter/material.dart';
import 'package:v_media/home_screen.dart';
import 'package:v_media/radio_player.dart';
import 'package:v_media/radio_screen.dart';
import 'package:v_media/super_base.dart';
import 'package:v_media/tv_player.dart';

import 'json/radio.dart';
import 'json/tv.dart';


class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends Superbase<Homepage> {
  List<TvItem> list = [];
  List<RadioItem> radios = [];
  TvItem? _tvItem;
  RadioItem? _radioItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadData();
      loadRadios();
    });
    super.initState();
  }

  Future<void> loadRadios(){
    return ajax(url: "radios/",onValue: (s,v){
      setState(() {
        radios = (s['Radios'] as Iterable?)?.map((e) => RadioItem.fromJson(e)).toList() ?? [];
      });
    });
  }

  Future<void> loadData() {
    return ajax(
        url: "tvs/",
        onValue: (s, v) {
          setState(() {
            list = (s['tvs'] as Iterable?)
                ?.map((e) => TvItem.fromJson(e))
                .toList() ??
                [];
          });
        });
  }

  int _index = 0;

  void onPlayRadio(RadioItem item){
    setState(() {
      _tvItem = null;
      _radioItem = item;
    });
  }


  void onPlayTv(TvItem item){
    setState(() {
      _tvItem = item;
      _radioItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {


    var object = IndexedStack(
      index: _index,
      children: [
        HomeScreen(tvs: list,radios: radios,onSelectRadio: onPlayRadio,onSelectTv: onPlayTv,tvItem: _tvItem,),
        RadioScreen(radios: radios,onSelect: onPlayRadio,radioItem: _radioItem,),
        const Center(),
      ],
    );

    return Scaffold(
      body: _radioItem != null ? Column(
        children: [
          Expanded(child: object),
          RadioPlayer(radioItem: _radioItem!)
        ],
      ) : object,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.wifi),label: "Radio"),
          BottomNavigationBarItem(icon: Icon(Icons.info),label: "Account"),
        ],
      ),
    );
  }
}