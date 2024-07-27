import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/app/data/modules/add_book_module/addbookcontroller.dart';
import 'package:inventory/app/data/modules/show-book-details-module/showbook-controller.dart';
import 'package:inventory/app/models/bookmodel.dart';

class BookDetailsPage extends GetWidget<ShowBookController> {
  const BookDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ShowBookController controller = Get.put(ShowBookController());
    final AddBookController addbookcontroller = Get.put(AddBookController());

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Book Details")),
        leading: InkWell(
            onTap: () => Get.back(), child: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: FutureBuilder<List<BookModel>>(
        future: controller.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Details For Shown"),
            );
          }
          List<BookModel> data = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        Text(
                          data[index].title.toString(),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: Get.height / 3,
                          width: Get.width / 2,
                          child: data[index].image!.startsWith("/data")
                              ? Image.file(File(data[index].image.toString()))
                              : Image.network(data[index].image.toString()),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Id: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(snapshot.data![index].id.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Author: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(data[index].author.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Genre: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(data[index].genre.toString()),
                              ],
                            ),
                            Text(data[index].description.toString()),
                            Row(
                              children: [
                                const Text(
                                  "Available Stock: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(data[index].availableStock.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Total Stock: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(data[index].totalStock.toString()),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  addbookcontroller.titlecontroller.text =
                                      data[index].title!;
                                  addbookcontroller.authorcontroller.text =
                                      data[index].author!;
                                  addbookcontroller.genrecontroller.text =
                                      data[index].genre!;
                                  addbookcontroller.descriptioncontroller.text =
                                      data[index].description!;
                                  addbookcontroller.availablestockcontroller
                                      .text = data[index].availableStock!;
                                  addbookcontroller.totalstockcontroller.text =
                                      data[index].totalStock!;
                                  addbookcontroller.idcontroller.text =
                                      data[index].id!;
                                  addbookcontroller.imagePath.value =
                                      data[index].image!;
                                  Get.defaultDialog(
                                    title: "Update Book",
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller:
                                              addbookcontroller.titlecontroller,
                                          decoration: const InputDecoration(
                                              labelText: "Title"),
                                        ),
                                        TextField(
                                          controller: addbookcontroller
                                              .authorcontroller,
                                          decoration: const InputDecoration(
                                              labelText: "Author"),
                                        ),
                                        TextField(
                                          controller:
                                              addbookcontroller.genrecontroller,
                                          decoration: const InputDecoration(
                                              labelText: "Genre"),
                                        ),
                                        TextField(
                                          controller: addbookcontroller
                                              .descriptioncontroller,
                                          decoration: const InputDecoration(
                                              labelText: "Description"),
                                        ),
                                        TextField(
                                          controller: addbookcontroller
                                              .availablestockcontroller,
                                          decoration: const InputDecoration(
                                              labelText: "Available Stock"),
                                        ),
                                        TextField(
                                          controller: addbookcontroller
                                              .totalstockcontroller,
                                          decoration: const InputDecoration(
                                              labelText: "Total Stock"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            addbookcontroller.openImagePicker();
                                          },
                                          child: const Text("Pick Image"),
                                        ),
                                      ],
                                    ),
                                    textConfirm: "Update",
                                    onConfirm: () {
                                      addbookcontroller
                                          .updateUser(data[index].id!);
                                      Get.back();
                                    },
                                    textCancel: "Cancel",
                                  );
                                },
                                child: const Text("Update")),
                            TextButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "Delete Book",
                                    content: const Text(
                                        "Are you sure you want to delete this book?"),
                                    textConfirm: "Delete",
                                    onConfirm: () {
                                      addbookcontroller
                                          .deleteUser(data[index].id!);
                                      controller.fetchData();
                                      Get.back();
                                    },
                                    textCancel: "Cancel",
                                  );
                                  Get.to(const BookDetailsPage());
                                },
                                child: const Text("Delete")),
                            IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () async {
                                await controller.generateExcel(data);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          );
        },
      )),
    );
  }
}
