class RadioItem {
  String id;
  String name;
  String url;
  String? thumbnail;

  RadioItem.fromJson(Map<String, dynamic> map)
      : id = map['radio_id'],
        name = map['radio_name'],
        url = map['radio_url'],
        thumbnail = map['radio_thumbnail'];
}
