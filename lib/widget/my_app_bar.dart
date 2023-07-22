import 'package:demo_new/constant/my_colors.dart';
import 'package:flutter/material.dart';

class MyAppBars {
  static PreferredSizeWidget appBarNormal(
    BuildContext context, {
    String title = 'title',
  }) {
    return AppBar(
      leadingWidth: 0,
      leading: Container(),
      title: Transform.translate(
        offset: const Offset(-15, 0),
        child: Row(
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.masks,                color: Colors.white,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: MyColors.primaryColor,
    );
  }
}
