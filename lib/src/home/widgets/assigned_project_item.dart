import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm_new/helper/animated_navigation.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/models/project_model.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/src/home/screens/project_details_screen.dart';
import 'package:crm_new/src/home/widgets/budget_tile.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_button.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class AssignedProjectItem extends StatelessWidget {
  final ProjectModel? projectModel;
  const AssignedProjectItem({super.key, this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(20),
      child: projectModel != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                baseUrl + projectModel!.image),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                        child: HeadingText(
                      name: projectModel!.name,
                      fontsize: 18,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const SvgIcon(path: "stickynote"),
                            const SizedBox(
                              width: 20,
                            ),
                            HeadingText(
                                name: "Start date: ${projectModel!.startDate}")
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SvgIcon(
                                path: "stickynote",
                                color: Color(0xffAA0000),
                                fixedColor: Color(0xffAA0000)),
                            const SizedBox(
                              width: 20,
                            ),
                            HeadingText(
                                name: "Start date: ${projectModel!.endDate}")
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                ),
                if (projectModel!.totalBudget.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BudgetTile(
                          name: "Total Expense",
                          amount: projectModel!.totalBudget,
                          icon: "empty-wallet"),
                      const Row(
                        children: [
                          HeadingText(
                            name: "Stage 3",
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.amber,
                          )
                        ],
                      )
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
                  value: projectModel!.progress / 100,
                  color: const Color(0xff6E60FC),
                  backgroundColor: const Color(0xffe3e1fe),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        HeadingText(
                          name: "${projectModel!.progress.toStringAsFixed(3)}%",
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
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                        height: 35,
                        width: 80,
                        name: "View",
                        onPressed: () {
                          
                          if(projectModel!=null){
                             push(
                            context,
                            ProjectDetailsScreen(
                              projectID: projectModel!.id,
                            ),
                          );
                          }
                         
                        })
                  ],
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage("assets/building.png")),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Flexible(
                        child: HeadingText(
                      name: "EcoScape Plaza: Sustainable Retail Hub",
                      fontsize: 18,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgIcon(path: "stickynote"),
                            SizedBox(
                              width: 20,
                            ),
                            HeadingText(name: "Start date: 01/06/2023")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BudgetTile(
                        name: "Total Expense",
                        amount: "10,00,000",
                        icon: "empty-wallet"),
                    Row(
                      children: [
                        HeadingText(
                          name: "Stage 3",
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.amber,
                        )
                      ],
                    )
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
                  value: 0.4,
                  color: const Color(0xff6E60FC),
                  backgroundColor: const Color(0xffe3e1fe),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        HeadingText(
                          name: "33.3%",
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
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                        height: 35,
                        width: 80,
                        name: "View",
                        onPressed: () {
                          Navigator.push(
                              context,
                              createRoute(ProjectDetailsScreen(
                                projectID: projectModel!.id,
                              )));
                        })
                  ],
                ),
               
              ],
            ),
    );
  }
}

// projectModel != null
//                       ? DecorationImage(
//                           image: CachedNetworkImageProvider(
//                               baseUrl + projectModel!.image),
//                           fit: BoxFit.cover)
//                       : 
