class Planet {
  String? name;
  int? distance;

  Planet({this.name, this.distance});

  Planet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['distance'] = distance;
    return data;
  }
}
