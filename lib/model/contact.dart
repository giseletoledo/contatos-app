class Contact {
  List<Contacts>? results;

  Contact({this.results});

  Contact.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Contacts>[];
      json['results'].forEach((v) {
        results!.add(Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  String? objectId;
  String? name;
  String? phone;
  String? email;
  String? urlavatar;
  String? idcontact;
  String? createdAt;
  String? updatedAt;

  Contacts(
      {this.objectId,
      this.name,
      this.phone,
      this.email,
      this.urlavatar,
      this.idcontact,
      this.createdAt,
      this.updatedAt});

  Contacts.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    urlavatar = json['urlavatar'];
    idcontact = json['idcontact'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['urlavatar'] = urlavatar;
    data['idcontact'] = idcontact;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
