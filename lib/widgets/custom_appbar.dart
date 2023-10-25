import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/src/home/screens/home_screen.dart';
import 'package:crm_new/src/notification/notification_screen.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final bool isFromNoti;
  final bool hidenoti;
  final String title;
  const CustomAppBar(
      {super.key,
      this.hidenoti = false,
      required this.title,
      this.isFromNoti = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      if (isFromNoti) {
                        pushAndRemoveUntil(context, const HomeScreen());
                      } else {
                        pop(context);
                      }
                    },
                    child: const Icon(Icons.arrow_back)),
                const SizedBox(
                  width: 15,
                ),
                HeadingText(
                  name: title,
                  fontweight: FontWeight.bold,
                )
              ],
            ),
          ),
          if (!hidenoti)
            InkWell(
              onTap: () {
                push(context, const NotificationScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(3, 1),
                          blurRadius: 9,
                          color: Colors.grey.shade300)
                    ],
                    borderRadius: BorderRadius.circular(30)),
                child: Badge.count(
                  count: 9,
                  child: Icon(
                    Icons.notifications,
                    color: appBlue,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
