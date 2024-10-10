import 'package:flutter/material.dart';
import 'package:flutter_final_test/view/helper/db_services.dart';
import 'package:flutter_final_test/view/modal/notes_modal.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtDiscripation = TextEditingController();

  var key = GlobalKey<FormState>();
  RxList<NotesModal> modalList = <NotesModal>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DbService.dbService.database;
    favoriteNotes();
  }

  Future<void> favoriteNotes()
  async {
    List data = await DbService.dbService.selectedNotes();

    modalList.value = data.map((e)=>NotesModal(e)).toList();
    modalList.refresh();
  }

  void removeTheFavoriteNotes(int index)
  {
    modalList.clear();
    DbService.dbService.removeNotes(modalList[index].note);
    favoriteNotes();
  }
}