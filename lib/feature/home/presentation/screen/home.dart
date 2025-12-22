// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hello_bazar/feature/ledger/presentation/screen/ledger_screen.dart';
import 'package:hello_bazar/feature/loyalty/presentation/screen/loyalty_screen.dart';
import 'package:hello_bazar/feature/due/presentation/screen/due_screen.dart';
import 'package:hello_bazar/feature/home/presentation/screen/home_screen.dart';
import 'package:hello_bazar/feature/home/presentation/widget/home_navbar.dart';
import 'package:hello_bazar/feature/profile/presentation/screen/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pages = [
    HomeScreen(),
    LoyaltyScreen(),
    DueScreen(),
    LedgerScreen(), //Center(child: Text("Coming Soon")),
    ProfileScreen(),
  ];
  dynamic _currentPage = 0;

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
    IconButton(onPressed: () {}, icon: Icon(Icons.ad_units));
  }
}
