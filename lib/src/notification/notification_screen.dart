import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/src/notification/providers/notification_provider.dart';
import 'package:crm_new/widgets/custom_appbar.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  final bool fromNoti;
  const NotificationScreen({super.key, this.fromNoti = false});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notificationPro =
          Provider.of<NotificationProvider>(context, listen: false);
      notificationPro.onFetchProjectList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notePro = Provider.of<NotificationProvider>(context);
    return Scaffold(
      body: notePro.isNotificationFetching
          ? const LoadingIC()
          : notePro.notificationList.isEmpty
              ? const Center(
                  child: HeadingText(name: "No Notificaion"),
                )
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        CustomAppBar(
                          isFromNoti: widget.fromNoti,
                          hidenoti: true,
                          title: "Notifications",
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data = notePro.notificationList[index];
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SvgIcon(
                                                  path: "document-upload"),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              HeadingText(
                                                name: data.title,
                                                fontsize: 14,
                                                fontweight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          HeadingText(
                                            name: data.message,
                                            maxlines: 1000,
                                            fontsize: 13,
                                            fontweight: FontWeight.w500,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                      bottom: 16,
                                      right: 25,
                                      child: HeadingText(
                                        name: "Today",
                                        color: Colors.grey,
                                        fontsize: 12,
                                      ))
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: notePro.notificationList.length)
                      ],
                    ),
                  ),
                ),
    );
  }
}
