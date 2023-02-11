import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v_media/json/radio.dart';
import 'package:v_media/radio_player.dart';
import 'package:v_media/super_base.dart';

class RadioScreen extends StatefulWidget{
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends Superbase<RadioScreen> {

  var list = <RadioItem>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)=>loadData());
    super.initState();
  }

  Future<void> loadData(){
    return ajax(url: "radios/",onValue: (s,v){
      setState(() {
        list = (s['Radios'] as Iterable?)?.map((e) => RadioItem.fromJson(e)).toList() ?? [];
      });
    });
  }

  RadioItem? _radioItem;

  @override
  Widget build(BuildContext context) {

    var object = RefreshIndicator(
      onRefresh: loadData,
      child: ListView.builder(itemCount: list.length,itemBuilder: (context,index){
        var item = list[index];
        return InkWell(
          onTap: (){
            setState(() {
              _radioItem = item;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Text("100.7 Mhz",style: TextStyle(
                          color: Color(0xff8F8D8D),
                          fontSize: 12
                      ),),
                      const Text("Kigali - Rwanda",style: TextStyle(
                          color: Color(0xff666363)
                      ),)
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      }),
    );

    return Scaffold(
      appBar: AppBar(
    title: Image.asset("assets/logo.png",height: 40,),
    ),
      body: _radioItem != null ? Column(
        children: [
          Expanded(child: object),
          RadioPlayer(radioItem: _radioItem!)
        ],
      ) : object,
    );
  }
}