import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/src/home/provider/home_provider.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/src/home/widgets/ProjectStagesTile_PG.dart';
import 'package:crm_new/src/home/widgets/budget_tile.dart';
import 'package:crm_new/src/home/widgets/dialogs/add_expense_dialog.dart';
import 'package:crm_new/src/home/widgets/dialogs/add_request_dialog.dart';
import 'package:crm_new/src/home/widgets/dialogs/image_pick_dialog.dart';
import 'package:crm_new/src/home/widgets/floating_action_button/expandable_fab.dart';
import 'package:crm_new/src/notification/notification_screen.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final int projectID;

  const ProjectDetailsScreen({super.key, required this.projectID});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final projectPro = Provider.of<ProjectProvider>(context, listen: false);
      projectPro.projectDetailsByID(widget.projectID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePro = Provider.of<HomeProvider>(context);
    final projectPro = Provider.of<ProjectProvider>(context);
    return Scaffold(
      body: projectPro.isProjectDetailsLoading
          ? const LoadingIC()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //!appbar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              const HeadingText(
                                name: "Project Details",
                                fontweight: FontWeight.bold,
                              )
                            ],
                          ),
                        ),
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
                  ),

                  //! rest

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(baseUrl +
                                        projectPro.projectModel!.image),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                                child: HeadingText(
                              name: "${projectPro.projectModel?.name}",
                              fontsize: 18,
                              fontweight: FontWeight.bold,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          // width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffe3e1fe)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                  color: appBlue,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: HeadingText(
                                    name:
                                        "${projectPro.projectModel?.location}",
                                    color: appBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SvgIcon(path: "stickynote"),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    HeadingText(
                                        name:
                                            "Start date: ${projectPro.projectModel!.startDate}")
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    SvgIcon(
                                        path: "stickynote",
                                        color: Color(0xffAA0000),
                                        fixedColor: Color(0xffAA0000)),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    HeadingText(name: "Start date: 01/06/2023")
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 30,
                        ),
                        const HeadingText(
                          name: "Work Progress",
                          fontweight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 10,
                          value: projectPro.projectModel!.progress / 100,
                          color: const Color(0xff6E60FC),
                          backgroundColor: const Color(0xffe3e1fe),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            HeadingText(
                              name: "${projectPro.projectModel!.progress.toStringAsFixed(3)}%",
                              color: appBlue,
                              fontweight: FontWeight.bold,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const HeadingText(
                              name: "Work Completed",
                              color: Colors.grey,
                              fontsize: 12,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            //     CustomButton(
                            //      height: 35,
                            //      width: 80,
                            //      name: "View", onPressed: (){

                            // })
                          ],
                        ),
                        const Divider(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BudgetTile(
                                  name: "Total Expense",
                                  amount: projectPro.projectModel!.totalBudget,
                                  icon: "empty-wallet"),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 30,
                        ),
                        ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final stageData = projectPro.stagesList[index];

                              return ProjectStagesTilePG(
                                stagesModel: stageData,
                                title: stageData.name,
                                value: stageData.isActive,
                                onChanged: (value) {
                                  homePro.setCheckValue(stageData);
                                },
                                isExpanded: stageData.isExpanded,
                                expansionCallback: (p1) {
                                  homePro.onExpand(stageData);
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: projectPro.stagesList.length),
                        const SizedBox(
                          height: 20,
                        ),
                        const HeadingText(
                          name: "Description",
                          fontweight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        HeadingText(
                          name: projectPro.projectModel?.description ??
                              sampleeDscreption,
                          fontweight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: ExpandableFab(
        distance: 110,
        children: [
          ActionButton(
            name: "Add\n Request",
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddRequestDialog(),
              );
            },
            icon: const SvgIcon(
              path: "document-upload",
              color: Colors.white,
              isAlwaysWhite: true,
              height: 25,
            ),
            color: Colors.amber,
          ),
          ActionButton(
            name: "Add\n Image",
            onPressed: () => showDialog(
              context: context,
              builder: (context) =>
                  const ImagePickerDialog(projectID: 1, stageID: 1),
            ),
            icon: const SvgIcon(
              path: "gallery-add",
              color: Colors.white,
              isAlwaysWhite: true,
              height: 25,
            ),
            color: const Color(0xff31B9F8),
          ),
          ActionButton(
            name: "Add\n Expense",
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const AddExpenseDialog(
                catID: 1,
                stageID: 1,
              ),
            ),
            icon: const SvgIcon(
              path: "empty-wallet",
              color: Colors.white,
              isAlwaysWhite: true,
              height: 25,
            ),
            color: const Color(0xffAA0000),
          ),
        ],
      ),
    );
  }
}

const sampleeDscreption = """
The construction project aims to develop a state-of-the-art office complex,offering a contemporary and functional workspace for a corporate client. 
This prestigious development will be a landmark in the city, showcasing innovative architectural design 
and sustainable building practices.
""";
