// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// mixin HOW<W extends StatefulWidget> on State<W> {
//   bool isLoading = false;
//   String loaderText = 'Loading..';

//   static Widget? _globalLoader;

//   @override
//   void initState() {
//     super.initState();
//   }
 
//   Widget? loader() {
//     return null;
//   }
 

//   Widget? _buildLoader() {
//     if (this.isLoading) {
//       return Container( 
//         child: Flex(
//           direction: Axis.vertical,
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: loader(),
//             )
//           ],
//         ),
//       );
//     } else {
//       return null;
//     }
//   }

//   Widget buildH(BuildContext context);

//   @override
//   Widget build(BuildContext context) {
//     return buildH(context);
//   }
// }
