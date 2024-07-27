// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/app/data/modules/add_book_module/addbookpage.dart';
import 'package:inventory/app/data/modules/show-book-details-module/showbook-controller.dart';
import 'package:inventory/app/data/modules/show-book-details-module/showbookpage.dart';
import 'package:inventory/app/data/widgets/customcontainer.dart';

class HomePage extends GetWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ShowBookController bookcontroller = Get.put(ShowBookController());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(
            text: "Add Book",
            width: Get.width / 2,
            onTap: () => Get.to(() => const AddBookPage()),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomContainer(
            text: "Show Book Details",
            width: Get.width / 2,
            onTap: () {
              bookcontroller.fetchData();
              Get.to(() => const BookDetailsPage());
            },
          ),
        ],
      ),
    );
  }
}
