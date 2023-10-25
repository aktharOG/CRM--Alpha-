import 'package:crm_new/helper/animated_navigation.dart';
import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/src/home/provider/home_provider.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/src/home/widgets/assigned_project_item.dart';
import 'package:crm_new/src/notification/notification_screen.dart';
import 'package:crm_new/src/profile/screens/profile_screen.dart';
import 'package:crm_new/src/search/screens/search_screen.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final homePro = Provider.of<HomeProvider>(context, listen: false);
      final projectPro = Provider.of<ProjectProvider>(context, listen: false);
      homePro.onFetchProfileAPI();
      projectPro.onFetchProjectList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePro = Provider.of<HomeProvider>(context);
    final projectPro = Provider.of<ProjectProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        projectPro.onFetchProjectList();
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff8f9ff),
        body: homePro.isProfileLoading
            ? const LoadingIC()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! appbar
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 115,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              createRoute(
                                                  const ProfileScreen()));
                                          // push(context,const ProfileScreen());
                                        },
                                        child: SizedBox(
                                          child: Row(
                                            children: [
                                              if (homePro.profileModel != null)
                                                CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      baseUrl +
                                                          homePro.profileModel!
                                                              .image),
                                                )
                                              else
                                                const CircleAvatar(
                                                  radius: 25,
                                                ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: HeadingText(
                                                    name: homePro.profileModel
                                                            ?.name ??
                                                        "Ram Prasad"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            createRoute(
                                                const NotificationScreen()));
                                        //     push(context, const NotificationScreen());
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
                                            borderRadius:
                                                BorderRadius.circular(30)),
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
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //! search
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: "search",
                              child: CurstomTextfield(
                                onTap: () =>
                                    push(context, const SearchScreen()),
                                readOnly: true,
                                label: "Search",
                                hint: "Search",
                                controller: homePro.searchController,
                                borderRadius: BorderRadius.circular(50),
                                iconPath: "search-normal",
                              ),
                            ),

                            SizedBox(
                              height: 10.h,
                            ),
                            //! body

                            const HeadingText(
                              name: "Assigned Projects",
                              fontsize: 18,
                              fontweight: FontWeight.w500,
                            ),

                            //! assigned prject item
                            SizedBox(
                              height: 10.h,
                            ),
                            projectPro.iSProjectFetching
                                ? const LoadingIC()
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: projectPro.projectList.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: AssignedProjectItem(
                                          projectModel:
                                              projectPro.projectList[index]),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
