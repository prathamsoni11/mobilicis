import 'package:flutter/material.dart';
import 'package:mobilicis/constents/app_sized_boxes.dart';
import 'package:provider/provider.dart';

import '../providers/home_page_providers.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HomePageProviders>(context);
    if (data.searchModel != null) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(title: "Brands", list: data.searchModel!.makes!),
            AppSizedBoxes.h40,
            SearchWidget(
                title: 'Mobile Model', list: data.searchModel!.models!),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.title, required this.list});

  final String title;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        AppSizedBoxes.h6,
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                list[index],
                style: const TextStyle(fontSize: 17),
              ),
            );
          },
        ),
      ],
    );
  }
}
