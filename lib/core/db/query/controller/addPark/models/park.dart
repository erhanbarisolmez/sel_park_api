class Park {
  late final BigInt parkId;
  late final String parkName;
  late final String capacity;
  late final String emptyCapacity;
  late final String freeTime;
  late final String district;
  late final String workHours;

  Park({
    required this.parkId,
    required this.parkName,
    required this.capacity,
    required this.emptyCapacity,
    required this.freeTime,
    required this.district,
    required this.workHours,
  });

  factory Park.fromMap(Map<String, dynamic> map) {
    final parkId = BigInt.from(map['park_id'] as int);
    final parkName = map['parkName'] as String;
    final capacity = map['capacity'] as String;
    final emptyCapacity = map['emptyCapacity'] as String;
    final freeTime = (map['freeTime'] as int).toString();
    final district = map['district'] as String;
    final workHours = map['workHours'] as String;

    return Park(
      parkId: parkId,
      parkName: parkName,
      capacity: capacity,
      emptyCapacity: emptyCapacity,
      freeTime: freeTime,
      district: district,
      workHours: workHours,
    );
  }
}
