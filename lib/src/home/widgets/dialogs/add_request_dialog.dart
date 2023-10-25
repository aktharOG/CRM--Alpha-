import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';

import 'package:crm_new/widgets/custom_button.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../helper/navigation_helper.dart';

class AddRequestDialog extends StatelessWidget {
  const AddRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final projectPro = Provider.of<ProjectProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.zero,
        title: const HeadingText(
          name: "Add Request",
          fontweight: FontWeight.bold,
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 250,
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
                CurstomTextfield(
                    maxLine: 100,
                    label: "Description",
                    hint: "Description",
                    controller: projectPro.descreptionController,
                    borderRadius: BorderRadius.circular(10)),
                const SizedBox(
                  height: 15,
                ),
                projectPro.isRequestLoading
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
                                if (projectPro
                                        .titleController.text.isNotEmpty &&
                                    projectPro.descreptionController.text
                                        .isNotEmpty) {
                                  projectPro.onAddRequest(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Provide Title/Descreption");
                                }
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
