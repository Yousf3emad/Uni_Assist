import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';

import '../../consts/end_points.dart';
import '../../models/post/student/student_get_post_model.dart';
import '../../providers/theme_provider.dart';
import '../../shared/remote/api_manager.dart';
import '../../widgets/post_item_widget.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  late Future<PostsResponse> futurePosts;
  final ApiManager apiManager = ApiManager(baseUrl: BASE_URL);

  @override
  void initState() {
    super.initState();
    futurePosts = apiManager.fetchStudentPosts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return FutureBuilder<PostsResponse>(
      future: futurePosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.drawerColor,));
        } else if (snapshot.hasError) {
          print('Error11111: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data!.posts.isEmpty) {
          print('No posts found');
          return const Center(child: Text('No posts Found'));
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ListView.separated(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.posts[index];
                      //final date = post.publisher?.createdAt.split('T')[0];
                      final date = post.generatedAt.split(',')[0];
                      return postItem(
                        context: context,
                        owner: post.publisherName ?? "Owner",
                        date: date,
                        description: post.description ?? "",
                        likesNumber: "${post.likes.length}",
                        commentsNumber: "${post.comments.length}",
                      );

                      // return ListTile(
                      //   title: Text(post.title ?? 'No Title'),
                      //   subtitle: Text(post.description ?? 'No Description'),
                      // );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20.0,
                    ),
                    itemCount: snapshot.data!.posts.length,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
