class TvItem {
  String id;
  String name;
  String url;
  String? thumbnail;

  TvItem.fromJson(Map<String, dynamic> map)
      : id = map['tv_id'],
        name = map['tv_name'],
        url = map['tv_url'],
        thumbnail = map['tv_thumbnail'];
}
