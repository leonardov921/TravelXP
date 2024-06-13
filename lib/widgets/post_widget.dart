import 'package:flutter/material.dart';

class Post {
  final String userName;
  final String ubi;
  final String userProfileImage;
  final String postTime;
  final String postContent;
  final String? postImage;
  int likes;
  int comments;

  Post({
    required this.userName,
    required this.ubi,
    required this.userProfileImage,
    required this.postTime,
    required this.postContent,
    this.postImage,
    this.likes = 0,
    this.comments = 0,
  });
}

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  List<Post> posts = [
    Post(
      userName: 'Chabelo',
      userProfileImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS44t_-9pqyGtgvZPB9SbcwX6JV4b0nXgXdfQ&s',
      postTime: 'Hace 2 horas',
      ubi: 'Ubicación: Japon',
      postContent: 'Me la pase muy bien en japon.',
      postImage: 'images/japon.jpg',
    ),
    Post(
      userName: 'Rick Sanchez',
      userProfileImage: 'images/rick.jpg',
      ubi: 'Ubicación: España',
      postTime: 'Hace 3 horas',
      postContent: 'Fotito con mi amiga en la catedral de España.',
      postImage: 'images/españa.jpg',
    ),
    Post(
      userName: 'Manuel Santillan',
      userProfileImage: 'images/manuel.jpg',
      ubi: 'Ubicación: Nayar',
      postTime: 'Hace 3 horas',
      postContent: 'Qué bonito es el Nayar.',
      postImage: 'images/nayar.jpeg',
    ),
    Post(
      userName: 'Francisco de la Cruz Santillan',
      userProfileImage: 'images/pancho.jpg',
      ubi: 'Ubicación: La Guajolota',
      postTime: 'Hace 3 horas',
      postContent: 'Bhaiguur jim ya jukgam.',
      postImage: 'images/guajo.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicaciones'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(
            post: posts[index],
            onLike: () {
              setState(() {
                posts[index].likes++;
              });
            },
            onComment: () {
              setState(() {
                posts[index].comments++;
              });
            },
          );
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const PostItem({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.userProfileImage),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      post.postTime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(post.postContent),
            if (post.postImage != null) ...[
              const SizedBox(height: 10),
              Image.network(post.postImage!),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: onLike,
                ),
                Text('${post.likes} Me gusta'),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: onComment,
                ),
                Text('${post.comments} Comentarios'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
