class Comment {
  final String author;
  final String text;
  final String timestamp;
  final String id;
  final String postId;
  final String userId;
  List<String>? likedBy;
  List<String>? dislikedBy;

  Comment({
    required this.author,
    required this.text,
    required this.timestamp,
    required this.id,
    required this.postId,
    required this.userId,
    this.likedBy,
    this.dislikedBy,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['author'],
      text: json['text'],
      timestamp: json['timestamp'],
      id: json['id'] ?? '', // Add a null check and provide a default value
      postId: json['postId'],
      userId: json['userId'],
      likedBy: json['likedBy'] != null ? List<String>.from(json['likedBy']) : [],
      dislikedBy: json['dislikedBy'] != null ? List<String>.from(json['dislikedBy']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'text': text,
      'timestamp': timestamp,
      'id': id,
      'postId': postId,
      'userId': userId,
      'likedBy': likedBy,
      'dislikedBy': dislikedBy,
    };
  }
}