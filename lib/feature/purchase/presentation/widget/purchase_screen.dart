import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});
  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'paid', 'partial', 'unpaid'

  final List<Purchase> _purchases = [
    Purchase(
      id: 'PUR001',
      supplierName: 'ABC Wholesale Ltd',
      supplierPhone: '+880 1712-345678',
      date: DateTime(2024, 12, 19),
      time: '09:15 AM',
      items: [
        PurchaseItem(name: 'Rice 50kg', quantity: 20, price: 2500.00),
        PurchaseItem(name: 'Oil 5L', quantity: 10, price: 800.00),
        PurchaseItem(name: 'Sugar 25kg', quantity: 8, price: 1200.00),
      ],
      totalAmount: 67600.00,
      paidAmount: 67600.00,
      dueAmount: 0.00,
      status: 'paid',
      paymentMethod: 'Bank Transfer',
    ),
    Purchase(
      id: 'PUR002',
      supplierName: 'Fresh Foods Supplier',
      supplierPhone: '+880 1823-456789',
      date: DateTime(2024, 12, 19),
      time: '11:30 AM',
      items: [
        PurchaseItem(name: 'Flour 50kg', quantity: 15, price: 1800.00),
        PurchaseItem(name: 'Salt 25kg', quantity: 5, price: 450.00),
      ],
      totalAmount: 29250.00,
      paidAmount: 15000.00,
      dueAmount: 14250.00,
      status: 'partial',
      paymentMethod: 'Cash',
    ),
    Purchase(
      id: 'PUR003',
      supplierName: 'Green Valley Traders',
      supplierPhone: '+880 1934-567890',
      date: DateTime(2024, 12, 18),
      time: '02:45 PM',
      items: [
        PurchaseItem(name: 'Tea 5kg', quantity: 12, price: 2200.00),
        PurchaseItem(name: 'Coffee 2kg', quantity: 8, price: 1800.00),
      ],
      totalAmount: 40800.00,
      paidAmount: 0.00,
      dueAmount: 40800.00,
      status: 'unpaid',
      paymentMethod: 'Credit',
    ),
    Purchase(
      id: 'PUR004',
      supplierName: 'City Commodities',
      supplierPhone: '+880 1645-678901',
      date: DateTime(2024, 12, 18),
      time: '10:20 AM',
      items: [
        PurchaseItem(name: 'Chicken 50kg', quantity: 3, price: 12500.00),
        PurchaseItem(name: 'Fish 30kg', quantity: 2, price: 8000.00),
      ],
      totalAmount: 53500.00,
      paidAmount: 53500.00,
      dueAmount: 0.00,
      status: 'paid',
      paymentMethod: 'Mobile Banking',
    ),
    Purchase(
      id: 'PUR005',
      supplierName: 'Prime Distributors',
      supplierPhone: '+880 1756-789012',
      date: DateTime(2024, 12, 17),
      time: '03:30 PM',
      items: [
        PurchaseItem(name: 'Biscuits Box', quantity: 50, price: 350.00),
        PurchaseItem(name: 'Noodles Box', quantity: 40, price: 280.00),
      ],
      totalAmount: 28700.00,
      paidAmount: 10000.00,
      dueAmount: 18700.00,
      status: 'partial',
      paymentMethod: 'Cash',
    ),
    Purchase(
      id: 'PUR006',
      supplierName: 'Metro Suppliers',
      supplierPhone: '+880 1867-890123',
      date: DateTime(2024, 12, 17),
      time: '11:00 AM',
      items: [
        PurchaseItem(name: 'Potato 100kg', quantity: 5, price: 3500.00),
        PurchaseItem(name: 'Onion 80kg', quantity: 4, price: 3200.00),
      ],
      totalAmount: 30300.00,
      paidAmount: 30300.00,
      dueAmount: 0.00,
      status: 'paid',
      paymentMethod: 'Bank Transfer',
    ),
  ];

  List<Purchase> get _filteredPurchases {
    var filtered = _purchases.where((purchase) {
      final matchesSearch =
          purchase.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          purchase.supplierName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          purchase.supplierPhone.contains(_searchQuery);

      if (!matchesSearch) return false;

      switch (_selectedFilter) {
        case 'paid':
          return purchase.status == 'paid';
        case 'partial':
          return purchase.status == 'partial';
        case 'unpaid':
          return purchase.status == 'unpaid';
        default:
          return true;
      }
    }).toList();

    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  double get _todayTotal {
    final today = DateTime.now();
    return _purchases
        .where(
          (purchase) =>
              purchase.date.year == today.year &&
              purchase.date.month == today.month &&
              purchase.date.day == today.day,
        )
        .fold(0.0, (sum, purchase) => sum + purchase.totalAmount);
  }

  double get _todayDue {
    final today = DateTime.now();
    return _purchases
        .where(
          (purchase) =>
              purchase.date.year == today.year &&
              purchase.date.month == today.month &&
              purchase.date.day == today.day,
        )
        .fold(0.0, (sum, purchase) => sum + purchase.dueAmount);
  }

  int get _todayCount {
    final today = DateTime.now();
    return _purchases
        .where(
          (purchase) =>
              purchase.date.year == today.year &&
              purchase.date.month == today.month &&
              purchase.date.day == today.day,
        )
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyColor.onSurfaceVariant),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Purchases', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Show date picker
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: MyColor.onSurfaceVariant),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          // Summary Banner
          _buildSummaryBanner(),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by ID, supplier or phone',
                prefixIcon: Icon(Icons.search, color: MyColor.outline),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: MyColor.outline),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: 12.h),

          // Purchase Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredPurchases.length} Purchases',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.gray600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Sort by: Recent',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Purchase List
          Expanded(
            child: _filteredPurchases.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredPurchases.length,
                    itemBuilder: (context, index) {
                      return _buildPurchaseCard(_filteredPurchases[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPurchasePage()),
          );
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add, color: MyColor.onPrimary),
        label: Text(
          'New Purchase',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBanner() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MyColor.warning, MyColor.warning.withOpacity(0.85)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.warning.withOpacity(0.25),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: MyColor.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: MyColor.white,
                  size: 32.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Purchases',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳${_todayTotal.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: MyColor.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: MyColor.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_shipping,
                      color: MyColor.white,
                      size: 16.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '$_todayCount Orders',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: MyColor.white.withOpacity(0.2), height: 1.h),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.receipt_long,
                  label: 'Orders',
                  value: '$_todayCount',
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.account_balance_wallet,
                  label: 'Due Amount',
                  value: '৳${_todayDue.toStringAsFixed(0)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBannerStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: MyColor.white, size: 24.sp),
        SizedBox(height: 6.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: MyColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: MyColor.white.withOpacity(0.85),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildFilterChip('All', 'all', _purchases.length),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Paid',
            'paid',
            _purchases.where((p) => p.status == 'paid').length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Partial',
            'partial',
            _purchases.where((p) => p.status == 'partial').length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Unpaid',
            'unpaid',
            _purchases.where((p) => p.status == 'unpaid').length,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, int count) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text('$label ($count)'),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: MyColor.surfaceContainerLowest,
      selectedColor: MyColor.primary.withOpacity(0.15),
      checkmarkColor: MyColor.primary,
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: isSelected ? MyColor.primary : MyColor.gray600,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? MyColor.primary : MyColor.outlineVariant,
        width: isSelected ? 1.5.w : 1.w,
      ),
    );
  }

  Widget _buildPurchaseCard(Purchase purchase) {
    Color statusColor;
    IconData statusIcon;

    switch (purchase.status) {
      case 'paid':
        statusColor = MyColor.success;
        statusIcon = Icons.check_circle;
        break;
      case 'partial':
        statusColor = MyColor.warning;
        statusIcon = Icons.warning;
        break;
      default:
        statusColor = MyColor.error;
        statusIcon = Icons.cancel;
    }

    final isToday =
        purchase.date.year == DateTime.now().year &&
        purchase.date.month == DateTime.now().month &&
        purchase.date.day == DateTime.now().day;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: MyColor.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            // Navigate to purchase detail page
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              purchase.id,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 12.sp,
                                  color: MyColor.gray500,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  isToday
                                      ? 'Today'
                                      : _formatDate(purchase.date),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: MyColor.gray500),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.access_time,
                                  size: 12.sp,
                                  color: MyColor.gray500,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  purchase.time,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: MyColor.gray500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
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
                            purchase.status.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
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

                SizedBox(height: 12.h),
                Divider(height: 1.h, color: MyColor.outlineVariant),
                SizedBox(height: 12.h),

                // Supplier Info
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: MyColor.primaryFixed,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.store,
                          color: MyColor.primary,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            purchase.supplierName,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            purchase.supplierPhone,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: MyColor.gray500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.gray100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inventory,
                            size: 12.sp,
                            color: MyColor.gray600,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${purchase.items.length} items',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: MyColor.gray600,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Amount Section
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: MyColor.gray50,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.payments,
                                size: 16.sp,
                                color: MyColor.gray600,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                purchase.paymentMethod,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: MyColor.gray600,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            '৳${purchase.totalAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (purchase.dueAmount > 0) ...[
                        SizedBox(height: 8.h),
                        Divider(height: 1.h, color: MyColor.outlineVariant),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Due Amount:',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: MyColor.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '৳${purchase.dueAmount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: MyColor.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80.sp, color: MyColor.gray300),
          SizedBox(height: 16.h),
          Text(
            'No purchases found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: MyColor.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
          ),
        ],
      ),
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
}

// Models
class Purchase {
  final String id;
  final String supplierName;
  final String supplierPhone;
  final DateTime date;
  final String time;
  final List<PurchaseItem> items;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String status; // 'paid', 'partial', 'unpaid'
  final String paymentMethod;

  Purchase({
    required this.id,
    required this.supplierName,
    required this.supplierPhone,
    required this.date,
    required this.time,
    required this.items,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.status,
    required this.paymentMethod,
  });
}

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

// Placeholder for AddPurchasePage
class AddPurchasePage extends StatelessWidget {
  const AddPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Purchase')),
      body: Center(child: Text('Add Purchase Form Here')),
    );
  }
}
