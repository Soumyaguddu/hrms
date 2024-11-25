class UserProfileData {
  final Employee employee;

  UserProfileData({required this.employee});

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      employee: Employee.fromJson(json['employee']),
    );
  }
}

class Employee {
  final Kycinfo kycinfo;

  Employee({required this.kycinfo});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      kycinfo: Kycinfo.fromJson(json['Kycinfo']), // Ensure case matches JSON
    );
  }
}

class Kycinfo {
  final String? pf_no; // Use nullable type
  final String? esi_no; // Use nullable type

  Kycinfo({this.pf_no, this.esi_no}); // Optional fields

  factory Kycinfo.fromJson(Map<String, dynamic> json) {
    return Kycinfo(
      pf_no: json['pf_no'] as String?, // Safely cast as nullable
      esi_no: json['esi_no'] as String?, // Safely cast as nullable
    );
  }
}
