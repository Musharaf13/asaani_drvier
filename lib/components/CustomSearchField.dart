// import 'package:asaani/constant.dart';
// import 'package:flutter/material.dart';

// class CustomSearchField extends StatelessWidget {
//   const CustomSearchField({
//     Key key,
//     @required this.pickupController,
//     @required this.icon,
//     @required this.hintText,
//     this.valueFunction,
//   }) : super(key: key);

//   final TextEditingController pickupController;
//   final IconData icon;
//   final String hintText;
//   final Function valueFunction;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextField(
//         controller: pickupController,
//         decoration: InputDecoration(
//           filled: true,
//           isDense: true,
//           contentPadding: EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 10,
//           ),
//           prefixIcon: Icon(
//             icon,
//           ),
//           fillColor: secondaryColor,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(
//               color: secondaryColor,
//               width: 2,
//             ),
//           ),
//           hintText: hintText,
//           labelStyle: TextStyle(color: secondaryColor),
//         ),
//         onChanged: valueFunction,
//       ),
//     );
//   }
// }
