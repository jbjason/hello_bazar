import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_number_field.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});
  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _numberController = TextEditingController();
  final _totalController = TextEditingController();
  final _loyaltyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Add Product", [], context, true),
      body: SafeArea(
        child: Padding(
          padding: .all(12.w),
          child: Column(
            crossAxisAlignment: .stretch,
            mainAxisAlignment: .center,
            spacing: 10.h,
            children: [
              Text("Customer Number"),
              CmNumberField(
                controller: _numberController,
                label: "01XXXXXXXXXX",
              ),
              SizedBox(height: 5.h),
              Text("Total"),
              CmNumberField(
                controller: _totalController,
                label: "৳ ..................",
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: .end,
                spacing: 10.w,
                children: [
                  Column(
                    crossAxisAlignment: .end,
                    spacing: 15.h,
                    children: [
                      _getAmountTitle("Sub Total"),
                      _getAmountTitle("Loyalty Total"),
                      _getAmountTitle("Grand Total"),
                    ],
                  ),
                  SizedBox(
                    width: 100.w,
                    child: Column(
                      children: [
                        _getAmount(_totalController.text.trim()),
                        CmNumberField(
                          controller: _loyaltyController,
                          label: "",
                        ),

                        _getAmount(_getGrandTotal),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              ElevatedButton(onPressed: () {}, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }

  Text _getAmountTitle(String title) =>
      Text("$title:  ৳ ", style: Theme.of(context).textTheme.bodyMedium);

  Text _getAmount(String amount) => Text(
    amount,
    style: Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
  );

  String get _getGrandTotal {
    final total = double.tryParse(_totalController.text.trim()) ?? 0.0;
    final loyalty = double.tryParse(_loyaltyController.text.trim()) ?? 0.0;
    final grandTotal = total - loyalty;
    return grandTotal.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _numberController.dispose();
    _totalController.dispose();
    _loyaltyController.dispose();
    super.dispose();
  }
}
