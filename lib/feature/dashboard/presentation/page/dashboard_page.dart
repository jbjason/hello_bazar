// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Dashboard", [], context),
      body: SafeArea(
        child: Padding(
          padding: const .all(10),
          child: Column(mainAxisAlignment: .center, children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
