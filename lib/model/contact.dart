// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Contact {
  String? objectId;
  String? name;
  String? phone;
  String? email;
  String? urlavatar;
  String? idcontact;
  String? createdAt;
  String? updatedAt;

  Contact(
      {this.objectId,
      this.name,
      this.phone,
      this.email,
      this.urlavatar,
      String? idcontact,
      this.createdAt,
      this.updatedAt})
      : idcontact = idcontact ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
      'phone': phone,
      'email': email,
      'urlavatar': urlavatar,
      'idcontact': idcontact,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      map['objectId'] != null ? map['objectId'] as String : null,
      map['name'] != null ? map['name'] as String : null,
      map['phone'] != null ? map['phone'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['urlavatar'] != null ? map['urlavatar'] as String : null,
      map['idcontact'] != null ? map['idcontact'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);
}
