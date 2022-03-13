class User1 {
  final String imagePath;

  const User1({
    required this.imagePath,
  });

  User1 copy({
    String? imagePath,
  }) =>
      User1(
        imagePath: imagePath ?? this.imagePath,
      );

  static User1 fromJson(Map<String, dynamic> json) => User1(
        imagePath: json['imagePath'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
      };
}
