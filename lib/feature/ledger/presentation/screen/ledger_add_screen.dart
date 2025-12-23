import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class LedgerAddScreen extends StatefulWidget {
  const LedgerAddScreen({super.key});
  @override
  State<LedgerAddScreen> createState() => _LedgerAddScreenState();
}

class _LedgerAddScreenState extends State<LedgerAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();

  String _selectedType = 'income'; // 'income' or 'expense'
  String _selectedCategory = '';
  String _selectedPaymentMethod = 'Cash';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<String> _incomeCategories = [
    'Sales',
    'Service Income',
    'Interest Income',
    'Other Income',
  ];

  final List<String> _expenseCategories = [
    'Purchase',
    'Salary',
    'Rent',
    'Utilities',
    'Maintenance',
    'Transportation',
    'Marketing',
    'Other Expense',
  ];

  final List<String> _paymentMethods = [
    'Cash',
    'Bank Transfer',
    'Mobile Banking',
    'Card',
    'Cheque',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = _incomeCategories[0];
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  List<String> get _currentCategories {
    return _selectedType == 'income' ? _incomeCategories : _expenseCategories;
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
              surface: MyColor.surface,
              onSurface: MyColor.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
              surface: MyColor.surface,
              onSurface: MyColor.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      // Create the ledger entry
      final entry = {
        'type': _selectedType,
        'category': _selectedCategory,
        'description': _descriptionController.text,
        'amount': double.parse(_amountController.text),
        'date': DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
        'paymentMethod': _selectedPaymentMethod,
        'reference': _referenceController.text.isEmpty
            ? null
            : _referenceController.text,
      };

      Navigator.pop(context, entry);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ledger entry added successfully!'),
          backgroundColor: MyColor.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.surface,
        leading: IconButton(
          icon: Icon(Icons.close, color: MyColor.onSurfaceVariant),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Ledger Entry', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Type Selector (Income/Expense)
              _buildSectionHeader('Transaction Type'),
              SizedBox(height: 12.h),
              _buildTypeSelector(),
              SizedBox(height: 24.h),

              // Amount Field
              _buildSectionHeader('Amount (৳)'),
              SizedBox(height: 12.h),
              _buildAmountField(),
              SizedBox(height: 24.h),

              // Category Dropdown
              _buildSectionHeader('Category'),
              SizedBox(height: 12.h),
              _buildCategoryDropdown(),
              SizedBox(height: 24.h),

              // Description Field
              _buildSectionHeader('Description'),
              SizedBox(height: 12.h),
              _buildDescriptionField(),
              SizedBox(height: 24.h),

              // Payment Method
              _buildSectionHeader('Payment Method'),
              SizedBox(height: 12.h),
              _buildPaymentMethodSelector(),
              SizedBox(height: 24.h),

              // Date & Time
              _buildSectionHeader('Date & Time'),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(child: _buildDatePicker()),
                  SizedBox(width: 12.w),
                  Expanded(child: _buildTimePicker()),
                ],
              ),
              SizedBox(height: 24.h),

              // Reference Number (Optional)
              _buildSectionHeader('Reference Number (Optional)'),
              SizedBox(height: 12.h),
              _buildReferenceField(),
              SizedBox(height: 32.h),

              // Summary Card
              _buildSummaryCard(),
              SizedBox(height: 24.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(color: MyColor.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: MyColor.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _saveEntry,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        backgroundColor: MyColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Save Entry',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: MyColor.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: MyColor.onSurface,
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: MyColor.gray100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeOption(
              'Income',
              'income',
              Icons.arrow_downward,
              MyColor.success,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildTypeOption(
              'Expense',
              'expense',
              Icons.arrow_upward,
              MyColor.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeOption(String label, String value, IconData icon, Color color) {
    final isSelected = _selectedType == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = value;
          _selectedCategory = _currentCategories[0];
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
          border: isSelected
              ? Border.all(color: color.withOpacity(0.3), width: 1.5.w)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? color : MyColor.gray500,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? color : MyColor.gray600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        hintText: 'Enter amount',
        prefixIcon: Icon(Icons.attach_money, color: MyColor.primary),
        suffixText: '৳',
        suffixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: MyColor.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an amount';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid amount';
        }
        if (double.parse(value) <= 0) {
          return 'Amount must be greater than 0';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedCategory,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.category, color: MyColor.primary),
      ),
      items: _currentCategories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Enter description',
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: 50.h),
          child: Icon(Icons.description, color: MyColor.primary),
        ),
        alignLabelWithHint: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _paymentMethods.map((method) {
        final isSelected = _selectedPaymentMethod == method;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = method;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? MyColor.primary.withOpacity(0.1)
                  : MyColor.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected ? MyColor.primary : MyColor.outlineVariant,
                width: isSelected ? 1.5.w : 1.w,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getPaymentIcon(method),
                  size: 18.sp,
                  color: isSelected ? MyColor.primary : MyColor.gray600,
                ),
                SizedBox(width: 8.w),
                Text(
                  method,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? MyColor.primary : MyColor.gray600,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case 'Cash':
        return Icons.payments;
      case 'Bank Transfer':
        return Icons.account_balance;
      case 'Mobile Banking':
        return Icons.phone_android;
      case 'Card':
        return Icons.credit_card;
      case 'Cheque':
        return Icons.receipt;
      default:
        return Icons.payment;
    }
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _selectDate,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: MyColor.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: MyColor.primary, size: 18.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _formatDate(_selectedDate),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return InkWell(
      onTap: _selectTime,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: MyColor.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: MyColor.primary, size: 18.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _formatTime(_selectedTime),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReferenceField() {
    return TextFormField(
      controller: _referenceController,
      decoration: InputDecoration(
        hintText: 'e.g., SAL001, INV-123',
        prefixIcon: Icon(Icons.tag, color: MyColor.primary),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final color = _selectedType == 'income' ? MyColor.success : MyColor.error;
    final amount = _amountController.text.isEmpty
        ? 0.0
        : double.tryParse(_amountController.text) ?? 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _selectedType == 'income'
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: color,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Transaction Summary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('Type', _selectedType.toUpperCase(), color),
          SizedBox(height: 8.h),
          _buildSummaryRow('Category', _selectedCategory, MyColor.onSurface),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Amount',
            '${_selectedType == 'income' ? '+' : '-'}৳${amount.toStringAsFixed(2)}',
            color,
            bold: true,
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Payment',
            _selectedPaymentMethod,
            MyColor.onSurface,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color valueColor,
      {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.gray600,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}