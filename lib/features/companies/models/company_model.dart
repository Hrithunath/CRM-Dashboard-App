import 'dart:math';

class Company {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;

  // Mock fields
  final double mockRevenue;
  final double mockActivities;
  final double mockMeetings;
  final String mockStatus;
  final String? notes;

  const Company({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.mockRevenue,
    required this.mockActivities,
    required this.mockMeetings,
    required this.mockStatus,
    this.notes,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    final rand = Random(json['id']);
    final statuses = ['Active', 'Inactive', 'Pending'];
    return Company(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: '${address['street']}, ${address['suite']}, ${address['city']}, ${address['zipcode']}',
      mockRevenue: (50000 + rand.nextInt(100000)).toDouble(),
      mockActivities: (5 + rand.nextInt(20)).toDouble(),
      mockMeetings: rand.nextInt(5).toDouble(),
      mockStatus: statuses[rand.nextInt(statuses.length)],
    );
  }
}
