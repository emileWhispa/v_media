import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v_media/json/radio.dart';
import 'package:v_media/super_base.dart';

class RadioScreen extends StatefulWidget{
  final List<RadioItem> radios;
  final void Function(RadioItem item) onSelect;
  final RadioItem? radioItem;
  const RadioScreen({super.key, required this.radios, required this.onSelect, this.radioItem});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends Superbase<RadioScreen> {


  @override
  Widget build(BuildContext context) {

    var list = widget.radios;
    var object = ListView.builder(itemCount: list.length,itemBuilder: (context,index){
      var item = list[index];
      return InkWell(
        onTap: (){
          widget.onSelect(item);
        },
        child: Container(
          decoration: BoxDecoration(
            color: item.id == widget.radioItem?.id ? Colors.black12 : null
          ),
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
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
    title: Image.asset("assets/logo.png",height: 40,),
    ),
      body: object,
    );
  }
}