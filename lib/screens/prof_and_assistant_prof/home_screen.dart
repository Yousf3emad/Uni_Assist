import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';

import '../../consts/app_colors.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/post_item_widget.dart';
import '../../widgets/title_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // FittedBox(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: size.width * 0.8,
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 12.0, horizontal: 18.0),
              //         height: 50.0,
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.blueAccent),
              //           borderRadius: BorderRadius.circular(50.0),
              //         ),
              //         child: subTitleTextWidget(txt: "Write a Post..."),
              //       ),
              //       const SizedBox(
              //         width: 8.0,
              //       ),
              //       IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.image_outlined,
              //             color: Colors.green, size: 35.0),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 15.0,
              // ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => const PostItem(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20.0,
                ),
                itemCount: 30,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(12.0),
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
                  TextField(
                    //controller: ,
                    onTap: () {},
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Write here..",
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Image.asset(
                    AssetsManager.gallery,
                    width: size.height * .3,
                    height: size.height * .2,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 6,),
                  subTitleTextWidget(txt: "tap to drag a photo"),
                ],
              ),
            ),
          );
        },
        backgroundColor: AppColors.drawerColor,
        child: Icon(
          color: themeProvider.getIsDarkTheme? Colors.white : Colors.black,
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
