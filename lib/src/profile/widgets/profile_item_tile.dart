import 'package:crm_new/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileItemTile extends StatelessWidget {
  final String title,name;
  const ProfileItemTile({super.key,required this.name,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 10,top: 10,left: 10,right: 10),
      child: Row(
       
        children: [
          Expanded(
              child: HeadingText(
            name: title,
            color: Colors.grey,
          )),
          const HeadingText(
            name: ":",
            color: Colors.grey,
          ),
          const SizedBox(width: 10,),
          Expanded(flex: 2, child: HeadingText(name: name))
        ],
      ),
    );
  }
}
