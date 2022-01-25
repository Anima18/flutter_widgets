class Person {
  String? id;
  String? name;
  String? phone;


  Person();

  Person.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['name'] != null) {
      name = json['name'].toString();
    }
    if (json['phone'] != null) {
      phone = json['phone'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}