import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class PurchaseAddScreen extends StatefulWidget {
  const PurchaseAddScreen({super.key});
  @override
  State<PurchaseAddScreen> createState() => _PurchaseAddScreenState();
}

class _PurchaseAddScreenState extends State<PurchaseAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _supplierPhoneController = TextEditingController();
  final TextEditingController _paidAmountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _selectedPaymentMethod = 'Cash';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<PurchaseItem> _items = [];

  final List<String> _paymentMethods = [
    'Cash',
    'Bank Transfer',
    'Mobile Banking',
    'Card',
    'Credit',
    'Cheque',
  ];

  @override
  void dispose() {
    _supplierNameController.dispose();
    _supplierPhoneController.dispose();
    _paidAmountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.total);
  }

  double get _paidAmount {
    return double.tryParse(_paidAmountController.text) ?? 0.0;
  }

  double get _dueAmount {
    return _totalAmount - _paidAmount;
  }

  String get _paymentStatus {
    if (_paidAmount == 0) return 'unpaid';
    if (_paidAmount >= _totalAmount) return 'paid';
    return 'partial';
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

  void _addItem() {
    showDialog(
      context: context,
      builder: (context) => _AddItemDialog(
        onAdd: (item) {
          setState(() {
            _items.add(item);
          });
        },
      ),
    );
  }

  void _editItem(int index) {
    showDialog(
      context: context,
      builder: (context) => _AddItemDialog(
        item: _items[index],
        onAdd: (item) {
          setState(() {
            _items[index] = item;
          });
        },
      ),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _savePurchase() {
    if (_formKey.currentState!.validate()) {
      if (_items.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please add at least one item'),
            backgroundColor: MyColor.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
        return;
      }

      final purchase = {
        'supplierName': _supplierNameController.text,
        'supplierPhone': _supplierPhoneController.text,
        'date': DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
        'items': _items,
        'totalAmount': _totalAmount,
        'paidAmount': _paidAmount,
        'dueAmount': _dueAmount,
        'status': _paymentStatus,
        'paymentMethod': _selectedPaymentMethod,
        'note': _noteController.text,
      };

      Navigator.pop(context, purchase);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Purchase added successfully!'),
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
        title: Text(
          'Add Purchase',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Supplier Information Section
                    _buildSectionHeader('Supplier Information', Icons.store),
                    SizedBox(height: 12.h),
                    _buildSupplierInfo(),
                    SizedBox(height: 24.h),

                    // Date & Time Section
                    _buildSectionHeader('Date & Time', Icons.calendar_today),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(child: _buildDatePicker()),
                        SizedBox(width: 12.w),
                        Expanded(child: _buildTimePicker()),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Items Section
                    _buildSectionHeader('Purchase Items', Icons.inventory_2),
                    SizedBox(height: 12.h),
                    _buildItemsList(),
                    SizedBox(height: 12.h),
                    _buildAddItemButton(),
                    SizedBox(height: 24.h),

                    // Payment Information Section
                    _buildSectionHeader('Payment Information', Icons.payment),
                    SizedBox(height: 12.h),
                    _buildPaymentInfo(),
                    SizedBox(height: 24.h),

                    // Additional Note (Optional)
                    _buildSectionHeader('Additional Note (Optional)', Icons.note),
                    SizedBox(height: 12.h),
                    _buildNoteField(),
                    SizedBox(height: 24.h),

                    // Summary Card
                    _buildSummaryCard(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),

            // Bottom Action Bar
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: MyColor.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.sp, color: MyColor.primary),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: MyColor.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _supplierNameController,
            decoration: InputDecoration(
              labelText: 'Supplier Name',
              hintText: 'Enter supplier name',
              prefixIcon: Icon(Icons.business, color: MyColor.primary),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter supplier name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _supplierPhoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: '+880 1XXX-XXXXXX',
              prefixIcon: Icon(Icons.phone, color: MyColor.primary),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
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

  Widget _buildItemsList() {
    if (_items.isEmpty) {
      return Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: MyColor.gray50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: MyColor.outlineVariant,
            width: 1.w,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 48.sp,
              color: MyColor.gray400,
            ),
            SizedBox(height: 12.h),
            Text(
              'No items added yet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: MyColor.gray600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Click "Add Item" button below',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: MyColor.gray500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: _items.asMap().entries.map((entry) {
        int index = entry.key;
        PurchaseItem item = entry.value;
        return _buildItemCard(item, index);
      }).toList(),
    );
  }

  Widget _buildItemCard(PurchaseItem item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: MyColor.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: MyColor.warning,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'Qty: ${item.quantity}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.gray600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 3.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: MyColor.gray400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '৳${item.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.gray600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '৳${item.total.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColor.warning,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => _editItem(index),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: MyColor.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 14.sp,
                        color: MyColor.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  InkWell(
                    onTap: () => _deleteItem(index),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: MyColor.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 14.sp,
                        color: MyColor.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddItemButton() {
    return OutlinedButton.icon(
      onPressed: _addItem,
      icon: Icon(Icons.add, size: 20.sp),
      label: Text('Add Item'),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        side: BorderSide(color: MyColor.primary, width: 1.5.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        foregroundColor: MyColor.primary,
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Column(
        children: [
          // Payment Method Selector
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Payment Method',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: MyColor.onSurface,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
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
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? MyColor.primary.withOpacity(0.1)
                        : MyColor.gray50,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected ? MyColor.primary : MyColor.outlineVariant,
                      width: isSelected ? 1.5.w : 1.w,
                    ),
                  ),
                  child: Text(
                    method,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected ? MyColor.primary : MyColor.gray600,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: MyColor.outlineVariant),
          SizedBox(height: 16.h),

          // Paid Amount Field
          TextFormField(
            controller: _paidAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              labelText: 'Paid Amount',
              hintText: 'Enter paid amount',
              prefixIcon: Icon(Icons.attach_money, color: MyColor.primary),
              suffixText: '৳',
              suffixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: MyColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final amount = double.tryParse(value);
                if (amount == null) {
                  return 'Please enter a valid amount';
                }
                if (amount > _totalAmount) {
                  return 'Cannot exceed total amount';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoteField() {
    return TextFormField(
      controller: _noteController,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Add any additional notes...',
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: 50.h),
          child: Icon(Icons.note, color: MyColor.primary),
        ),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (_paymentStatus) {
      case 'paid':
        statusColor = MyColor.success;
        statusText = 'PAID';
        statusIcon = Icons.check_circle;
        break;
      case 'partial':
        statusColor = MyColor.warning;
        statusText = 'PARTIAL';
        statusIcon = Icons.warning;
        break;
      default:
        statusColor = MyColor.error;
        statusText = 'UNPAID';
        statusIcon = Icons.cancel;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyColor.warning.withOpacity(0.1),
            MyColor.warning.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.warning.withOpacity(0.3), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: MyColor.warning.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.inventory_2,
                      color: MyColor.warning,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Purchase Summary',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      statusText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('Total Items', '${_items.length}', MyColor.onSurface),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Total Amount',
            '৳${_totalAmount.toStringAsFixed(2)}',
            MyColor.warning,
            bold: true,
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Paid Amount',
            '৳${_paidAmount.toStringAsFixed(2)}',
            MyColor.success,
          ),
          if (_dueAmount > 0) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow(
              'Due Amount',
              '৳${_dueAmount.toStringAsFixed(2)}',
              MyColor.error,
              bold: true,
            ),
          ],
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

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surface,
        boxShadow: [
          BoxShadow(
            color: MyColor.gray300.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
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
              onPressed: _savePurchase,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                backgroundColor: MyColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Save Purchase',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: MyColor.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
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

// Add Item Dialog
class _AddItemDialog extends StatefulWidget {
  final PurchaseItem? item;
  final Function(PurchaseItem) onAdd;

  const _AddItemDialog({this.item, required this.onAdd});

  @override
  State<_AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<_AddItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _quantityController = TextEditingController(
      text: widget.item?.quantity.toString() ?? '',
    );
    _priceController = TextEditingController(
      text: widget.item?.price.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  double get _total {
    final qty = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    return qty * price;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final item = PurchaseItem(
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        price: double.parse(_priceController.text),
      );
      widget.onAdd(item);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dialog Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: MyColor.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.inventory_2,
                      color: MyColor.warning,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.item == null ? 'Add Item' : 'Edit Item',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: MyColor.gray600),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Item Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  hintText: 'e.g., Rice 50kg',
                  prefixIcon: Icon(Icons.label, color: MyColor.primary),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Quantity and Price
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        hintText: '0',
                        prefixIcon: Icon(Icons.format_list_numbered, color: MyColor.primary),
                      ),
                      onChanged: (value) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Price (৳)',
                        hintText: '0.00',
                        prefixIcon: Icon(Icons.attach_money, color: MyColor.primary),
                      ),
                      onChanged: (value) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(value) == null || double.parse(value) <= 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Total Display
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: MyColor.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: MyColor.warning.withOpacity(0.3),
                    width: 1.w,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '৳${_total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: MyColor.warning,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
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
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: MyColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        widget.item == null ? 'Add Item' : 'Update Item',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: MyColor.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model
class PurchaseItem {
  final String name;
  final int quantity;
  final double price;

  PurchaseItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}