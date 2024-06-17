// import 'package:flutter/material.dart';
// import 'package:uni_assest/widgets/sub_title_text_widget.dart';
//
// import '../../../../widgets/title_text_widget.dart';
//
//
// class SectionsScreen extends StatelessWidget {
//   const SectionsScreen({super.key});
//
//   static const String routeName = "SectionsScreen";
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: titleTextWidget(txt: "Sections"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//         child: GridView.builder(
//           physics: const BouncingScrollPhysics(),
//           //shrinkWrap: true,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisExtent: 50,
//             mainAxisSpacing: 18,
//           ),
//           itemBuilder: (context, index) => Container(
//             padding: const EdgeInsets.all(12.0),
//             height: MediaQuery.of(context).size.width * 0.3,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18.0),
//               color: Colors.grey[400],
//             ),
//             child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                 onTap: () {
//                   print("View Section ${index + 1}");
//                 },
//                 child: FittedBox(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(
//                         Icons.folder_copy,
//                         color: Colors.grey[700],
//                       ),
//                       const SizedBox(
//                         width: 6.0,
//                       ),
//                       SizedBox(
//                         width: size.width * 0.24,
//                         child: subTitleTextWidget(
//                           maxLines: 1,
//                           overFlow: TextOverflow.ellipsis,
//                           txt: "Section ${index + 1}",
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   print("download Section ${index + 1}");
//                 },
//                 child: const Icon(
//                   Icons.save_alt_outlined,
//                 ),
//               ),
//             ],
//           ),
//           ),
//           itemCount: 25,
//           //padding: const EdgeInsets.all(50),
//         ),
//       ),
//     );
//   }
// }
