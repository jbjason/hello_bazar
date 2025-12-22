import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});
  @override
  State<WarehouseScreen> createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'active', 'inactive', 'main'

  final List<Warehouse> _warehouses = [
    Warehouse(
      id: 'WH001',
      name: 'Main Warehouse',
      code: 'MAIN-001',
      address: '123 Business Street, Dhaka 1212',
      contactPerson: 'Md. Rahman',
      contactNumber: '+880 1712 345678',
      email: 'main@loyaltyplus.com',
      totalCapacity: 5000.0,
      usedCapacity: 3200.0,
      totalItems: 1250,
      isActive: true,
      warehouseType: 'main',
      lastInventoryDate: DateTime(2024, 12, 15),
      manager: 'A.K. Alam',
    ),
    Warehouse(
      id: 'WH002',
      name: 'North Branch Warehouse',
      code: 'NORTH-002',
      address: '456 North Avenue, Uttara, Dhaka',
      contactPerson: 'Ms. Fatima Begum',
      contactNumber: '+880 1712 987654',
      email: 'north@loyaltyplus.com',
      totalCapacity: 2500.0,
      usedCapacity: 1800.0,
      totalItems: 750,
      isActive: true,
      warehouseType: 'branch',
      lastInventoryDate: DateTime(2024, 12, 10),
      manager: 'S. Hossain',
    ),
    Warehouse(
      id: 'WH003',
      name: 'South Distribution Center',
      code: 'SOUTH-003',
      address: '789 South Road, Mirpur, Dhaka',
      contactPerson: 'Mr. Karim Ahmed',
      contactNumber: '+880 1713 456789',
      email: 'south@loyaltyplus.com',
      totalCapacity: 4000.0,
      usedCapacity: 2900.0,
      totalItems: 980,
      isActive: true,
      warehouseType: 'distribution',
      lastInventoryDate: DateTime(2024, 12, 12),
      manager: 'R. Khan',
    ),
    Warehouse(
      id: 'WH004',
      name: 'East Cold Storage',
      code: 'EAST-004',
      address: '321 East Lane, Banani, Dhaka',
      contactPerson: 'Ms. Sabina Akter',
      contactNumber: '+880 1714 567890',
      email: 'east@loyaltyplus.com',
      totalCapacity: 1500.0,
      usedCapacity: 850.0,
      totalItems: 320,
      isActive: true,
      warehouseType: 'cold',
      lastInventoryDate: DateTime(2024, 12, 18),
      manager: 'M. Ali',
    ),
    Warehouse(
      id: 'WH005',
      name: 'West Fulfillment Center',
      code: 'WEST-005',
      address: '654 West Bazar, Dhanmondi, Dhaka',
      contactPerson: 'Mr. Jamal Uddin',
      contactNumber: '+880 1715 678901',
      email: 'west@loyaltyplus.com',
      totalCapacity: 3000.0,
      usedCapacity: 2200.0,
      totalItems: 650,
      isActive: true,
      warehouseType: 'fulfillment',
      lastInventoryDate: DateTime(2024, 12, 14),
      manager: 'T. Ahmed',
    ),
    Warehouse(
      id: 'WH006',
      name: 'Old Storage (Inactive)',
      code: 'OLD-006',
      address: '987 Old Market, Lalbagh, Dhaka',
      contactPerson: 'Mr. Abdul Malek',
      contactNumber: '+880 1716 789012',
      email: 'old@loyaltyplus.com',
      totalCapacity: 2000.0,
      usedCapacity: 500.0,
      totalItems: 150,
      isActive: false,
      warehouseType: 'storage',
      lastInventoryDate: DateTime(2024, 10, 30),
      manager: 'N. Islam',
    ),
    Warehouse(
      id: 'WH007',
      name: 'Central Logistics Hub',
      code: 'CENTRAL-007',
      address: '147 Central Plaza, Motijheel, Dhaka',
      contactPerson: 'Ms. Nusrat Jahan',
      contactNumber: '+880 1717 890123',
      email: 'central@loyaltyplus.com',
      totalCapacity: 6000.0,
      usedCapacity: 4200.0,
      totalItems: 1350,
      isActive: true,
      warehouseType: 'logistics',
      lastInventoryDate: DateTime(2024, 12, 16),
      manager: 'K. Rahman',
    ),
    Warehouse(
      id: 'WH008',
      name: 'Express Delivery Center',
      code: 'EXPRESS-008',
      address: '258 Express Road, Gulshan, Dhaka',
      contactPerson: 'Mr. Farid Uddin',
      contactNumber: '+880 1718 901234',
      email: 'express@loyaltyplus.com',
      totalCapacity: 1800.0,
      usedCapacity: 1200.0,
      totalItems: 420,
      isActive: true,
      warehouseType: 'express',
      lastInventoryDate: DateTime(2024, 12, 19),
      manager: 'S. Chowdhury',
    ),
  ];

  List<Warehouse> get _filteredWarehouses {
    var filtered = _warehouses.where((warehouse) {
      final matchesSearch = warehouse.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          warehouse.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          warehouse.address.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      switch (_selectedFilter) {
        case 'active':
          return warehouse.isActive;
        case 'inactive':
          return !warehouse.isActive;
        case 'main':
          return warehouse.warehouseType == 'main';
        default:
          return true;
      }
    }).toList();

    // Sort by active status first, then by capacity usage
    filtered.sort((a, b) {
      if (a.isActive != b.isActive) {
        return b.isActive ? 1 : -1;
      }
      final aUsage = a.usedCapacity / a.totalCapacity;
      final bUsage = b.usedCapacity / b.totalCapacity;
      return bUsage.compareTo(aUsage);
    });

    return filtered;
  }

  int get _activeCount =>
      _warehouses.where((w) => w.isActive).length;
  int get _inactiveCount =>
      _warehouses.where((w) => !w.isActive).length;
  int get _mainWarehouseCount =>
      _warehouses.where((w) => w.warehouseType == 'main').length;
  
  double get _totalCapacity =>
      _warehouses.fold(0.0, (sum, w) => sum + w.totalCapacity);
  double get _totalUsedCapacity =>
      _warehouses.fold(0.0, (sum, w) => sum + w.usedCapacity);
  int get _totalItems =>
      _warehouses.fold(0, (sum, w) => sum + w.totalItems);

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
        title: Text(
          'Warehouse Management',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: MyColor.onSurfaceVariant),
            onPressed: () {
              _showAddWarehouseDialog();
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

          // Capacity Alert
          if ((_totalUsedCapacity / _totalCapacity) > 0.8)
            _buildCapacityAlert(),

          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name, code or address',
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

          // Warehouse Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredWarehouses.length} Warehouses',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.gray600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Sort by: Active → Usage',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Warehouse List
          Expanded(
            child: _filteredWarehouses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    itemCount: _filteredWarehouses.length,
                    itemBuilder: (context, index) {
                      return _buildWarehouseCard(_filteredWarehouses[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddWarehouseDialog();
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add_location_alt, color: MyColor.onPrimary),
        label: Text(
          'Add Warehouse',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBanner() {
    final capacityUsage = (_totalUsedCapacity / _totalCapacity) * 100;
    
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366F1),
            Color(0xFF8B5CF6),
          ],
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
                child: Icon(Icons.warehouse_outlined, color: MyColor.white, size: 32.w),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Storage Capacity',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '${_totalCapacity.toInt()} sq.ft',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: MyColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${_totalUsedCapacity.toInt()} sq.ft used (${capacityUsage.toStringAsFixed(1)}%)',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: MyColor.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: MyColor.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: MyColor.white,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '$_activeCount Active',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: MyColor.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: MyColor.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inventory_2,
                          color: MyColor.white,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '$_totalItems Items',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: MyColor.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                  icon: Icons.storefront,
                  label: 'Total Warehouses',
                  value: '${_warehouses.length}',
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.business,
                  label: 'Main Warehouse',
                  value: '$_mainWarehouseCount',
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.pause_circle,
                  label: 'Inactive',
                  value: '$_inactiveCount',
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
        Icon(icon, color: MyColor.white, size: 20.sp),
        SizedBox(height: 6.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: MyColor.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: MyColor.white.withOpacity(0.85),
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCapacityAlert() {
    final usagePercent = (_totalUsedCapacity / _totalCapacity) * 100;
    Color alertColor = usagePercent > 90 ? MyColor.error : MyColor.warning;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: alertColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: alertColor, width: 1.w),
      ),
      child: Row(
        children: [
          Icon(
            usagePercent > 90 ? Icons.error_outline : Icons.warning_amber,
            color: alertColor,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usagePercent > 90 
                    ? 'High Storage Alert!' 
                    : 'Storage Capacity Warning',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: alertColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Overall storage is ${usagePercent.toStringAsFixed(1)}% full. Consider adding more space.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.gray700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: alertColor,
            size: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildFilterChip('All', 'all', _warehouses.length),
          SizedBox(width: 8.w),
          _buildFilterChip('Active', 'active', _activeCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Inactive', 'inactive', _inactiveCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Main', 'main', _mainWarehouseCount),
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

  Widget _buildWarehouseCard(Warehouse warehouse) {
    final capacityPercent = (warehouse.usedCapacity / warehouse.totalCapacity) * 100;
    Color capacityColor;
    String capacityStatus;
    
    if (capacityPercent >= 90) {
      capacityColor = MyColor.error;
      capacityStatus = 'CRITICAL';
    } else if (capacityPercent >= 75) {
      capacityColor = MyColor.warning;
      capacityStatus = 'HIGH';
    } else if (capacityPercent >= 50) {
      capacityColor = Color(0xFF0984E3);
      capacityStatus = 'MODERATE';
    } else {
      capacityColor = MyColor.success;
      capacityStatus = 'LOW';
    }

    final warehouseTypeIcons = {
      'main': Icons.business,
      'branch': Icons.store,
      'distribution': Icons.local_shipping,
      'cold': Icons.ac_unit,
      'fulfillment': Icons.inventory,
      'storage': Icons.storage,
      'logistics': Icons.directions_car,
      'express': Icons.flash_on,
    };

    final warehouseTypeLabels = {
      'main': 'Main',
      'branch': 'Branch',
      'distribution': 'Distribution',
      'cold': 'Cold Storage',
      'fulfillment': 'Fulfillment',
      'storage': 'Storage',
      'logistics': 'Logistics',
      'express': 'Express',
    };

    final daysSinceInventory = DateTime.now()
        .difference(warehouse.lastInventoryDate)
        .inDays;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: warehouse.isActive 
            ? MyColor.surfaceContainerLowest 
            : MyColor.gray100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: warehouse.isActive 
              ? MyColor.outlineVariant 
              : MyColor.gray300,
          width: 1.w,
        ),
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
            _showWarehouseDetailDialog(warehouse);
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: capacityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        warehouseTypeIcons[warehouse.warehouseType] ?? Icons.warehouse,
                        color: capacityColor,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  warehouse.name,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        color: warehouse.isActive 
                                            ? MyColor.onSurface 
                                            : MyColor.gray600,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (!warehouse.isActive)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor.gray200,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    'INACTIVE',
                                    style: Theme.of(context).textTheme.labelSmall
                                        ?.copyWith(
                                          color: MyColor.gray600,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: MyColor.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  warehouseTypeLabels[warehouse.warehouseType] ?? 'Unknown',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: MyColor.primary,
                                        fontSize: 10.sp,
                                      ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  'Code: ${warehouse.code}',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: warehouse.isActive 
                                            ? MyColor.gray500 
                                            : MyColor.gray400,
                                        fontSize: 11.sp,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: capacityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.data_usage,
                            color: capacityColor,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            capacityStatus,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: capacityColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Capacity Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Used: ${warehouse.usedCapacity.toInt()} sq.ft',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Total: ${warehouse.totalCapacity.toInt()} sq.ft',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: MyColor.gray500),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: warehouse.usedCapacity / warehouse.totalCapacity,
                        backgroundColor: MyColor.gray200,
                        valueColor: AlwaysStoppedAnimation<Color>(capacityColor),
                        minHeight: 8.h,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${capacityPercent.toStringAsFixed(1)}% Full',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: MyColor.gray600),
                        ),
                        Text(
                          '${warehouse.totalItems} Items',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: MyColor.primary),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(height: 1.h, color: MyColor.outlineVariant),
                SizedBox(height: 12.h),
                // Additional Info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: MyColor.gray500),
                          ),
                          Text(
                            warehouse.address.split(', ').first,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Last Inventory',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: MyColor.gray500),
                          ),
                          Text(
                            daysSinceInventory == 0
                                ? 'Today'
                                : daysSinceInventory == 1
                                    ? 'Yesterday'
                                    : '$daysSinceInventory days ago',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: daysSinceInventory > 30 
                                      ? MyColor.warning 
                                      : MyColor.gray700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Manager: ${warehouse.manager}',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(
                              color: MyColor.gray600,
                              fontSize: 11.sp,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: warehouse.isActive 
                            ? MyColor.primary.withOpacity(0.1)
                            : MyColor.gray200,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone,
                            size: 12.sp,
                            color: warehouse.isActive 
                                ? MyColor.primary 
                                : MyColor.gray500,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${warehouse.contactNumber.substring(0, 11)}...',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: warehouse.isActive 
                                      ? MyColor.primary 
                                      : MyColor.gray500,
                                  fontSize: 10.sp,
                                ),
                          ),
                        ],
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
          Icon(Icons.warehouse_outlined, size: 80.sp, color: MyColor.gray300),
          SizedBox(height: 16.h),
          Text(
            'No warehouses found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: MyColor.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: MyColor.gray500,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              _showAddWarehouseDialog();
            },
            child: Text('Add First Warehouse'),
          ),
        ],
      ),
    );
  }

  void _showWarehouseDetailDialog(Warehouse warehouse) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Warehouse Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.business, color: MyColor.primary),
                title: Text('Name'),
                subtitle: Text(warehouse.name),
              ),
              ListTile(
                leading: Icon(Icons.code, color: MyColor.gray600),
                title: Text('Warehouse Code'),
                subtitle: Text(warehouse.code),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: MyColor.gray600),
                title: Text('Address'),
                subtitle: Text(warehouse.address),
              ),
              ListTile(
                leading: Icon(Icons.phone, color: MyColor.gray600),
                title: Text('Contact'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(warehouse.contactPerson),
                    Text(warehouse.contactNumber),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: MyColor.gray600),
                title: Text('Manager'),
                subtitle: Text(warehouse.manager),
              ),
              ListTile(
                leading: Icon(Icons.storage, color: MyColor.gray600),
                title: Text('Capacity'),
                subtitle: Text(
                    '${warehouse.usedCapacity.toInt()} / ${warehouse.totalCapacity.toInt()} sq.ft (${((warehouse.usedCapacity / warehouse.totalCapacity) * 100).toStringAsFixed(1)}%)'),
              ),
              ListTile(
                leading: Icon(Icons.inventory_2, color: MyColor.gray600),
                title: Text('Items in Storage'),
                subtitle: Text('${warehouse.totalItems} items'),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: MyColor.gray600),
                title: Text('Last Inventory'),
                subtitle: Text('${warehouse.lastInventoryDate.day}/${warehouse.lastInventoryDate.month}/${warehouse.lastInventoryDate.year}'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Edit warehouse
              Navigator.pop(context);
            },
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _showAddWarehouseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Warehouse'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Warehouse Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Warehouse Code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add warehouse logic
              Navigator.pop(context);
            },
            child: Text('Add Warehouse'),
          ),
        ],
      ),
    );
  }
}

class Warehouse {
  final String id;
  final String name;
  final String code;
  final String address;
  final String contactPerson;
  final String contactNumber;
  final String email;
  final double totalCapacity; // in square feet
  final double usedCapacity; // in square feet
  final int totalItems;
  final bool isActive;
  final String warehouseType; // 'main', 'branch', 'distribution', 'cold', 'fulfillment', 'storage', 'logistics', 'express'
  final DateTime lastInventoryDate;
  final String manager;

  Warehouse({
    required this.id,
    required this.name,
    required this.code,
    required this.address,
    required this.contactPerson,
    required this.contactNumber,
    required this.email,
    required this.totalCapacity,
    required this.usedCapacity,
    required this.totalItems,
    required this.isActive,
    required this.warehouseType,
    required this.lastInventoryDate,
    required this.manager,
  });
}