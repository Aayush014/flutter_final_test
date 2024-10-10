import 'package:flutter/material.dart';
import 'package:flutter_final_test/view/screen/home/componects/textfield_dialog.dart';

import '../../../../utils/color.dart';
import '../../../controller/home_controller.dart';
import '../../../helper/firebase_stoarge_services.dart';

Future<dynamic> buildShowDialog(BuildContext context, HomeController homeController) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: secondaryColor,
        title: const Text('Add to Notes'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                if(homeController.key.currentState!.validate())
                  {
                    Map<String, dynamic> notes = {
                      'notes': homeController.txtNotes.text,
                      'description': homeController.txtDiscripation.text,
                      'like': 0,
                    };
                    FirebaseStorageServices.firebaseStorageServices
                        .addNotes(notes);

                    homeController.txtNotes.clear();
                    homeController.txtDiscripation.clear();
                    Navigator.pop(context);
                  }
              },
              child: const Text('Save')),
        ],
        content: SizedBox(
          height: 100,
          child: Form(
            key: homeController.key,
            child: Column(
              children: [
                TextFieldDialog(
                  textEditingController: homeController.txtNotes,
                  hintText: 'notes',
                ),
                TextFieldDialog(
                  textEditingController: homeController.txtDiscripation,
                  hintText: 'discription',
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
