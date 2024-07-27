import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/app/data/modules/show-book-details-module/showbook-controller.dart';

class AddBookController extends GetxController {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController authorcontroller = TextEditingController();
  TextEditingController genrecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController availablestockcontroller = TextEditingController();
  TextEditingController totalstockcontroller = TextEditingController();
  TextEditingController idcontroller = TextEditingController();

  final ShowBookController showbookcontroller = Get.put(ShowBookController());

  CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('inventory');
  late List data;
  Future<void> addUser() async {
    dataCollection.add({
      'title': titlecontroller.text,
      'author': authorcontroller.text,
      'genre': genrecontroller.text,
      'image': imagePath.value,
      'description': descriptioncontroller.text,
      'available-stock': availablestockcontroller.text,
      'total-stock': totalstockcontroller.text,
    });
    data = await showbookcontroller.fetchData();
    if (data.isNotEmpty) {
      Get.snackbar(
        '',
        'Book added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
    log(data.toString());
    titlecontroller.clear();
    authorcontroller.clear();
    genrecontroller.clear();
    descriptioncontroller.clear();
    availablestockcontroller.clear();
    totalstockcontroller.clear();
    idcontroller.clear();
    imagePath.value = "";
  }

  Future<void> updateUser(String docId) async {
    dataCollection.doc(docId).update({
      'title': titlecontroller.text,
      'author': authorcontroller.text,
      'genre': genrecontroller.text,
      'image': imagePath.value,
      'description': descriptioncontroller.text,
      'available-stock': availablestockcontroller.text,
      'total-stock': totalstockcontroller.text,
      'id': idcontroller.text
    });

    data = await showbookcontroller.fetchData();
    if (data.isNotEmpty) {
      Get.snackbar(
        '',
        'Book updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
    log(data.toString());
    titlecontroller.clear();
    authorcontroller.clear();
    genrecontroller.clear();
    descriptioncontroller.clear();
    availablestockcontroller.clear();
    totalstockcontroller.clear();
    idcontroller.clear();
    imagePath.value = "";
  }

  Future<void> deleteUser(String docId) async {
    await dataCollection.doc(docId).delete();
    data = await showbookcontroller.fetchData();
    if (data.isNotEmpty) {
      Get.snackbar(
        '',
        'Book deleted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
    log(data.toString());
  }

  void clearFields() {
    titlecontroller.clear();
    authorcontroller.clear();
    genrecontroller.clear();
    descriptioncontroller.clear();
    availablestockcontroller.clear();
    totalstockcontroller.clear();
    idcontroller.clear();
    imagePath.value = "";
  }

  final imagePath = "".obs;
  final _picker = ImagePicker();
  Future<void> openImagePicker() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
    }
  }
}
