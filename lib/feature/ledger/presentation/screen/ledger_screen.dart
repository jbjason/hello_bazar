import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});
  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'income', 'expense'
  String _selectedPeriod = 'today'; // 'today', 'week', 'month', 'year'

  final List<LedgerEntry> _entries = [
    LedgerEntry(
      id: 'LED001',
      type: 'income',
      category: 'Sales',
      description: 'Sale to John Doe - SAL001',
      amount: 1750.00,
      date: DateTime.now(), //DateTime(2025, 09, 19, 10, 30),
      paymentMethod: 'Cash',
      reference: 'SAL001',
    ),
    LedgerEntry(
      id: 'LED002',
      type: 'income',
      category: 'Sales',
      description: 'Sale to Jane Smith - SAL002',
      amount: 500.00,
      date: DateTime(2025, 12, 19, 11, 45),
      paymentMethod: 'Cash',
      reference: 'SAL002',
    ),
    LedgerEntry(
      id: 'LED003',
      type: 'expense',
      category: 'Purchase',
      description: 'Inventory purchase from supplier',
      amount: 12500.00,
      date: DateTime(2025, 10, 19, 9, 15),
      paymentMethod: 'Bank Transfer',
      reference: 'PUR045',
    ),
    LedgerEntry(
      id: 'LED004',
      type: 'expense',
      category: 'Salary',
      description: 'Staff salary payment',
      amount: 15000.00,
      date: DateTime.now(), //DateTime(2025, 12, 18, 14, 20),
      paymentMethod: 'Mobile Banking',
      reference: 'SAL-DEC',
    ),
    LedgerEntry(
      id: 'LED005',
      type: 'income',
      category: 'Sales',
      description: 'Sale to Sarah Williams - SAL004',
      amount: 740.00,
      date: DateTime(2025, 10, 18, 9, 20),
      paymentMethod: 'Card',
      reference: 'SAL004',
    ),
    LedgerEntry(
      id: 'LED006',
      type: 'expense',
      category: 'Utilities',
      description: 'Electricity bill payment',
      amount: 3200.00,
      date: DateTime(2025, 12, 18, 16, 30),
      paymentMethod: 'Cash',
      reference: 'UTIL-DEC',
    ),
    LedgerEntry(
      id: 'LED007',
      type: 'income',
      category: 'Sales',
      description: 'Sale to Robert Brown - SAL005',
      amount: 400.00,
      date: DateTime(2025, 12, 18, 15, 50),
      paymentMethod: 'Mobile Banking',
      reference: 'SAL005',
    ),
    LedgerEntry(
      id: 'LED008',
      type: 'expense',
      category: 'Rent',
      description: 'Monthly shop rent',
      amount: 25000.00,
      date: DateTime(2025, 12, 17, 10, 0),
      paymentMethod: 'Bank Transfer',
      reference: 'RENT-DEC',
    ),
    LedgerEntry(
      id: 'LED009',
      type: 'income',
      category: 'Sales',
      description: 'Sale to Emma Davis - SAL006',
      amount: 590.00,
      date: DateTime(2025, 12, 17, 11, 0),
      paymentMethod: 'Cash',
      reference: 'SAL006',
    ),
    LedgerEntry(
      id: 'LED010',
      type: 'expense',
      category: 'Maintenance',
      description: 'Equipment repair and maintenance',
      amount: 4500.00,
      date: DateTime(2025, 12, 16, 13, 45),
      paymentMethod: 'Cash',
      reference: 'MAINT-001',
    ),
  ];

  List<LedgerEntry> get _filteredEntries {
    var filtered = _entries.where((entry) {
      final matchesSearch =
          entry.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          entry.description.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          entry.category.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      // Filter by type
      if (_selectedFilter == 'income' && entry.type != 'income') return false;
      if (_selectedFilter == 'expense' && entry.type != 'expense') return false;

      // Filter by period
      final now = DateTime.now();
      switch (_selectedPeriod) {
        case 'today':
          return entry.date.year == now.year &&
              entry.date.month == now.month &&
              entry.date.day == now.day;
        case 'week':
          final weekAgo = now.subtract(Duration(days: 7));
          return entry.date.isAfter(weekAgo);
        case 'month':
          return entry.date.year == now.year && entry.date.month == now.month;
        case 'year':
          return entry.date.year == now.year;
        default:
          return true;
      }
    }).toList();

    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  double get _totalIncome {
    return _filteredEntries
        .where((e) => e.type == 'income')
        .fold(0.0, (sum, entry) => sum + entry.amount);
  }

  double get _totalExpense {
    return _filteredEntries
        .where((e) => e.type == 'expense')
        .fold(0.0, (sum, entry) => sum + entry.amount);
  }

  double get _balance => _totalIncome - _totalExpense;

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
        title: Text('Ledger', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Export ledger
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

          // Period Selector
          _buildPeriodSelector(),

          SizedBox(height: 16.h),

          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search transactions...',
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

          SizedBox(height: 16.h),

          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: 12.h),

          // Entry Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredEntries.length} Transactions',
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

          // Ledger Entries
          Expanded(
            child: _filteredEntries.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredEntries.length,
                    itemBuilder: (context, index) {
                      return _buildLedgerCard(_filteredEntries[index]);
                    },
                  ),
            // child: _filteredEntries.isEmpty
            //     ? _buildEmptyState()
            //     : ListView.builder(
            //         padding: EdgeInsets.symmetric(horizontal: 16.w),
            //         itemCount: _filteredEntries.length,
            //         itemBuilder: (context, index) {
            //           return _buildLedgerCard(_filteredEntries[index]);
            //         },
            //       ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddEntryDialog();
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add, color: MyColor.onPrimary),
        label: Text(
          'Add Entry',
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
          colors: [MyColor.primary, MyColor.primary.withOpacity(0.85)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.primary.withOpacity(0.25),
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
                  Icons.account_balance,
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
                      'Current Balance',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳${_balance.toStringAsFixed(2)}',
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
                  color: _balance >= 0
                      ? MyColor.success.withOpacity(0.2)
                      : MyColor.error.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _balance >= 0 ? Icons.trending_up : Icons.trending_down,
                      color: MyColor.white,
                      size: 16.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _balance >= 0 ? 'Profit' : 'Loss',
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
                  icon: Icons.arrow_downward,
                  label: 'Income',
                  value: '৳${_totalIncome.toStringAsFixed(0)}',
                  color: MyColor.success,
                ),
              ),
              Container(
                width: 1.w,
                height: 50.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.arrow_upward,
                  label: 'Expense',
                  value: '৳${_totalExpense.toStringAsFixed(0)}',
                  color: MyColor.error,
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
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: MyColor.white, size: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: MyColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
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

  Widget _buildPeriodSelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: MyColor.gray100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(child: _buildPeriodOption('Today', 'today')),
          Expanded(child: _buildPeriodOption('Week', 'week')),
          Expanded(child: _buildPeriodOption('Month', 'month')),
          Expanded(child: _buildPeriodOption('Year', 'year')),
        ],
      ),
    );
  }

  Widget _buildPeriodOption(String label, String value) {
    final isSelected = _selectedPeriod == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPeriod = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: MyColor.gray200.withOpacity(0.5),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? MyColor.primary : MyColor.gray600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildFilterChip('All', 'all', _filteredEntries.length),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Income',
            'income',
            _filteredEntries.where((e) => e.type == 'income').length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Expense',
            'expense',
            _filteredEntries.where((e) => e.type == 'expense').length,
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

  Widget _buildLedgerCard(LedgerEntry entry) {
    final isIncome = entry.type == 'income';
    final color = isIncome ? MyColor.success : MyColor.error;
    final icon = isIncome ? Icons.arrow_downward : Icons.arrow_upward;

    final isToday =
        entry.date.year == DateTime.now().year &&
        entry.date.month == DateTime.now().month &&
        entry.date.day == DateTime.now().day;

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
            // View entry details
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: color, size: 24.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.category,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        entry.description,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12.sp,
                            color: MyColor.gray500,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            isToday
                                ? _formatTime(entry.date)
                                : '${_formatDate(entry.date)} • ${_formatTime(entry.date)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: MyColor.gray500,
                                  fontSize: 11.sp,
                                ),
                          ),
                          SizedBox(width: 8.w),
                          if (entry.reference != null)
                            Container(
                              width: 3.w,
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: MyColor.gray400,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '• Ref: ${entry.reference}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: MyColor.gray500,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.gray100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        entry.paymentMethod,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: MyColor.gray600,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '${isIncome ? '+' : '-'}৳${entry.amount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
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
          Icon(
            Icons.receipt_long_outlined,
            size: 80.sp,
            color: MyColor.gray300,
          ),
          SizedBox(height: 16.h),
          Text(
            'No transactions found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: MyColor.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your filters',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
          ),
        ],
      ),
    );
  }

  void _showAddEntryDialog() {
    // Show dialog to add new ledger entry
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Ledger Entry'),
        content: Text('Entry form will be here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Entry added successfully!'),
                  backgroundColor: MyColor.success,
                ),
              );
            },
            child: Text('Add'),
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
    return '${months[date.month - 1]} ${date.day}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final period = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}

// Model
class LedgerEntry {
  final String id;
  final String type; // 'income' or 'expense'
  final String category;
  final String description;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String? reference;

  LedgerEntry({
    required this.id,
    required this.type,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    this.reference,
  });
}
