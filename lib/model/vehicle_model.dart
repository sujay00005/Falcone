class Vehicle {
  String? name;
  int? totalNo;
  int? maxDistance;
  int? speed;

  Vehicle({this.name, this.totalNo, this.maxDistance, this.speed});

  Vehicle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalNo = json['total_no'];
    maxDistance = json['max_distance'];
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['total_no'] = totalNo;
    data['max_distance'] = maxDistance;
    data['speed'] = speed;
    return data;
  }
}
