import 'package:crm_new/helper/animated_navigation.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/models/stages_model.dart';
import 'package:crm_new/models/status_model.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/src/home/screens/expense_list_screen.dart';
import 'package:crm_new/src/home/screens/photo_gallery_screen.dart';
import 'package:crm_new/src/home/widgets/dialogs/add_expense_dialog.dart';
import 'package:crm_new/src/home/widgets/dialogs/image_pick_dialog.dart';
import 'package:crm_new/src/home/widgets/expense_list_tile.dart';
import 'package:crm_new/src/home/widgets/photo_list_tile.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_checkbox.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectStagesTilePG extends StatelessWidget {
  final StagesModel stagesModel;
  final String title;
  final bool isExpanded;
  final void Function(bool)? expansionCallback;
  final bool value;
  final void Function(bool?)? onChanged;

  const ProjectStagesTilePG(
      {super.key,
      required this.isExpanded,
      required this.expansionCallback,
      required this.onChanged,
      required this.value,
      required this.title,
      required this.stagesModel});

  @override
  Widget build(BuildContext context) {
    final projectPro = Provider.of<ProjectProvider>(context);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: !value ? Colors.amber : Colors.green)),
      child: ExpansionTileCard(
        duration: const Duration(milliseconds: 400),
        elevation: 0,
        expandedColor: Colors.white,
        onExpansionChanged: expansionCallback,
        trailing: SvgIcon(
            path: isExpanded
                ? value
                    ? "arrow-up"
                    : "arrow-up-amber"
                : !value
                    ? "arrow-down-amber"
                    : "arrow-down"),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: HeadingText(
                name: title,
                fontweight: FontWeight.bold,
                maxlines: 1,
              ),
            ),
            // CustomCheckBox(
            //   onChanged: onChanged,
            //   value: value,
            // ),
            Container(
              // padding: const EdgeInsets.only(left: 5,right: 5),
              // decoration: BoxDecoration(
              //   border: Border.all(),
              //   borderRadius: BorderRadius.circular(100)
              // ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: projectPro.changeStatus(stagesModel),
                  items: projectPro.dropdownItems,
                  onChanged: (value) {
                    projectPro.onChangedStatus(value, stagesModel);
                  },
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingText(
                  name: stagesModel.shortdescription,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // HeadingText(
                    //   name: "Start date: ${stagesModel.startDate}",
                    //   color: Colors.green,
                    //   fontsize: 12,
                    // ),
                    // HeadingText(
                    //   name: "End date: ${stagesModel.endDate}",
                    //   color: const Color(0xffAA0000),
                    //   fontsize: 12,
                    // ),
                  ],
                ),
                const Divider(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadingText(
                      name: "Expense List",
                      fontweight: FontWeight.bold,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AddExpenseDialog(
                                  catID: projectPro.categoryID,
                                  stageID: stagesModel.id,
                                  isFromStage: true,
                                )).then((value) {
                          projectPro
                              .projectDetailsByID(projectPro.projectModel!.id);
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: appBlue,
                        size: 25,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => push(
                          context,
                          ExpenseListScreen(
                            catID: 1,
                            stageID: stagesModel.id,
                          )),
                      child: ExpenseListTile(
                        amount:
                            stagesModel.expenseCategoryTotal.salary.toString(),
                        title: "Salary",
                        color: const Color(0xff7CCDF2),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => push(
                            context,
                            ExpenseListScreen(
                              catID: 2,
                              stageID: stagesModel.id,
                            )),
                        child: ExpenseListTile(
                          amount: stagesModel.expenseCategoryTotal.purchases
                              .toString(),
                          title: "Purchases",
                          color: const Color(0xffFAB03A),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => push(
                            context,
                            ExpenseListScreen(
                              catID: 3,
                              stageID: stagesModel.id,
                            )),
                        child: ExpenseListTile(
                          amount:
                              stagesModel.expenseCategoryTotal.rent.toString(),
                          title: "Rent",
                          color: const Color(0xff6E60FC),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadingText(
                      name: "Photos",
                      fontweight: FontWeight.bold,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => ImagePickerDialog(
                                  projectID: projectPro.projectModel!.id,
                                  stageID: stagesModel.id,
                                  isFromStage: true,
                                )).then((value) {
                          projectPro
                              .projectDetailsByID(projectPro.projectModel!.id);
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: appBlue,
                        size: 25,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: GestureDetector(
                    onTap: () {
                      push(context,
                          PhotoGalleryPage(images: stagesModel.images));
                    },
                    child: Row(
                      children: stagesModel.images.asMap().entries.map((e) {
                        return Row(
                          children: [
                            PhotoListTile(image: e.value.image),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // if(stagesModel.images.isNotEmpty)
                // GestureDetector(
                //   onTap: () => push(
                //       context, PhotoGalleryPage(images: stagesModel.images)),
                //   child: SizedBox(
                //     height: 80,
                //     child: ListView.separated(
                //         physics: const BouncingScrollPhysics(),
                //       itemCount: stagesModel.images.length,
                //       scrollDirection: Axis.horizontal,
                //       shrinkWrap: true,
                //       separatorBuilder: (context, index) => const SizedBox(
                //         width: 5,
                //       ),
                //       itemBuilder: (context, index) {
                //         final data = stagesModel.images[index];
                //         return PhotoListTile(image: data.image);
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
