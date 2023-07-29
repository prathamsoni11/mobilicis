import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilicis/constents/app_sized_boxes.dart';
import 'package:mobilicis/providers/home_page_providers.dart';
import 'package:mobilicis/widgets/app_icon_button.dart';
import 'package:mobilicis/widgets/deals_section/deals_filter_widget.dart';
import 'package:provider/provider.dart';

class DealsWidget extends StatelessWidget {
  const DealsWidget({super.key});

  String dateTimeParser(String value) {
    String dateTimeString = value;
    DateFormat format = DateFormat("MM/dd/yyyy'T'HH:mm:ss.SSS'Z'");
    DateTime parsedDateTime = format.parseUtc(dateTimeString);
    const Map<int, String> monthsInYear = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December"
    };
    String result =
        "${monthsInYear[parsedDateTime.month]!.substring(0, 3)} ${parsedDateTime.day}";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HomePageProviders>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Deals Near You',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              InkWell(
                onTap: () => openFilterSheet(context, data),
                child: Row(
                  children: [
                    const Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    AppSizedBoxes.w5,
                    const Icon(
                      CupertinoIcons.arrow_up_arrow_down,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSizedBoxes.h10,
          if (data.dealsModel?.listings != null)
            GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.dealsModel?.listings?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              data.dealsModel!.listings![index].defaultImage!
                                  .fullImage!,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(Icons.error),
                              ),
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          AppSizedBoxes.h6,
                          Text(
                            "₹ ${data.dealsModel?.listings![index].listingNumPrice}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            data.dealsModel!.listings![index].marketingName!,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.dealsModel!.listings![index]
                                    .deviceStorage!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 10,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "Condition: ${data.dealsModel?.listings![index].deviceCondition}",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.dealsModel!.listings![index].listingState!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                dateTimeParser(data
                                    .dealsModel!.listings![index].createdAt!),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: AppIconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
