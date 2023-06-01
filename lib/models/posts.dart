import 'appUser.dart';

class Post {
  final String postID;
  //final User user;
  String title;
  String description;
  double avg_review;
  List<dynamic> comments;
  String imageUrl;
  Post(
      {required this.postID,
      //required this.user,
      required this.title,
      required this.imageUrl,
      this.description: "",
      this.avg_review: 0,
      List<dynamic>? comments})
      : comments = comments ?? [];
}
