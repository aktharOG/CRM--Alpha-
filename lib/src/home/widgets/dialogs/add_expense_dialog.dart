import 'package:crm_new/src/home/provider/home_provider.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_button.dart';
import 'package:crm_new/widgets/custom_dropdown_search.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/custom_textfield.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../helper/navigation_helper.dart';
import '../../../../models/category_model.dart';

import 'package:path/path.dart' as p;

class AddExpenseDialog extends StatelessWidget {
  final int stageID, catID;
  final bool isFromStage;
  const AddExpenseDialog(
      {super.key,
      required this.catID,
      required this.stageID,
      this.isFromStage = false});

  @override
  Widget build(BuildContext context) {
    final homePro = Provider.of<HomeProvider>(context);
    final projectPro = Provider.of<ProjectProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.zero,
        title: const HeadingText(
          name: "Add Expense",
          fontweight: FontWeight.bold,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            height: isFromStage ? 400 : 450,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurstomTextfield(
                    label: "Title",
                    hint: "Title",
                    controller: projectPro.titleController,
                    borderRadius: BorderRadius.circular(10)),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CurstomTextfield(
                            isNumber: true,
                            label: "₹0000000",
                            hint: "₹0000000",
                            controller: homePro.priceController,
                            borderRadius: BorderRadius.circular(10))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            projectPro.pickDate(context);
                          },
                          child: IntrinsicHeight(
                            child: Container(
                              height: 60,
                              // padding: const EdgeInsets.all(17),
                              decoration: BoxDecoration(
                                  border: Border.all(color: appBlue),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HeadingText(
                                    name: projectPro.dateTime == null
                                        ? "DD/MM/YY"
                                        : projectPro.dateTime!.toString(),
                                    color: Colors.grey,
                                  ),
                                  VerticalDivider(
                                    color: appBlue,
                                  ),
                                  SvgIcon(
                                    path: "stickynote",
                                    color: appBlue,
                                    fixedColor: appBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!isFromStage)
                  MultiSelectDropDownSearch(
                      type: "cat",
                      items: categoryList,
                      selectedItems: "",
                      hint: "Stages",
                      controller: homePro.searchController,
                      from: "from",
                      searchHint: "Stages",
                      selectedInt: const []),

                // CurstomTextfield(
                //     label: "Stage1",
                //     hint: "Stage1",
                //     controller: homePro.titleController,
                //     borderRadius: BorderRadius.circular(10)),
                const SizedBox(
                  height: 10,
                ),
                MultiSelectDropDownSearch(
                    items: salaryList,
                    selectedItems: "",
                    hint: "Category",
                    controller: homePro.searchController,
                    from: "from",
                    searchHint: "Category",
                    selectedInt: const []),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    HeadingText(name: "Add Bill Documents / Images "),
                    HeadingText(
                      name: "*",
                      color: Colors.red,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => const ImagePickerDialog());
                    projectPro.pickImage(source: ImageSource.gallery);
                  },
                  child: projectPro.imageFile != null
                      ? Center(
                          child: ListTile(
                            title: HeadingText(
                                name: p.basename(projectPro.imageFile!.path)),
                            leading: Image.file(
                              projectPro.imageFile!,
                              fit: BoxFit.cover,
                            ),
                            trailing: InkWell(
                                onTap: () {
                                  projectPro.removeImage();
                                },
                                child: const Icon(Icons.close)),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DottedBorder(
                              color: appBlue,
                              dashPattern: const [8],
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: appBlue,
                                    ),
                                    HeadingText(
                                      name: "Add",
                                      color: appBlue,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
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
                          projectPro.onAddEXpense(
                              context,
                              stageID,
                              projectPro.imageFile!.path,
                              projectPro.titleController.text,
                              homePro.priceController.text,
                              projectPro.dateTime,
                              projectPro.categoryID);
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Category> categoryList = [
  Category(id: 1, title: "Stage 1"),
  Category(id: 2, title: "Stage 2"),
  Category(id: 3, title: "Stage 3"),
];

List<Category> salaryList = [
  Category(id: 1, title: "Salary"),
  Category(id: 2, title: "Purchases"),
  Category(id: 3, title: "Rent"),
  Category(id: 4, title: "Wages"),
  Category(id: 5, title: "Machinery"),
  Category(id: 6, title: "Local Rent"),
  Category(id: 7, title: "Others"),
];
