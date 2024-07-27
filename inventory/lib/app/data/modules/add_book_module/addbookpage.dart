import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/app/data/modules/add_book_module/addbookcontroller.dart';
import 'package:inventory/app/data/widgets/custombutton.dart';
import 'package:inventory/app/data/widgets/customtextfield.dart';

class AddBookPage extends GetWidget<AddBookController> {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookController controller = Get.put(AddBookController());

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add Book Details")),
        leading: InkWell(
            onTap: () => Get.back(), child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() => ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: "Title",
                  hintText: "Title",
                  controller: controller.titlecontroller,
                ),
                CustomTextFormField(
                  labelText: "Author",
                  hintText: "Author",
                  controller: controller.authorcontroller,
                ),
                CustomTextFormField(
                  labelText: "Genre",
                  hintText: "Genre",
                  controller: controller.genrecontroller,
                ),
                CustomTextFormField(
                  labelText: "Description",
                  hintText: "Description",
                  controller: controller.descriptioncontroller,
                ),
                CustomTextFormField(
                  labelText: "Available Stock",
                  hintText: "Available Stock",
                  keyboardType: TextInputType.number,
                  controller: controller.availablestockcontroller,
                ),
                CustomTextFormField(
                  labelText: "Total Stock",
                  hintText: "Total Stock",
                  keyboardType: TextInputType.number,
                  controller: controller.totalstockcontroller,
                ),
                GestureDetector(
                  onTap: () {
                    controller.openImagePicker();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Upload Image"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.cloud_upload_outlined)
                          ],
                        ),
                        SizedBox(
                            height: 100,
                            child: controller.imagePath.value.isNotEmpty
                                ? Image.file(File(controller.imagePath.value))
                                : const SizedBox())
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Add",
                  onPressed: () {
                    controller.addUser();
                  },
                )
              ],
            )),
      ),
    );
  }
}
