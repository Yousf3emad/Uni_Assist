import 'package:flutter/material.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';

import '../widgets/post_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            FittedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.8,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 18.0),
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: subTitleTextWidget(txt: "Write a Post..."),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.image_outlined,
                        color: Colors.green, size: 35.0),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
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
    );
  }
}
