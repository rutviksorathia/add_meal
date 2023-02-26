import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_app/good_job/good_job_view.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? profileImage;
  bool? isLoading = false;

  Future getImage(ImageSource source) async {
    try {
      setState(() {
        isLoading = true;
      });
      var image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      File file = File(image.path);

      setState(() {
        profileImage = file;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.shade400,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [15, 10],
                          strokeWidth: 0.5,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black26,
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 41)),
                                  const Center(
                                    child: Text(
                                      'Click your meal',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
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
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.grey.shade400,
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
                                  SizedBox(
                                    height: 50,
                                    width: 252,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            getImage(ImageSource.camera);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.green,
                                            ),
                                            child: const Icon(
                                              Icons.camera,
                                              size: 21,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            getImage(ImageSource.gallery);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.green,
                                            ),
                                            child: const Icon(
                                              Icons.image,
                                              size: 21,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (profileImage != null)
                        const Center(
                          child: Text(
                            'Will you eat this?',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      if (profileImage != null)
                        GestureDetector(
                          onTap: () => Get.to(() => const GoodJobView()),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top + 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Colors.green.shade400,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.check,
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
            ],
          ),
        ),
      ),
    );
  }
}
