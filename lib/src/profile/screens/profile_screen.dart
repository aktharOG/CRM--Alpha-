import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/src/home/provider/home_provider.dart';
import 'package:crm_new/src/notification/notification_screen.dart';
import 'package:crm_new/src/profile/widgets/profile_item_tile.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_button.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homePro = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! appbar

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              pop(context);
                            },
                            child: const Icon(Icons.arrow_back)),
                        const SizedBox(
                          width: 15,
                        ),
                        const HeadingText(name: "Profile")
                      ],
                    ),
                  ),
                  GestureDetector(
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
            ),

            //! body

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.grey,
                                blurRadius: 10)
                          ]),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: CachedNetworkImageProvider(
                            baseUrl + homePro.profileModel!.image),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Column(
                      children: [
                        ProfileItemTile(
                          title: "Name",
                          name: homePro.profileModel?.name ?? '',
                        ),
                        ProfileItemTile(
                          title: "Employer Id",
                          name: homePro.profileModel?.employeeId ?? '',
                        ),
                        ProfileItemTile(
                          title: "Designation",
                          name: homePro.profileModel?.designation ?? '',
                        ),
                        ProfileItemTile(
                          title: "Email",
                          name: homePro.profileModel?.email ?? '',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomButton(
            name: "Logout",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:
                      const HeadingText(name: "Are you sure want to logout ? "),
                  content:homePro.isLogout
                              ? const SizedBox(height: 50, child: LoadingIC())
                              : Row(
                    children: [
                      CustomButton(
                        name: "Cancel",
                        onPressed: () {
                          pop(context);
                        },
                        color: const Color(0xffEEECFF),
                        textColor: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                       CustomButton(
                              name: "Submit",
                              onPressed: () {
                                homePro.onLogoutAPI(context);
                              })
                    ],
                  ),
                ),
              );
            },
            iconPath: "logout",
          ),
        ),
      ),
    );
  }
}
