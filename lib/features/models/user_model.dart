class UserModel {
  String? name, gender, skinType, email, uId, password;
  int? skinColor, age;
  UserModel(
      {required this.name,
      required this.email,
      required this.age,
      required this.password,
      required this.gender,
      required this.skinType,
      required this.uId,
      required this.skinColor});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    email = map['email'];
    password = map['password'];
    uId = map['uId'];
    age = map['age'];
    gender = map['gender'];
    skinType = map['skinType'];
    skinColor = map['skinColor'];
  }
  toJson() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'password': password,
      'age': age,
      'gender': gender,
      'skinType': skinType,
      'skinColor  ': skinColor,
    };
  }
}
