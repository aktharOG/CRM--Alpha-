import 'package:crm_new/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseListTile extends StatelessWidget {
  final String title,amount;
  final Color color;
  const ExpenseListTile({super.key,required this.amount,required this.title,required this.color});

  @override
  Widget build(BuildContext context) {
    return  Row(
                                      children: [
                                        Container(
                                          width: 93.w,
                                          padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: color
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  HeadingText(name: amount,color: Colors.white,fontsize: 14,),
                                                  const Icon(Icons.arrow_forward_ios,size: 20,color: Colors.white,)
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              HeadingText(name: title,color: Colors.white,fontsize: 14,)
                                            ],
                                          ),
                                        )
                                      ],
                                     );
  }
}