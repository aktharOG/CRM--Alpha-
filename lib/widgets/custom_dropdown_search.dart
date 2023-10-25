// ignore_for_file: must_be_immutable

import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/theme/app_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';

class MultiSelectDropDownSearch extends StatefulWidget {
  final List<Category> items;
  String selectedItems;
  final String hint;
  final TextEditingController controller;
  final String? from;
  final String searchHint;
  final List selectedInt;
  final int? stageID;
  final int? catID;
  final String? type;
  final void Function(String)? onTap;

  MultiSelectDropDownSearch(
      {super.key,
      required this.items,
      required this.selectedItems,
      required this.hint,
      required this.controller,
      required this.from,
      required this.searchHint,
      required this.selectedInt,
      this.catID,
      this.stageID,
      this.type,
      this.onTap
      });

  @override
  State<MultiSelectDropDownSearch> createState() =>
      _MultiSelectDropDownSearchState();
}

class _MultiSelectDropDownSearchState extends State<MultiSelectDropDownSearch> {
  @override
  Widget build(BuildContext context) {
    final projectPro = Provider.of<ProjectProvider>(context);
    return Container(
      height: 50,

      decoration: BoxDecoration(
          border: Border.all(color: appBlue),
          borderRadius: BorderRadius.circular(8)),
      // margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Row(
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                    iconEnabledColor: appBlue,
                    isExpanded: true,
                    hint: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        widget.hint,
                        style: TextStyle(
                          fontSize: 16,
                          color: appBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    items: widget.items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.title,
                        //disable default onTap to avoid closing menu when selecting an item
                        enabled: false,
                        child: StatefulBuilder(
                          builder: (context, menuSetState) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 85,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (widget.type == "cat") {
                                        widget.selectedItems = item.title;
                                        if (widget.stageID != null) {
                                          projectPro.fetchExpenseList(
                                              widget.stageID, item.id);
                                        }
                                        projectPro.categoryID = item.id;
                                      } else {
                                        widget.selectedItems = item.title;
                                        if (widget.stageID != null) {
                                          projectPro.fetchExpenseList(
                                              item.id, projectPro.categoryID);
                                        }
                                        projectPro.selectedStage = item.title;
                                      }
                                      // : widget.selectedItems.add(item.title);
                                      // _isSelected? widget.selectedInt.remove(item.id):
                                      //  widget.selectedInt.add(item.id);
                                      //This rebuilds the StatefulWidget to update the button's text

                                      print(projectPro.categoryID);
                                      print(
                                          "selected stage : ${projectPro.selectedStage}");
                                      print(item.title);
                                      setState(() {});
                                      Navigator.pop(context);
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      // height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          // _isSelected
                                          //     ? const Icon(
                                          //         Icons.check_box_outlined)
                                          //     : const Icon(Icons
                                          //         .check_box_outline_blank),
                                          // const SizedBox(width: 16),
                                          Flexible(
                                            child: Text(
                                              item.title,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                    //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                    value: widget.selectedItems.isEmpty
                        ? null
                        : widget.selectedItems,
                    onChanged: (value) {},
                    buttonHeight: 40,
                    buttonWidth: 140,
                    itemHeight: 40,
                    itemPadding: EdgeInsets.zero,
                    selectedItemBuilder: (context) {
                      return widget.items.map(
                        (item) {
                          return Container(
                            alignment: AlignmentDirectional.centerStart,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              widget.selectedItems,
                              style: TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                  color: appBlue,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                          );
                        },
                      ).toList();
                    },
                    searchController: widget.controller,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                      
                        controller: widget.controller,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: widget.searchHint,
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue));
                    },
                    dropdownOverButton: true,
                    dropdownMaxHeight: 400,

                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        widget.controller.clear();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
