import 'package:flutter/material.dart';

class NotifyWidget extends StatelessWidget {
  final controller;
  final sizeInfo;

  const NotifyWidget({Key? key, required this.controller, required this.sizeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.blue.shade500,
              size: 30,
            ),
            onPressed: () {},
          ),
          Positioned(
            top: 5.0,
            right: 0.0,
            child: Container(
              //alignment: Alignment.topRight,
              //margin: EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red, border: Border.all(color: Colors.white, width: 1)),
                child: Padding(
                  padding: EdgeInsets.all(2.5),
                  child: Center(
                    child: Text(
                      '${0}',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
