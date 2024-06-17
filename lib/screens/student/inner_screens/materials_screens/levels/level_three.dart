// import 'package:flutter/material.dart';
// import 'package:uni_assest/widgets/title_text_widget.dart';
//
// import '../../../../../consts/app_colors.dart';
// import '../../../../../widgets/material_widgets/folder_widget.dart';
// import '../pdfs_screen_student_view.dart';
// import '../sections_screen.dart';
//
//
// class LevelThreeScreen extends StatelessWidget {
//    LevelThreeScreen({super.key});
//
//   static String routeName = "LevelThreeScreen";
//   List<String> foldersList = ['Lectures', 'Sections'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: titleTextWidget(txt: "Level 3"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           child:ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) => InkWell(
//               onTap: () {
//                 Navigator.pushNamed(context, LecturesScreen.routeName);
//               },
//               child: folderWidget(
//                 context: context,
//                 title: foldersList[index],
//               ),
//             ),
//             separatorBuilder: (context, index) => const SizedBox(
//               height: 18.0,
//             ),
//             itemCount: foldersList.length,
//           ),
//         ),
//       ),
//     );
//
//   }
// }
