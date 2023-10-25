import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/models/expense_model.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/src/home/provider/home_provider.dart';
import 'package:crm_new/src/home/provider/project_provider.dart';
import 'package:crm_new/src/home/widgets/dialogs/add_expense_dialog.dart';
import 'package:crm_new/widgets/custom_appbar.dart';
import 'package:crm_new/widgets/custom_dropdown_search.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListScreen extends StatefulWidget {
  final int stageID, catID;

  const ExpenseListScreen(
      {super.key, required this.stageID, required this.catID});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final projectPro = Provider.of<ProjectProvider>(context, listen: false);
      projectPro.fetchExpenseList(widget.stageID, widget.catID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePro = Provider.of<HomeProvider>(context);
    final projectPro = Provider.of<ProjectProvider>(context);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SafeArea(child: CustomAppBar(title: "Expenses List"))),
      body: projectPro.isExpenseLoading
          ? const LoadingIC()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: MultiSelectDropDownSearch(
                              stageID: widget.stageID,
                              catID: widget.catID,
                              type: "stage",
                              items: projectPro.stagesNameList,
                              selectedItems: projectPro.selectedStage,
                              hint: "Stages",
                              controller: homePro.searchController,
                              from: "from",
                              searchHint: "Stages",
                              selectedInt: const []),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 120,
                          child: MultiSelectDropDownSearch(
                            stageID: widget.stageID,
                            catID: widget.catID,
                            type: "cat",
                            items: salaryList,
                            selectedItems: "",
                            hint: projectPro.categoryName,
                            controller: homePro.searchController,
                            from: "from",
                            searchHint: "Salary",
                            selectedInt: const [],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    projectPro.expenseList.isEmpty
                        ? const Center(
                            child: HeadingText(name: "No expense found"),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: projectPro.expenseList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return expenseItem(
                                  expenseModel: projectPro.expenseList[index]);
                            },
                          )
                  ],
                ),
              ),
            ),
    );
  }
}

Widget expenseItem({required ExpenseModel expenseModel}) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: const Offset(3, 2),
              blurRadius: 10,
              color: Colors.grey.shade200),
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              CachedNetworkImage(
                placeholder: (context, url) => const SizedBox(
                  height: 30,
                  child: LoadingIC(),
                ),
                imageUrl: baseUrl + expenseModel.file,
                height: 60,
                width: 60,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: HeadingText(
                  name: expenseModel.title,
                  fontweight: FontWeight.bold,
                  maxlines: 1,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            HeadingText(
              name: expenseModel.date,
              color: Colors.grey,
              fontsize: 13,
            ),
            SizedBox(
              height: 10,
            ),
            HeadingText(
              name: "₹${expenseModel.totalExpanse}",
              color: Color(0xffAA0000),
              fontweight: FontWeight.bold,
            )
          ],
        )
      ],
    ),
  );
}
