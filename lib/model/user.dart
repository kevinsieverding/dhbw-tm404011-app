class User {
  int? id;
  String? name;

  User();

  User.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null && map['id'] is int),
        id = map['id'] {
    final name = map['name'];
    if (name != null && name is String) {
      this.name = name;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }
}
