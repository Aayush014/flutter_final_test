import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/utils/color.dart';
import 'package:flutter_final_test/view/controller/home_controller.dart';
import 'package:flutter_final_test/view/helper/db_services.dart';
import 'package:flutter_final_test/view/helper/firebase_stoarge_services.dart';
import 'package:flutter_final_test/view/modal/notes_modal.dart';
import 'package:flutter_final_test/view/screen/favorite/favorite_page.dart';
import 'package:get/get.dart';

import 'componects/dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notes',
                    style: TextStyle(
                      color: ternaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: ternaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: bgColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(FavoritePage(),
                                duration: Duration(milliseconds: 1000),
                                transition: Transition.rightToLeft);
                            homeController.favoriteNotes();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: ternaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              color: bgColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseStorageServices.firebaseStorageServices.getData(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/img/rafiki.png',
                          fit: BoxFit.cover,
                        ),
                        const Text('Create your first note !')
                      ],
                    );
                  }
                  List<NotesModal> notesList = snapshot.data!.docs
                      .map(
                        (e) => NotesModal(e.data() as Map),
                      )
                      .toList();

                  return ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              notesList[index].note,
                              style: const TextStyle(color: ternaryColor),
                            ),
                            subtitle: Text(
                              notesList[index].description,
                              style: const TextStyle(color: ternaryColor),
                            ),
                            trailing: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  DbService.dbService
                                      .insertData(notesList[index]);
                                },
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: ternaryColor,
                                )),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ternaryColor,
        onPressed: () {
          buildShowDialog(context, homeController);
        },
        child: const Icon(
          Icons.add,
          color: primaryColor,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
