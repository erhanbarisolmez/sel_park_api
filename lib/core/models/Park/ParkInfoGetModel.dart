class ParkInfoGetAllModel {
  int? id;
  String? parkName;
  String? district;
  String? city;
  double? lat;
  double? lng;
  int? capacity;
  int? emptyCapacity;
  String? workHours;
  String? parkType;
  int? freeTime;
  bool? isOpen;
  bool? enable;

  ParkInfoGetAllModel(
      {this.id,
      this.parkName,
      this.district,
      this.city,
      this.lat,
      this.lng,
      this.capacity,
      this.emptyCapacity,
      this.workHours,
      this.parkType,
      this.freeTime,
      this.isOpen,
      this.enable});

  ParkInfoGetAllModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parkName = json['parkName'];
    district = json['district'];
    city = json['city'];
    lat = json['lat'];
    lng = json['lng'];
    capacity = json['capacity'];
    emptyCapacity = json['emptyCapacity'];
    workHours = json['workHours'];
    parkType = json['parkType'];
    freeTime = json['freeTime'];
    isOpen = json['isOpen'];
    enable = json['enable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parkName'] = parkName;
    data['district'] = district;
    data['city'] = city;
    data['lat'] = lat;
    data['capacity'] = capacity;
    data['emptyCapacity'] = emptyCapacity;
    data['workHours'] = workHours;
    data['parkType'] = parkType;
    data['freeTime'] = freeTime;
    data['isOpen'] = isOpen;
    data['enable'] = enable;
    return data;
  }
}
