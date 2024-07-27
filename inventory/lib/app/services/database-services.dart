// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/app/models/bookmodel.dart';

const String collection = "inventory";

class DatabaseService {
  final firestore = FirebaseFirestore.instance;
  late final CollectionReference<BookModel> inventoryRef;
 DatabaseService() {
    inventoryRef = firestore.collection(collection).withConverter<BookModel>(
      fromFirestore: (snapshots, _) => BookModel.fromJson(snapshots.data()!, snapshots.id),
      toFirestore: (inv, _) => inv.toJson(),
    );
  }}
