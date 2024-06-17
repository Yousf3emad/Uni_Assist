import 'package:flutter/material.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import 'post_interaction_btn.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.account_circle_sharp,color: Colors.grey,size: 50.0,),
            const SizedBox(width: 10.0,),
            Column(
              children: [
                titleTextWidget(txt: "Owner"),
                Row(
                  children: [
                    Text('3h',style: TextStyle(
                        fontSize: 12.0,fontWeight: FontWeight.w600,color: Colors.grey[700]
                    ),),
                    const SizedBox(width: 2,),
                    const Icon(Icons.public,size: 15.0,)
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 12.0,bottom: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const Text("My post",style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22.0
          ),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,),
          child: Row(
            children: [
              postInteractionBtn(
                context: context,
                txt: "Like",
                txtColor: Colors.blueAccent,
                icon: Icons.favorite_border_outlined,
                iconColor: Colors.redAccent
              ),
              const Text('100'),
              const Spacer(),
              postInteractionBtn(
                context: context,
                txt: "Comment",
                icon: Icons.comment,
                iconColor: Colors.grey,
                txtColor: Colors.grey
              ),
              const Text("100"),
              const SizedBox(width: 12,)

            ],),
        ),
        Container(height: 0.5,color: AppColors.customGrayColor,),

      ],
    );
  }
}
