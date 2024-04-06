class AcceptedDateData {
  String? age;
  String? gender;
  String? name;
  String? email;
  String? id;




  AcceptedDateData({
  this.age,
  this.gender,
  this.name,
  this.email,
  this.id,



  });

  AcceptedDateData.fromMap(Map<String, dynamic> map) {
    age = map['age'] ?? '';
    email = map['email'] ?? '';
    name = map['name'] ?? '';
    gender = map['gender'] ?? '';
    id = map['id'] ?? '';

  }

}
