class ParkInfoDelete {
  String? uuid;

  ParkInfoDelete(String? id, {this.uuid});

  ParkInfoDelete.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    return data;
  }
}
