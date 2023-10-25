// import 'package:crm_new/helper/animated_navigation.dart';
// import 'package:crm_new/src/home/screens/expense_list_screen.dart';
// import 'package:crm_new/src/home/widgets/dialogs/add_expense_dialog.dart';
// import 'package:crm_new/src/home/widgets/dialogs/image_pick_dialog.dart';
// import 'package:crm_new/src/home/widgets/expense_list_tile.dart';
// import 'package:crm_new/src/home/widgets/photo_list_tile.dart';
// import 'package:crm_new/theme/app_theme.dart';
// import 'package:crm_new/widgets/custom_checkbox.dart';
// import 'package:crm_new/widgets/custom_text.dart';
// import 'package:crm_new/widgets/svg_icon.dart';
// import 'package:flutter/material.dart';

// class ProjectStagesTileGrey extends StatelessWidget {
//   final String title;
//   final bool isExpanded;
//   final void Function(int, bool)? expansionCallback;
//   final bool value;
//   final void Function(bool?)? onChanged;
//   final String desc;
//   const ProjectStagesTileGrey(
//       {super.key,
//       required this.isExpanded,
//       required this.expansionCallback,
//       required this.onChanged,
//       required this.value,
//       required this.title,
//       required this.desc
//       });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: isExpanded ? Colors.amber : Colors.grey)),
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: ExpansionPanelList(
//           expandIconColor: isExpanded ? Colors.amber : Colors.grey,
//           elevation: 0,
//           expandedHeaderPadding: EdgeInsets.zero,
//           materialGapSize: 0,
//           expansionCallback: expansionCallback,
//           children: [
//             ExpansionPanel(
//                 backgroundColor: Colors.white,
//                 isExpanded: isExpanded,
//                 headerBuilder: (context, isExpanded) => Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               HeadingText(
//                                 name: title,
//                                 fontweight: FontWeight.bold,
//                                 color: Colors.grey,
//                               ),  
//                               CustomCheckBox(
//                                 status: "Pending",
//                                 onChanged: onChanged,
//                                 value: true,
//                                 color: Colors.grey,
                                
//                               )
//                             ],
//                           ),
//                           HeadingText(name: desc,color: Colors.grey,fontsize: 12,),
                         

//                         ],
//                       ),
//                     ),
//                 body: Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const HeadingText(
//                         name: "Structure of construction",
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       const Row(
//                         //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           HeadingText(
//                             name: "Start date: 01/06/2023",
//                             color: Colors.green,
//                             fontsize: 12,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             child: SvgIcon(path: "Line 10"),
//                           ),
//                           HeadingText(
//                             name: "End date: 26/06/2023",
//                             color: Color(0xffAA0000),
//                             fontsize: 12,
//                           ),
//                         ],
//                       ),
//                       const Divider(
//                         height: 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: (){
//                               Navigator.push(context, createRoute(const ExpenseListScreen()));
//                             },
//                             child: const HeadingText(
//                               name: "Expense List",
//                               fontweight: FontWeight.bold,
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) =>
//                                       const AddExpenseDialog());
//                             },
//                             child: Icon(
//                               Icons.add,
//                               color: appBlue,
//                               size: 25,
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       GestureDetector(
//                         onTap: (){Navigator.push(context, createRoute(const ExpenseListScreen()));},
                        
//                         child: const Row(
//                           children: [
//                             ExpenseListTile(
//                               amount: "₹50,000",
//                               title: "Salary",
//                               color: Color(0xff7CCDF2),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             ExpenseListTile(
//                               amount: "₹30,000",
//                               title: "Purchases",
//                               color: Color(0xffFAB03A),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             ExpenseListTile(
//                               amount: "₹20,000",
//                               title: "Rent",
//                               color: Color(0xff6E60FC),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const HeadingText(
//                             name: "Photos",
//                             fontweight: FontWeight.bold,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) =>
//                                       const ImagePickerDialog());
//                             },
//                             child: Icon(
//                               Icons.add,
//                               color: appBlue,
//                               size: 25,
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Row(
//                         children: [
//                           PhotoListTile(image: "assets/construction 1.png"),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           PhotoListTile(image: "assets/construction 2.png"),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           PhotoListTile(image: "assets/construction 3.png"),
//                           SizedBox(
//                             width: 5,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       )
//                     ],
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
