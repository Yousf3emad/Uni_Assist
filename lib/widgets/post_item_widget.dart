
import 'package:flutter/material.dart';
import 'package:uni_assest/widgets/post_interaction_btn.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../consts/app_colors.dart';

Widget postItem({
  required BuildContext context,
  required String owner,
  required String date,
  required String description,
  required likesNumber,
  required commentsNumber,
}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_circle_sharp,
              color: Colors.grey,
              size: 50.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleTextWidget(txt: owner),
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const Icon(
                      Icons.public,
                      size: 15.0,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 12.0, bottom: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            description,
            style:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 22.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Row(
            children: [
              postInteractionBtn(
                  context: context,
                  txt: "Like",
                  txtColor: Colors.blueAccent,
                  icon: Icons.favorite_border_outlined,
                  iconColor: Colors.redAccent),
              Text(likesNumber),
              const Spacer(),
              postInteractionBtn(
                  context: context,
                  txt: "Comment",
                  icon: Icons.comment,
                  iconColor: Colors.grey,
                  txtColor: Colors.grey),
              Text(commentsNumber),
              const SizedBox(
                width: 12,
              )
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: AppColors.customGrayColor,
        ),
      ],
    );
