import 'package:flutter/material.dart';
import 'dart:ui';
// class Book extends StatelessWidget{
//   final String title;
//   final String summary;
//
//   Book(this.title, this.summary);
//
//   String getTitle() {
//     return title;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Book Widget Example'),
//         ),
//         body: Center(
//           child: Container(
//             width: 50,
//             height: 150,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   left: 0,
//                   top: 0,
//                   bottom: 0,
//                   child: Container(
//                     width: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         bottomLeft: Radius.circular(10),
//                         topRight: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                       ),
//                     ),
//                     child: Center(
//                       child: RotatedBox(
//                         quarterTurns: 3,
//                         child: Text(
//                           this.title,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class Book extends StatelessWidget {
  String title;
  String summary;
  String author;
  double y;
  double x;

  Book(this.title, this.author, this.summary, this.x, this.y);

  void set(double xOffset, double yOffset) {
    x = xOffset;
    y = yOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: y,
          left: x,
          child: Container(
            width: 50,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: -3,
                child: Text(
                  this.title,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Stack(
          children: [
            Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'massive yap', 10, 100),
            Book('Game of Thrones', 'George RR Martin', 'massive yap', 70, 100),
            Book('IDK anymore', 'J. K. Rowling', 'massive yap', 130, 100),
            Book('Random Book', 'J. K. Rowling', 'massive yap', 190, 100),
          ],
        ),
      ),
    ),
  ));
}
