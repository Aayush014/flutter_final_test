import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseStorageServices {
  static FirebaseStorageServices firebaseStorageServices = FirebaseStorageServices._();
  FirebaseStorageServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addNotes(Map<String, dynamic> notes) async {
    try {
      CollectionReference notesCollection = firestore.collection('notes');
      await notesCollection.add(notes);
      log('Notes added successfully');
    } catch (e) {
      log('Failed to add notes: ${e.toString()}');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData()
  {
    return firestore.collection('notes').snapshots();
  }
}