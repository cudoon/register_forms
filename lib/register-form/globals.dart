



import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> showDialogg(
      String title, String subtitle, Function fct, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    // fct();
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }

  Future<void> authErrorHandle(String subtitle, BuildContext context) async {

    final snackBar = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red[600],
        content: Text(
          subtitle, style: TextStyle(
            fontSize: 18
        ),));
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);

    // showDialog(
    //     context: context,
    //     builder: (BuildContext ctx) {
    //       return AlertDialog(
    //         title: Row(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text('Error occured'),
    //             ),
    //           ],
    //         ),
    //         content: Text(subtitle),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text('Ok'))
    //         ],
    //       );
    //     });
  }
}
