import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/product/presentation/screen/product_add_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter =
      'all'; // 'all', 'in_stock', 'low_stock', 'out_of_stock'
  String _selectedCategory = 'all'; // 'all', category names

  final List<Product> _products = [
    Product(
      id: 'PRD001',
      name: 'Premium Basmati Rice 5kg',
      category: 'Grains',
      sku: 'RICE-5KG-001',
      price: 850.00,
      cost: 650.00,
      stock: 145,
      minStock: 20,
      unit: 'pcs',
      image: '',
      status: 'in_stock',
      barcode: '8901234567890',
    ),
    Product(
      id: 'PRD002',
      name: 'Sunflower Oil 5L',
      category: 'Cooking Oil',
      sku: 'OIL-5L-002',
      price: 1200.00,
      cost: 950.00,
      stock: 15,
      minStock: 20,
      unit: 'pcs',
      image: '',
      status: 'low_stock',
      barcode: '8901234567891',
    ),
    Product(
      id: 'PRD003',
      name: 'Refined Sugar 1kg',
      category: 'Sugar & Salt',
      sku: 'SUG-1KG-003',
      price: 120.00,
      cost: 95.00,
      stock: 0,
      minStock: 30,
      unit: 'pcs',
      image: '',
      status: 'out_of_stock',
      barcode: '8901234567892',
    ),
    Product(
      id: 'PRD004',
      name: 'Whole Wheat Flour 2kg',
      category: 'Flour',
      sku: 'FLOUR-2KG-004',
      price: 180.00,
      cost: 140.00,
      stock: 85,
      minStock: 25,
      unit: 'pcs',
      image: '',
      status: 'in_stock',
      barcode: '8901234567893',
    ),
    Product(
      id: 'PRD005',
      name: 'Green Tea 250g',
      category: 'Beverages',
      sku: 'TEA-250G-005',
      price: 450.00,
      cost: 320.00,
      stock: 18,
      minStock: 15,
      unit: 'pcs',
      image: '',
      status: 'low_stock',
      barcode: '8901234567894',
    ),
    Product(
      id: 'PRD006',
      name: 'Fresh Milk 1L',
      category: 'Dairy',
      sku: 'MILK-1L-006',
      price: 120.00,
      cost: 90.00,
      stock: 65,
      minStock: 30,
      unit: 'pcs',
      image: '',
      status: 'in_stock',
      barcode: '8901234567895',
    ),
    Product(
      id: 'PRD007',
      name: 'Chocolate Biscuits 200g',
      category: 'Snacks',
      sku: 'BISC-200G-007',
      price: 85.00,
      cost: 60.00,
      stock: 12,
      minStock: 25,
      unit: 'pcs',
      image: '',
      status: 'low_stock',
      barcode: '8901234567896',
    ),
    Product(
      id: 'PRD008',
      name: 'Organic Honey 500g',
      category: 'Organic',
      sku: 'HON-500G-008',
      price: 650.00,
      cost: 480.00,
      stock: 42,
      minStock: 10,
      unit: 'pcs',
      image: '',
      status: 'in_stock',
      barcode: '8901234567897',
    ),
  ];

  List<Product> get _filteredProducts {
    var filtered = _products.where((product) {
      final matchesSearch =
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.sku.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.barcode.contains(_searchQuery);

      if (!matchesSearch) return false;

      // Filter by status
      if (_selectedFilter == 'in_stock' && product.status != 'in_stock')
        return false;
      if (_selectedFilter == 'low_stock' && product.status != 'low_stock')
        return false;
      if (_selectedFilter == 'out_of_stock' && product.status != 'out_of_stock')
        return false;

      // Filter by category
      if (_selectedCategory != 'all' && product.category != _selectedCategory)
        return false;

      return true;
    }).toList();

    filtered.sort((a, b) => a.name.compareTo(b.name));
    return filtered;
  }

  List<String> get _categories {
    final categories = _products.map((p) => p.category).toSet().toList();
    categories.sort();
    return ['all', ...categories];
  }

  int get _totalProducts => _products.length;
  int get _lowStockCount =>
      _products.where((p) => p.status == 'low_stock').length;
  int get _outOfStockCount =>
      _products.where((p) => p.status == 'out_of_stock').length;
  double get _totalInventoryValue =>
      _products.fold(0.0, (sum, p) => sum + (p.cost * p.stock));

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
        title: Text('Products', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Scan barcode
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
                hintText: 'Search by name, SKU or barcode',
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

          // Category Selector
          _buildCategorySelector(),

          SizedBox(height: 12.h),

          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: 12.h),

          // Product Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredProducts.length} Products',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.gray600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Sort by: Name',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Product List
          Expanded(
            child: _filteredProducts.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(_filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductAddScreen()),
          );
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add, color: MyColor.onPrimary),
        label: Text(
          'Add Product',
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
                child: Icon(Icons.inventory, color: MyColor.white, size: 32.w),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Products',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '$_totalProducts',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: MyColor.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_lowStockCount > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.warning.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: MyColor.white,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$_lowStockCount Low',
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
                  if (_outOfStockCount > 0) ...[
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.error.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.block, color: MyColor.white, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            '$_outOfStockCount Out',
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
                  icon: Icons.category,
                  label: 'Categories',
                  value: '${_categories.length - 1}',
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.attach_money,
                  label: 'Inventory Value',
                  value:
                      '৳${(_totalInventoryValue / 1000).toStringAsFixed(0)}K',
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

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ChoiceChip(
              label: Text(category == 'all' ? 'All Categories' : category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              backgroundColor: MyColor.surfaceContainerLowest,
              selectedColor: MyColor.primary.withOpacity(0.15),
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected ? MyColor.primary : MyColor.gray600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? MyColor.primary : MyColor.outlineVariant,
                width: isSelected ? 1.5.w : 1.w,
              ),
              checkmarkColor: MyColor.primary,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildFilterChip('All', 'all', _products.length),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'In Stock',
            'in_stock',
            _products.where((p) => p.status == 'in_stock').length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip('Low Stock', 'low_stock', _lowStockCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Out of Stock', 'out_of_stock', _outOfStockCount),
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

  Widget _buildProductCard(Product product) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (product.status) {
      case 'in_stock':
        statusColor = MyColor.success;
        statusIcon = Icons.check_circle;
        statusText = 'In Stock';
        break;
      case 'low_stock':
        statusColor = MyColor.warning;
        statusIcon = Icons.warning_amber;
        statusText = 'Low Stock';
        break;
      default:
        statusColor = MyColor.error;
        statusIcon = Icons.block;
        statusText = 'Out of Stock';
    }

    final profitMargin = ((product.price - product.cost) / product.price * 100);

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
            // Navigate to product detail page
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Product Image/Icon
                Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: MyColor.primaryFixed,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.shopping_bag,
                    color: MyColor.primary,
                    size: 32.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
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
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  statusIcon,
                                  color: statusColor,
                                  size: 12.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  statusText,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      ),
                                ),
                              ],
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
                              color: MyColor.gray100,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              product.category,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: MyColor.gray600,
                                    fontSize: 10.sp,
                                  ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'SKU: ${product.sku}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: MyColor.gray500,
                                  fontSize: 11.sp,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '৳${product.price.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: MyColor.success,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                ),
                                Text(
                                  'Cost: ৳${product.cost.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: MyColor.gray500,
                                        fontSize: 10.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: product.stock <= product.minStock
                                  ? MyColor.error.withOpacity(0.1)
                                  : MyColor.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${product.stock}',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: product.stock <= product.minStock
                                            ? MyColor.error
                                            : MyColor.success,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                ),
                                Text(
                                  'Stock',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: product.stock <= product.minStock
                                            ? MyColor.error
                                            : MyColor.success,
                                        fontSize: 9.sp,
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
            'No products found',
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
}

// Model
class Product {
  final String id;
  final String name;
  final String category;
  final String sku;
  final double price;
  final double cost;
  final int stock;
  final int minStock;
  final String unit;
  final String image;
  final String status; // 'in_stock', 'low_stock', 'out_of_stock'
  final String barcode;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.sku,
    required this.price,
    required this.cost,
    required this.stock,
    required this.minStock,
    required this.unit,
    required this.image,
    required this.status,
    required this.barcode,
  });

  double get profit => price - cost;
  double get profitMargin => (profit / price) * 100;
  double get stockValue => cost * stock;
}
