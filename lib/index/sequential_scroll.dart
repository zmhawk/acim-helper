// import 'package:acim_helper/index/text.dart';
// import 'package:acim_helper/models/data.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SequentialScroll extends StatefulWidget {
//   const SequentialScroll({Key? key, required this.dataIndex}) : super(key: key);

//   final int dataIndex;

//   @override
//   _SequentialScrollState createState() => _SequentialScrollState();
// }

// class _SequentialScrollState extends State<SequentialScroll> {
//   final PageController controller = PageController();
//   List<int> history = [];

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, DataModel data, child) {
//       if (data.isEmpty) {
//         return const Scaffold(
//           body: Center(
//             child: Text('Loading...'),
//           ),
//         );
//       }
//       if (history.isEmpty) {
//         // 从 0 到 data.getLength 的数组
//         history = List<int>.generate(data.getLength(), (index) => index);
//       }
//       return PageView.custom(
//         controller: controller,
//         scrollDirection: Axis.horizontal,
//         childrenDelegate: SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             return TextView(text: data.getText(index));
//           },
//           childCount: history.length,
//         ),
//       );
//     });
//   }
// }
