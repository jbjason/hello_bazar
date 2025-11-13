// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:hello_bazar/feature/home/presentation/widget/home_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pages = [
    DashboardPage(),
    MyDimens().getDemoPage("Message Page"),
    MyDimens().getDemoPage("Documents Page"),
    MyDimens().getDemoPage("Profile Page"),
  ];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initialized();
  }

  void _initialized() {
    if (context.mounted) {
      // final data = Provider.of<HomeProvider>(context, listen: false);
      // Future.wait([
      //   Future(() => data.fetchCategories(context)),
      //   Future(() => data.fetchBanners(context)),
      //   Future(() => data.fetchFoodCampaigns(context)),
      //   Future(() => data.fetchPopularProduct(context)),
      //   Future(() => data.fetchHomeRestaurant(ctx: context)),
      // ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentPage, children: _pages),
      bottomNavigationBar: HomeNavbar(
        onPageChange: _onPageChange,
        currentPage: _currentPage,
      ),
    );
  }

  void _onPageChange(int i) {
    setState(() => _currentPage = i);
  }
}
