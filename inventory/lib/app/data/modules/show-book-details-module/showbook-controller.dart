// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:inventory/app/models/bookmodel.dart';
import 'package:inventory/app/services/database-services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShowBookController extends GetxController {
  final DatabaseService databaseservices = DatabaseService();
  CollectionReference bookData =
      FirebaseFirestore.instance.collection('inventory');
  final isLoading = false.obs;
  final bookmodel = BookModel().obs;
  Future<List<BookModel>> fetchData() async {
    QuerySnapshot<BookModel> querySnapshot =
        await databaseservices.inventoryRef.get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data.id = doc.id;
      return data;
    }).toList();
  }

  Future<void> generateExcel(List<BookModel> books) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Books'];

    // Adding header
    sheetObject.appendRow([
      const TextCellValue("ID"),
      const TextCellValue("Title"),
      const TextCellValue("Author"),
      const TextCellValue("Genre"),
      const TextCellValue("Description"),
      const TextCellValue("Available Stock"),
      const TextCellValue("Total Stock"),
      const TextCellValue("Image Path")
    ]);

    // Adding data
    for (var book in books) {
      sheetObject.appendRow([
        TextCellValue(book.id.toString()),
        TextCellValue(book.title.toString()),
        TextCellValue(book.author.toString()),
        TextCellValue(book.genre.toString()),
        TextCellValue(book.description.toString()),
        TextCellValue(
            book.availableStock.toString()), // Convert to string if needed
        TextCellValue(
            book.totalStock.toString()), // Convert to string if needed
        TextCellValue(book.image.toString()),
      ]);
    }

    // Saving the file
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/Books.xlsx";
    File file = File(path);
    file.createSync(recursive: true);
    file.writeAsBytesSync(excel.encode()!);


    XFile xfile = XFile(path);
    await Share.shareXFiles([xfile],
        text: 'Here is the Excel file with the book data.');

  }
}
