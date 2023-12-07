class UserEntity {
  String? uid;
  String? username;
  String? email;
  String? phoneNo;
  String? profilePhoto;

  UserEntity({
    this.uid,
    this.username,
    this.email,
    this.phoneNo,
    this.profilePhoto,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        uid: json['uid'],
        username: json['username'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        profilePhoto: json['profilePhoto'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['profilePhoto'] = profilePhoto;
    return data;
  }

  factory UserEntity.empty() => UserEntity();
}

extension DefaultProfileUrl on String? {
  String get toDefaultProfileUrl {
    if (this == null) {
      return "https://firebasestorage.googleapis.com/v0/b/onco-connect-785f9.appspot.com/o/thumbs-1701868501845.png?alt=media&token=6fe51790-f568-439f-b098-6dc87cb757e6";
    }
    return this!;
  }
}
