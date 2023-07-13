// import 'package:example_widget_testing/core/theme/colors.dart';
// import 'package:flutter/material.dart';

// class SearchListPage extends StatefulWidget {
//   const SearchListPage({super.key});

//   @override
//   SearchListPageState createState() => SearchListPageState();
// }

// class SearchListPageState extends State<SearchListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return getBody();
//   }

//   Widget getBody() {
//     var size = MediaQuery.of(context).size;
//     return ListView(
//       children: <Widget>[
//         Container(
//           margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
//           width: size.width - 30,
//           height: 45,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: textFieldBackground),
//           child: TextField(
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: white.withOpacity(0.3),
//               ),
//             ),
//             style: TextStyle(color: white.withOpacity(0.3)),
//             cursorColor: white.withOpacity(0.3),
//           ),
//         ),
//       ],
//     );
//   }
// }
