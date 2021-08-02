import 'package:flutter/material.dart';
import 'package:tempapp/commons/constants/resource.dart';

class ConfirmDialog {
  static void showButtonPress(
      BuildContext context, bool dismissible, String title, String content, String buttonText, VoidCallback onPressed) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        return Dialog(
          child: Container(
            color: Colors.blue,
            height: 200,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      child: Icon(Icons.notifications_active, color: Colors.white, size: 35),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SizedBox.expand(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(content, style: Theme.of(context).textTheme.subtitle1),
                            SizedBox(height: 10.0),
                            ElevatedButton(
                                child: Text(buttonText, style: TextStyle(color: Colors.white)), onPressed: onPressed)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
