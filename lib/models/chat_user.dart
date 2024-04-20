class ChatUser {
  String? image;
  String? about;
  String? name;
  String? id;
  String? email;
  String? pushToken;
  bool? isOnline;
  String? createdAt;
  String? lastActive;


  ChatUser({
    this.name,
    this.about,
    this.email,
    this.id,
    this.image,
    this.isOnline,
    this.lastActive,
    this.createdAt,

    this.pushToken,
  });

  ChatUser.fromJson(Map<String, dynamic> map) {
    image = map['image'] ?? '';
    about = map['about'] ?? '';
    email = map['email'] ?? '';
    id = map['id'] ?? '';
    isOnline = map['isOnline'] ?? '';
    lastActive = map['lastActive'] ?? '';
    pushToken = map['pushToken'] ?? '';
    createdAt = map['createdAt'] ?? '';
    name = map['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['name'] = name;
    _data['about'] = about;
    _data['pushToken'] = pushToken;
    _data['createdAt'] = createdAt;
    _data['id'] = id;
    _data['email'] = email;
    return _data;
  }
}
