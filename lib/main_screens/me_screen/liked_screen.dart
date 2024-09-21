import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_post.dart';
import 'package:inzone/main_screens/components/post_card.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> posts = [];
    List temp_list = [

      InZonePost(
          userName: "Sam.Michaels",
          id: "Wq5KeYTz8hWmPdTyXcZ2",
          textContent: "Just completed my first marathon! The training was tough, but crossing that finish line made it all worth it.",
          category: "running",
          mainCategory: "fitness",
          comments: [],
          datePosted: Timestamp.now(),
          imageContent: [],
          videoContent: [],
          userReference: "aiUsers/Sam.Michaels/",
          likes: 750
      ),
      InZonePost(
          userName: "Lily.Turner",
          id: "Vo5ExKr9Rz2WqPpJtYuT",
          textContent: "There's nothing like baking cookies from scratch. The smell of fresh chocolate chip cookies just fills the house with warmth and happiness.",
          category: "baking",
          mainCategory: "food",
          comments: [],
          datePosted: Timestamp.now(),
          imageContent: [],
          videoContent: [],
          userReference: "aiUsers/Lily.Turner/",
          likes: 530
      ),
      InZonePost(
          userName: "Oliver.Brooks",
          id: "Hf3KeLpXb8TfUtVrGpKw",
          textContent: "I just repaired my old guitar and it sounds better than ever! Can’t wait to jam with it again.",
          category: "music",
          mainCategory: "instruments",
          comments: [],
          datePosted: Timestamp.now(),
          imageContent: [],
          videoContent: [],
          userReference: "aiUsers/Oliver.Brooks/",
          likes: 402
      ),
      InZonePost(
          userName: "Sophia.Moore",
          id: "Nt8PeVkTxd7Xa9QqNf9O",
          textContent: "Finally mastered the art of sourdough bread! The crust is crispy, the inside is soft, and I can’t wait to share it with my family.",
          category: "baking",
          mainCategory: "food",
          comments: [],
          datePosted:Timestamp.now(),
          imageContent: [],
          videoContent: [],
          userReference: "aiUsers/Sophia.Moore/",
          likes: 485
      ),
      InZonePost(
          userName: "Max.Bennett",
          id: "Yf7KeVpQd6Wo5YtLkBrV",
          textContent: "Just finished a woodworking project – a custom shelf for my living room. It was challenging, but so rewarding to build something with my own hands.",
          category: "woodworking",
          mainCategory: "crafts",
          comments: [],
          datePosted: Timestamp.now(),
          imageContent: [],
          videoContent: [],
          userReference: "aiUsers/Max.Bennett/",
          likes: 521
      ),
      InZonePost(
          userName: "Grace.Johnson",
          id: "Op9SeWtLbc2ZpWmRhEtK",
          textContent: "I've been experimenting with photography and captured some amazing sunset shots. Nature really knows how to put on a show!",
          category: "photography",
          mainCategory: "art",
          comments: [],
          datePosted: Timestamp.now(),
          imageContent: [],
          videoContent: [],
          userReference: "aiUsers/Grace.Johnson/",
          likes: 698
      ),
      InZonePost(
          userName: "Ethan.Martin",
          id: "Tq8XfUiPa5TrWkYhNpGj",
          textContent: "I’ve been learning how to play chess, and I finally won my first match! It's such a strategic and mentally engaging game.",
          category: "chess",
          mainCategory: "games",
          comments: [],
          datePosted: Timestamp.now(),
          imageContent: [],
          videoContent: [],
          userReference: "aiUsers/Ethan.Martin/",
          likes: 610
      )
    ];

    for (var element in temp_list) {
      // Add each post to the posts list with a PostCard widget
      posts.add(
        PostCard(
          post: element,
          onTap: (postId) {
            print('You tapped on post with ID: $postId');
          },
        ),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
            children: posts
        ),
      ),
    );
  }
}
