import 'package:firebase_auth/firebase_auth.dart';

class AcceptedDateData {


  String? name;
  String? email;
  String? id;




  AcceptedDateData({

  this.name,
  this.email,
  this.id,



  });

  AcceptedDateData.fromMap(Map<String, dynamic> map) {
    try {
      email = map['email'] ?? '';
      name = map['name'] ?? '';

      id = map['id'] ?? '';
    } catch (e){

      email = map['email'] ?? FirebaseAuth.instance.currentUser!.email;
      name = map['name'] ?? FirebaseAuth.instance.currentUser!.displayName;

      id = map['id'] ?? FirebaseAuth.instance.currentUser!.uid;
    }


  }

}
