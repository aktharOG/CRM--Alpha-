import 'package:crm_new/helper/loading_indicator.dart';
import 'package:crm_new/src/home/widgets/assigned_project_item.dart';
import 'package:crm_new/src/search/provider/search_provider.dart';
import 'package:crm_new/widgets/custom_text.dart';
import 'package:crm_new/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchPro = Provider.of<SearchProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Hero(
                tag: "search",
                child: CurstomTextfield(
                  onChanged: (value) => searchPro.onSearch(value),
                  label: "Search",
                  hint: "Search",
                  controller: searchPro.searchController,
                  borderRadius: BorderRadius.circular(50),
                  iconPath: "search-normal",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if(searchPro.searchList.isEmpty)
              const HeadingText(name: "No projects found!")
              else
              searchPro.isSearch?const LoadingIC():
              ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = searchPro.searchList[index];
                    return AssignedProjectItem(
                      projectModel: data,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: searchPro.searchList.length)
            ],
          ),
        ),
      )),
    );
  }
}
