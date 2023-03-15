class TvItem {
  String id;
  String name;
  String url;
  String? thumbnail;
  String category;

  TvItem.fromJson(Map<String, dynamic> map)
      : id = map['tv_id'],
        name = map['tv_name'],
        url = map['tv_url'],
        category = map['category'],
        thumbnail = map['tv_thumbnail'];
}
