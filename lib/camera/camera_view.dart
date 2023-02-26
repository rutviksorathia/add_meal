import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    File? profileImage;

    Future<void> setImage(ImageSource source) async {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (croppedImage == null) return;

      File imageFile = File.fromUri(Uri.file(croppedImage.path));

      profileImage = imageFile;
    }

    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.grey.shade400,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.green.shade400,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_sharp,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [15, 5],
                strokeWidth: 0.5,
                color: Colors.black26,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.black26,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 41)),
                      GestureDetector(
                        // onTap: () {
                        //   model.handleProfileCameraOrGalleryButtonTap(
                        //       ImageSource.gallery);
                        // },
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amber,
                              ),
                              child: profileImage != null
                                  ? Image.file(
                                      profileImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Click your meal',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () => setImage(ImageSource.camera),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.green.shade400,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.camera_alt,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
              )
            ],
          ),
        ),
      ),
    );
  }
}
