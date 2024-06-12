import 'package:flutter/material.dart';
import '../widgets/sub_title_text_widget.dart';
import '../widgets/title_text_widget.dart';
import 'assets_manager.dart';

class MyAppMethods {
  static Future<void> showErrorORWarningDialog({
    required BuildContext context,
    required String subTitle,
    required Function fct,
    bool isError = true,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetsManager.warning,
                    height: 60.0,
                    width: 60.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  subTitleTextWidget(
                    txt: subTitle,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !isError,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: subTitleTextWidget(
                            txt: 'Cancel',
                            color: Colors.green,
                          ),
                        ),
                      ),
                      if (!isError)
                        const SizedBox(
                          width: 40.0,
                        ),
                      TextButton(
                        onPressed: () {
                          fct();
                          Navigator.pop(context);
                        },
                        child: subTitleTextWidget(
                          txt: 'Ok',
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ]),
          );
        });
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: titleTextWidget(txt: 'Choose option'),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFCT();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.camera_alt_rounded),
                    label: const Text("Camera"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      galleryFCT();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.image_outlined),
                    label: const Text("Gallery"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFCT();
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text("Remove"),
                  ),
                ],
              ),
            ),
          );
        });
  }

}
