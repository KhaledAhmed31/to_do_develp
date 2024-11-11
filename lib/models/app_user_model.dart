class AppUserModel {
  final String? name;
  final String? id;
  final String? email;

  AppUserModel({this.name, this.id, this.email});
  AppUserModel.fromJson(Map<String, dynamic> json)
      : this(name: json['name'], id: json['id'], email: json['email']);
  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id, 'email': email};
  }
}
