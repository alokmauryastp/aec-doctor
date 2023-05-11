import 'dart:convert';
import 'dart:io';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class UploadMedicalRegistrationController extends GetxController{

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  late File file;
  void getImage(ImageSource imageSource,BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile!=null) {
      selectedImagePath.value = pickedFile.path;
      file = new File(pickedFile.path);
      selectedImageSize.value = ((File(selectedImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2)+"Mb";
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);

      await Provider.of<ProfileRepo>(context,listen: false).uploadMedicalRegistrationApi(base64Image);

    }else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

