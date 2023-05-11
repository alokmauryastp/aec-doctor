// import 'dart:io';
//
// import 'package:aec_medical/utils/colors.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class MedicalRecordsAddController extends GetxController {
//   var selectedImagePath = ''.obs;
//   var selectedImageSize = ''.obs;
//
//   void getImage(ImageSource imageSource) async {
//     final pickedFile = await ImagePicker().getImage(source: imageSource);
//     if (pickedFile != null) {
//       selectedImagePath.value = pickedFile.path;
//       selectedImageSize.value =
//           ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
//                   .toStringAsFixed(2) +
//               "Mb";
//     } else {
//       Get.snackbar('Error', 'No image selected',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: AppColors.whitetextColor,
//           colorText: AppColors.errorColor);
//     }
//   }
// }
