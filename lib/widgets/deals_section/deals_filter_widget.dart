import 'package:flutter/material.dart';
import 'package:mobilicis/constents/app_colors.dart';
import 'package:mobilicis/main.dart';
import 'package:mobilicis/widgets/app_icon_button.dart';

openFilterSheet(BuildContext context, var data) {
  var size = MediaQuery.of(context).size;
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(bottom: 10),
            child: AppIconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              iconSize: 18,
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Filters'),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Clear Filter"),
                          ),
                        ],
                      ),
                      if (data.dealsFilterModel?.filtersMap != null)
                        for (var element
                            in data.dealsFilterModel!.filtersMap.entries)
                          FilterSheetCard(
                            text: element.key.toString().toTitleCase(),
                            list: element.value,
                          ),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(size.width, 50),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor1),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("APPLY"),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

class FilterSheetCard extends StatelessWidget {
  FilterSheetCard({super.key, required this.text, required this.list});

  final String text;
  final List<String> list;

  final ValueNotifier<num> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 60,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (BuildContext context, num value, Widget? child) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex.value = index;
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 18),
                        decoration: BoxDecoration(
                          color: selectedIndex.value == index
                              ? const Color(0xffD6D5D9)
                              : Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(list[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
