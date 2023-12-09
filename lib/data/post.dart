class InZonePost {
  String userName;
  String description;
  String? assetPath;
  String firstName;
  String lastName;
  int likes;
  String profilePicturePath;

  InZonePost({
    required this.userName,
    required this.profilePicturePath,
    required this.description,
    required this.firstName,
    required this.lastName,
    this.likes = 0,
    this.assetPath,
  });
}
