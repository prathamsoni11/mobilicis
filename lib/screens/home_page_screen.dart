import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilicis/api/firebase_messaging_api.dart';
import 'package:mobilicis/constents/app_colors.dart';
import 'package:mobilicis/constents/app_sized_boxes.dart';
import 'package:mobilicis/providers/home_page_providers.dart';
import 'package:mobilicis/screens/notification_screen.dart';
import 'package:mobilicis/screens/search_screen.dart';
import 'package:mobilicis/widgets/app_icon_button.dart';
import 'package:mobilicis/widgets/shop_by_card.dart';
import 'package:mobilicis/widgets/top_brands_card.dart';
import 'package:provider/provider.dart';

import '../widgets/deals_section/deals_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ValueNotifier<int> _indicatorIndex = ValueNotifier(0);
  final ValueNotifier<bool> _searchActive = ValueNotifier(false);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseApi.setupInteractedMessage();
    FirebaseApi.handleMessage();
    Provider.of<HomePageProviders>(context, listen: false).getDealsData();
    Provider.of<HomePageProviders>(context, listen: false).getDealsFilters();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading.value = true;
        await Provider.of<HomePageProviders>(context, listen: false)
            .getDealsData();
        _isLoading.value = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    if (_searchActive.value) {
      FocusManager.instance.primaryFocus?.unfocus();
      _searchActive.value = false;
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: const Drawer(
          width: 250,
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: AppColors.primaryColor1,
              title: Image.asset(
                'images/logo.png',
                color: Colors.white,
              ),
              actions: [
                AppIconButton(
                  icon: const Icon(CupertinoIcons.location_solid),
                  onPressed: () {},
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AppIconButton(
                      icon: const Icon(CupertinoIcons.bell),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 12,
                      right: 8,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: Text(
                          "3",
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primaryColor1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AppSizedBoxes.w5,
              ],
              bottom: AppBar(
                automaticallyImplyLeading: false,
                title: Container(
                  height: 40,
                  color: Colors.white,
                  child: TextField(
                    onTap: () {
                      _searchActive.value = true;
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search with make and model...',
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: AppColors.primaryColor1,
                      suffixIcon: AppIconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            _searchController.text = "";
                            Provider.of<HomePageProviders>(context,
                                    listen: false)
                                .getSearchResult("");
                          }
                        },
                        color: AppColors.primaryColor1,
                      ),
                    ),
                    onChanged: (value) {
                      Provider.of<HomePageProviders>(context, listen: false)
                          .getSearchResult(value);
                    },
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _searchActive,
              builder: (BuildContext context, bool value, Widget? child) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Visibility(
                        visible: _searchActive.value,
                        child: const SearchScreen(),
                      ),
                      Visibility(
                        visible: !_searchActive.value,
                        child: Column(
                          children: [
                            _buildTopBrands(),
                            _buildCarouselBanner(),
                            _buildShopBy(),
                            const DealsWidget(),
                            _buildProgressIndicator()
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopBrands() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buy Top Brands',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          Row(
            children: [
              const TopBrandsCard(logo: "images/apple.png"),
              AppSizedBoxes.w5,
              const TopBrandsCard(logo: "images/samsung.png"),
              AppSizedBoxes.w5,
              const TopBrandsCard(logo: "images/mi.png"),
              AppSizedBoxes.w5,
              const TopBrandsCard(logo: "images/vivo.png"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselBanner() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 4,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return const Placeholder();
          },
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, _) {
              _indicatorIndex.value = index;
            },
          ),
        ),
        AppSizedBoxes.h10,
        ValueListenableBuilder(
          valueListenable: _indicatorIndex,
          builder: (BuildContext context, int counterValue, Widget? child) {
            return DotsIndicator(
              dotsCount: 4,
              position: _indicatorIndex.value,
              decorator: DotsDecorator(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                activeSize: const Size(18.0, 9.0),
                color: Colors.grey, // Inactive color
                activeColor: AppColors.primaryColor1,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildShopBy() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Shop By'),
          AppSizedBoxes.h10,
          Row(
            children: [
              const ShopByCard(
                text: "Bestselling Mobiles",
                img: "images/best-selling-mobiles.png",
              ),
              AppSizedBoxes.w5,
              const ShopByCard(
                text: "Verified Devices Only",
                img: "images/verified-mobiles.png",
              ),
              AppSizedBoxes.w5,
              const ShopByCard(
                text: "Like New Condition",
                img: "images/like-new.png",
              ),
              AppSizedBoxes.w5,
              const ShopByCard(
                text: "Phones with Warranty",
                img: "images/warranty.png",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return ValueListenableBuilder(
      valueListenable: _isLoading,
      builder: (BuildContext context, bool value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
            child: Opacity(
              opacity: value ? 1.0 : 0.0,
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
