// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:http/http.dart' as http;
// import './../services/services.dart' as commentService;
//
//
// class ProjectDashBoard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//    commentService.getCommentFromApi();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: HexColor('#4F5AC9'),
//         title: const Text('Contacts'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
//         child: ListView.builder(
//             itemBuilder: (BuildContext buildContext, int index) {
//               return ListTile(
//                 leading: Text('1'),
//                 title: Text('Hello ${index}'),
//                 isThreeLine: true,
//                 subtitle: Text('This is frist Line'),
//               );
//             },
//           itemCount: 5,
//         )
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Business',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'School',
//           ),
//         ],
//         // currentIndex: _selectedIndex,
//         // selectedItemColor: Colors.amber[800],
//         // onTap: _onItemTapped,
//       ),
//     );
//   }
// }
