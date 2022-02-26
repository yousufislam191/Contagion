class User1 {
  final String imagePath;
  // final String name;
  // final String email;
  // final String about;
  // final bool isDarkMode;

  const User1({
    required this.imagePath,
    // required this.name,
    // required this.email,
    // required this.about,
    // required this.isDarkMode,
  });

  User1 copy({
    String? imagePath,
    // String? name,
    // String? email,
    // String? about,
    // bool? isDarkMode,
  }) =>
      User1(
        imagePath: imagePath ?? this.imagePath,
        // name: name ?? this.name,
        // email: email ?? this.email,
        // about: about ?? this.about,
        // isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  static User1 fromJson(Map<String, dynamic> json) => User1(
        imagePath: json['imagePath'],
        // name: json['name'],
        // email: json['email'],
        // about: json['about'],
        // isDarkMode: json['isDarkMode'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        // 'name': name,
        // 'email': email,
        // 'about': about,
        // 'isDarkMode': isDarkMode,
      };
}
