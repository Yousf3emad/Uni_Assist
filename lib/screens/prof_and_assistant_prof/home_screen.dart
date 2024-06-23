import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/end_points.dart';
import 'package:uni_assest/models/post/add_post_model.dart';
import 'package:uni_assest/shared/remote/api_manager.dart';

import '../../consts/app_colors.dart';
import '../../models/post/get_post_model.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/default_material_btn.dart';
import '../../widgets/post_item_widget.dart';
import '../../widgets/title_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<GetPostModel>> futurePosts;
  final ApiManager apiManager = ApiManager(baseUrl: BASE_URL);

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  //Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //titleController = TextEditingController();
    descriptionController = TextEditingController();

    futurePosts = apiManager.getPosts(endPoint: PROF_OR_ASSIST_GetPost);
  }

  @override
  void dispose() {
    super.dispose();
    //titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: FutureBuilder<List<GetPostModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.drawerColor,));
          } else if (snapshot.hasError) {
            return Center(child: titleTextWidget(txt:  "No Posts Yet",));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
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
                        final post = snapshot.data![index];
                        //final date = post.publisher?.createdAt.split('T')[0];
                        final date = post.generatedAt.split(',')[0];
                        return postItem(
                          context: context,
                          owner: post.publisher?.name ?? "Owner",
                          date: date ?? "",
                          description: post.description ?? "",
                          likesNumber: "${post.likes.length}",
                          commentsNumber: "${post.comments.length}",
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9, top: 2.0),
                      width: 140,
                      height: 9,
                      decoration: BoxDecoration(
                        color: themeProvider.getIsDarkTheme
                            ? AppColors.drawerColor
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    titleTextWidget(
                      txt: "Add new Post",
                      color: themeProvider.getIsDarkTheme ? Colors.white : null,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    // TextFormField(
                    //   controller: titleController,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please enter a title';
                    //     }
                    //     if (value.length < 6) {
                    //       return 'title is too short';
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.text,
                    //   decoration: const InputDecoration(
                    //     hintText: "title",
                    //   ),
                    // ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.length < 200) {
                          return 'description length must be at least 200 characters long';
                        }
                        return null;
                      },
                      maxLines: 8,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Write a description..",
                      ),
                    ),
                    // SizedBox(
                    //   height: 120,
                    //   child: Stack(
                    //     alignment: Alignment.center,
                    //     children: [
                    //       Image.asset(
                    //         color: AppColors.customGrayColor,
                    //         AssetsManager.gallery,
                    //         width: size.height * .3,
                    //         height: size.height * .2,
                    //         fit: BoxFit.contain,
                    //       ),
                    //       const SizedBox(
                    //         height: 6,
                    //       ),
                    //       subTitleTextWidget(
                    //         txt: "tap to drag a photo",
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ],
                    //   ),
                    //),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Spacer(),
                    defaultMaterialBtn(
                      btnColor: AppColors.drawerColor,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _addPost(
                              description:
                                  descriptionController.text.toString());
                          setState(() {
                            futurePosts = apiManager.getPosts(
                                endPoint: PROF_OR_ASSIST_GetPost);
                          });
                          Navigator.pop(context);
                        }
                      },
                      btnWidth: double.infinity,
                      child: titleTextWidget(
                        color: Colors.white,
                        txt: "Add Post ",
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.drawerColor,
        child: Icon(
          color: themeProvider.getIsDarkTheme ? Colors.white : Colors.white,
          Icons.add,
          size: 35,
        ),
      ),
    );
  }

  Future<void> _addPost({
    required String description,
    //required String title,
  }) async {
    final newPost = AddPostModel(
      description: description,
      //publisher: '6669c8bd9f2605aa7f6f1fc6',
      // Replace with actual publisher ID
      //
      // This will be populated by the server
      //version: 0,
      title: "title",
    );

    try {
      final addedPost = await apiManager.addPost(newPost);
    } catch (e) {
      print('Failed to add post: $e');
    }
  }
}
