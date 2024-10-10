import 'package:flutter/material.dart';
import 'package:flutter_final_test/view/controller/home_controller.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ternaryColor,),
        title: Text(
          'Favorite Notes',
          style: TextStyle(
            color: ternaryColor,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () => (homeController.modalList.isEmpty)?Center(
          child: Text(
            'You select Note is Empty',
            style: TextStyle(
              color: ternaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ):ListView.builder(
          itemCount: homeController.modalList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    homeController.modalList[index].note,
                    style: const TextStyle(color: ternaryColor),
                  ),
                  subtitle: Text(
                    homeController.modalList[index].description,
                    style: const TextStyle(color: ternaryColor),
                  ),
                  trailing: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        homeController.removeTheFavoriteNotes(index);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: ternaryColor,
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
