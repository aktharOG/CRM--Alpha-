import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class BudgetTile extends StatelessWidget {
  final String name,amount,icon;
  const BudgetTile({super.key,required this.amount,required this.icon,required this.name});

  @override
  Widget build(BuildContext context) {
    return   Row(
            children: [
               Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  color: const Color(0xfff8f9ff),
                                  
                                  borderRadius: BorderRadius.circular(30)),
                              child: SvgIcon(path: icon)
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingText(name: name,color: Colors.grey,),
                                const SizedBox(height: 5,),
                                HeadingText(name: amount,fontweight: FontWeight.bold,)
                              ],
                            )
            ],
          );
  }
}