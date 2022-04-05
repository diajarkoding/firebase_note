class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String createdAt;
  final String? imageUrl;

  UserModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      this.imageUrl,
      required this.createdAt});

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
        id: id,
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        imageUrl: json['imageUrl'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'imageUrl': imageUrl,
        'createdAt': createdAt,
      };
}
