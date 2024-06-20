import 'package:flutter/material.dart';

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
  final String title;
  final String summary;
  final String author;
  Book(this.title, this.author, this.summary);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
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
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: -3,
                    child: Text(
                      this.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Book('Harry Potter and the Order of the Phoenix',
            'J. K. Rowling', 'Now in his fifth year at Hogwarts, '
            'Harry (Daniel Radcliffe) learns that many in the '
            'wizarding community do not know the truth of his '
            'encounter with Lord Voldemort. Cornelius Fudge, '
            'minister of Magic, appoints his toady, Dolores '
            'Umbridge, as Defense Against the Dark Arts teacher'
            ', for he fears that professor Dumbledore will take'
            ' his job. But her teaching is deficient and her '
            'methods, cruel, so Harry prepares a group of '
            'students to defend the school against a rising '
            'tide of evil.'),
      ),
    ),
  ));
}
