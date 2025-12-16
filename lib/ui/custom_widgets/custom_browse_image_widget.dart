import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/image_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/b_camera_picker.dart';
import '../../utils/browse_image_controller.dart';
import '../../utils/common_code.dart';
import '../../utils/log.dart';
import 'custom_dialogs.dart';
import 'custom_progress_dialog.dart';
import 'full_image_view_screen.dart';
import 'general_button.dart';

class CustomBrowseImageWidget extends StatelessWidget {
  final BrowseImageController controller;
  final double paddingHorizontal;
  final double paddingVertical;
  final bool readOnly;
  final bool withBrows;
  final bool askLocation;
  final String writeTextOnImage;
  final bool withText;
  final bool cropImage;
  final Function? helper;

  const CustomBrowseImageWidget(
      {super.key,
        required this.controller,
        this.paddingHorizontal = 4,
        this.readOnly = false,
        this.withBrows = false,
        this.askLocation = false,
        this.paddingVertical = 10,
        this.writeTextOnImage = '',
        this.withText = false,
        this.cropImage = false,
        this.helper});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(text: controller.title, style: TextStyle(color: kTextColor),
                children: controller.mandatory ? [const TextSpan(text: '*', style: TextStyle(color: kRequiredRedColor, fontWeight: FontWeight.bold))] : null,
              )),
          Obx(()=> Visibility(
            visible: controller.urls.length != controller.maxLength && !readOnly,
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: GeneralButton(
                    // margin: 0,
                    radius: 6,
                    fontSize: 16,
                    text: withBrows ? 'Browse' : "Capture",
                    color: kGreyColor,
                    secondColor: kGreyColor,
                    onPressed:() => _onBrowseButtonPressed(withBrows ? ImageSource.gallery :ImageSource.camera),
                  ),
                ),
                const SizedBox(width: 8),
                withBrows ? ElevatedButton(
                  onPressed:() =>_onBrowseButtonPressed(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    backgroundColor: kPrimaryLightColor,
                    foregroundColor: kWhiteColor,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: kWhiteColor,
                  ),
                )
                    : SizedBox(),
              ],
            ),
          ),
          ),
          const SizedBox(height: 1),
          Obx(() => controller.urls.isNotEmpty
              ? SizedBox(
              height: (Get.width / 5) + 24,
              child: ListView.builder(
                itemCount: controller.urls.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {_onImageClicked(controller.urls[index]);},
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 12, right: 11, left: 1),
                        width: Get.width / 5,
                        height: Get.width / 5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: _buildImageWidget(controller.urls[index]),
                        ),
                      ),
                      Visibility(
                        visible: !readOnly,
                        child: Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              _removedImage(controller.urls[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kTextHintColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: const Icon(
                                Icons.clear,
                                color: kWhiteColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
              : const SizedBox()),
          if (controller.hint != null)
            Text(
              controller.hint!,
              style: const TextStyle(color: kGreyColor, fontSize: 12),
            ),
          Obx(() => Text(controller.errorMessage.value,
              style: const TextStyle(color: kRequiredRedColor, fontSize: 12))),
        ],
      ),
    );
  }

  Future<void> _removedImage(ImageModel imageModel) async {
    CustomDialogs().showAwesomeConfirmationDialog('Are you sure want to ${imageModel.path.isURL ? "delete" : "remove"} this image?', onOkBtnPressed: () async {
      if(!controller.deletedUrls.any((element) => element.id == imageModel.id)) {
        controller.deletedUrls.add(imageModel);
      }

      controller.urls.remove(imageModel);
    });
    controller.urls.refresh();
    controller.validate();
  }

  Future<void> _onBrowseButtonPressed(ImageSource source) async {
    try {
      if(controller.maxLength==controller.urls.length){
        CommonCode().showToast(message: 'Max ${controller.maxLength} Attachment${controller.maxLength>1?'s are':'is'} allowed!');
        return;
      }
      String uri = '';
      final picker = ImagePicker();
      if(source == ImageSource.camera) {
        // XFile? pickedImageFile = await picker.pickImage(source: source);
        XFile? pickedImageFile;
        await availableCameras().then((value) async{
          if(value.isNotEmpty) {
            pickedImageFile= await Get.to(()=>  BCameraPicker(cameras: value));
          }
        });
        if (pickedImageFile != null) {
          uri = pickedImageFile!.path;
        }
        File? compressImage;
        if (uri.isNotEmpty) {
          compressImage = await CommonCode().compressImage(File(uri));
          if (compressImage.existsSync()) {
            final pd = ProgressDialog();
            pd.showDialog();

            Uint8List imageBytes = compressImage.readAsBytesSync();
            List<int> bytes = imageBytes;
            final direct = await getTemporaryDirectory();
            final file = File("${direct.path}/IMG-${DateTime.now().microsecondsSinceEpoch}${extension(compressImage.path)}");
            await file.writeAsBytes(Uint8List.fromList(bytes));
            pd.dismissDialog();
            var compressedImage = await CommonCode().compressImage(file, quality: 70);
            String base64String = base64Encode(compressedImage.readAsBytesSync());
            controller.urls.add(ImageModel(id: '', path: compressedImage.path, imageData: base64String, name: pickedImageFile!.name, mimeType: "image/${extension(compressImage.path).replaceAll(".", "")}", fileType: controller.title));

          }
        }
      }else{
        List<XFile> pickedImageFile = (await picker.pickMultiImage()).take(controller.maxLength-controller.urls.length).toList();
        for(var f in pickedImageFile) {
          uri = f.path;
          File? compressImage;
          if (uri.isNotEmpty) {
            compressImage = await CommonCode().compressImage(File(uri));
            if (compressImage.existsSync()) {
              String base64String = base64Encode(compressImage.readAsBytesSync());
              controller.urls.add(ImageModel(id: '', path: compressImage.path, imageData: base64String, name: f.name, mimeType: "image/${extension(compressImage.path).replaceAll(".", "")}",fileType: controller.title.toLowerCase()));
            }
          }
        }
      }
    } on Exception catch(e, st) {
      Log.debug("------------------------->${e.toString()}\n${st.toString()}",tag: "_onBrowseButtonPressed");
    }
    controller.validate();
  }

  void _onImageClicked(ImageModel imageModel) async{
    Get.to(()=>FullImageViewScreen(uri:imageModel.path , imageBytes: base64Decode(imageModel.imageData),));
  }

  Widget _buildImageWidget(ImageModel imageModel) {
    if (imageModel.imageData.isNotEmpty) {
      return Image.memory(
        base64Decode(imageModel.imageData),
        width: Get.width / 5,
        height: Get.width / 5,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text(
              'Error: 404',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      );
    } else if (imageModel.path.isURL && imageModel.path.startsWith('http')) {
      return Image.network(
        imageModel.path,
        width: Get.width / 5,
        height: Get.width / 5,
        fit: BoxFit.cover,
        loadingBuilder: (c, w, p)=> (p == null) ? w:  Center(child: Image.asset('assets/icons_new/loadingd.gif', width: 30, height: 30)),
        errorBuilder: (c,o, ct) => const Icon(Icons.broken_image, color: kGreyColor),
      );
    } else if (imageModel.path.isNotEmpty) {
      return Image.file(
        File(imageModel.path),
        width: Get.width / 5,
        height: Get.width / 5,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text(
              'Error: 404',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      );

    }
    return Container();
  }

  Widget buildImageContainer(int index) {
    return  Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
              top: 12, right: 11, left: 1),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: _buildImageWidget(controller.urls[index])
          ),
        ),
        Visibility(
          visible: !readOnly,
          child: Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _removedImage(controller.urls[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kTextHintColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(3),
                child: const Icon(
                  Icons.clear,
                  color: kWhiteColor,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
