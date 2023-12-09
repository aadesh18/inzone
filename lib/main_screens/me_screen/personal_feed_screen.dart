import 'package:flutter/material.dart';
import 'package:inzone/data/post.dart';
import 'package:inzone/main_screens/components/post_card.dart';

class PersonalFeedScreen extends StatelessWidget {
  const PersonalFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PostCard(
                post: InZonePost(
                    userName: "Aadesh Kheria",
                    profilePicturePath: "images/sample_avatar_2.png",
                              firstName: "David",
                    lastName: "Morel",
                    description:
                        "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama")),
            PostCard(
                post: InZonePost(
                    userName: "Marianne Onile",
                    profilePicturePath: "images/sample_avatar_1.png",
                              firstName: "David",
                    lastName: "Morel",
                    description:
                        "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama")),
            PostCard(
                post: InZonePost(
                    userName: "David Morel",
                    profilePicturePath: "images/sample_avatar_2.png",
                              firstName: "David",
                    lastName: "Morel",
                    description:
                        "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama",
                    assetPath: "images/sample_picture_2.png")),
            PostCard(
                post: InZonePost(
                    userName: "Aadesh",
                    profilePicturePath: "images/sample_avatar_1.png",
                              firstName: "David",
                    lastName: "Morel",
                    description:
                        "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama")),
            PostCard(
                post: InZonePost(
                    userName: "Jayme",
                    profilePicturePath: "images/sample_avatar_2.png",
                              firstName: "David",
                    lastName: "Morel",
                    description:
                        "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama",
                    assetPath: "images/sample_picture_1.png")),
          ],
        ),
      ),
    );
  }
}
