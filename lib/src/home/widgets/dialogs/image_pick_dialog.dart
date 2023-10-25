import 'dart:io';

import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/helper/navigation_helper.dart';
import 'package:crm_new/src/home/provider/home_provider.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/src/home/widgets/dialogs/add_expense_dialog.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:crm_new/widgets/custom_button.dart';
import 'package:crm_new/widgets/custom_dropdown_search.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/custom_textfield.dart';
import 'package:crm_new/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerDialog extends StatelessWidget {
  final int projectID,stageID;
  final bool isFromStage;
  const ImagePickerDialog({super.key,required this.projectID,required this.stageID,this.isFromStage=false});

  @override
  Widget build(BuildContext context) {
    final homePro = Provider.of<HomeProvider>(context);
    final projectPro = Provider.of<ProjectProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeadingText(
              name: "Add Image",
              fontweight: FontWeight.bold,
            ),
            InkWell(
                onTap: () {
                  pop(context);
                },
                child: const Icon(Icons.close))
          ],
        ),
        content: SizedBox(
          height:isFromStage?250: 290,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              CurstomTextfield(
                  label: "Title",
                  hint: "Title",
                  controller: projectPro.titleController,
                  borderRadius: BorderRadius.circular(10)),
              const SizedBox(
                height: 10,
              ),
              if(!isFromStage)
              MultiSelectDropDownSearch(
                  items: categoryList,
                  selectedItems: "",
                  hint: "Stages",
                  controller: homePro.searchController,
                  from: "from",
                  searchHint: "Stages",
                  selectedInt: const []),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        projectPro.pickImage(source: ImageSource.camera);
                      },
                      child:
                          const PickSelectBox(icon: "camera", name: "Camera")),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        projectPro.pickMultiImage();
                      },
                      child: const PickSelectBox(
                          icon: "gallery-add", name: "Upload")),
                  const SizedBox(
                    width: 10,
                  ),
                  if (projectPro.imageListString.isNotEmpty)
                    Stack(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: (){
                            projectPro.loadRandomImage();
                            
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: appBlue),
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                            width: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(projectPro.imageListString[projectPro.i]),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Badge.count(count: projectPro.imageListString.length)),
                        Positioned(
                            right: 1,
                            child: InkWell(
                                onTap: projectPro.removeImage,
                                child: const Icon(Icons.close)))
                      ],
                    )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
           projectPro.isAddImage
                    ? const SizedBox(height: 50, child: LoadingIC())
                    :   Row(
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
                        if (projectPro.titleController.text.isNotEmpty &&
                            projectPro.imageFilesList.isNotEmpty) {
                          projectPro.onAddImage(
                              context, projectID, stageID, projectPro.imageFilesList);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Provide Title/Image/Stage");
                        }
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
// widgets

class PickSelectBox extends StatelessWidget {
  final String name, icon;
  const PickSelectBox({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: name == "Upload" ? appBlue : Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SvgIcon(path: icon),
          HeadingText(
            name: name,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
