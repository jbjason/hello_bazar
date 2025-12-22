class StockItem {
  final String productId;
  final String productName;
  final String sku;
  final String category;
  final int currentStock;
  final int minStock;
  final int maxStock;
  final int reorderPoint;
  final String unit;
  final double costPerUnit;
  final DateTime lastRestocked;
  final String supplier;

  StockItem({
    required this.productId,
    required this.productName,
    required this.sku,
    required this.category,
    required this.currentStock,
    required this.minStock,
    required this.maxStock,
    required this.reorderPoint,
    required this.unit,
    required this.costPerUnit,
    required this.lastRestocked,
    required this.supplier,
  });

  // Getter for stock status
  String get stockStatus {
    if (currentStock <= 0) {
      return 'out-of-stock'; // You might want to handle this case
    } else if (currentStock < minStock) {
      return 'critical';
    } else if (currentStock < reorderPoint) {
      return 'low';
    } else if (currentStock > maxStock) {
      return 'overstocked';
    } else {
      return 'adequate';
    }
  }

  // Getter for stock value (current stock value)
  double get stockValue => currentStock * costPerUnit;

  // Getter to check if needs reorder
  bool get needsReorder => currentStock <= reorderPoint;

  // Getter for stock percentage (0.0 to 1.0)
  double get stockPercentage {
    if (maxStock <= 0) return 0.0;
    return currentStock / maxStock;
  }

  // Getter for days since last restocked
  int get daysSinceLastRestocked {
    final now = DateTime.now();
    return now.difference(lastRestocked).inDays;
  }

  // CopyWith method
  StockItem copyWith({
    String? productId,
    String? productName,
    String? sku,
    String? category,
    int? currentStock,
    int? minStock,
    int? maxStock,
    int? reorderPoint,
    String? unit,
    double? costPerUnit,
    DateTime? lastRestocked,
    String? supplier,
  }) {
    return StockItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      currentStock: currentStock ?? this.currentStock,
      minStock: minStock ?? this.minStock,
      maxStock: maxStock ?? this.maxStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      unit: unit ?? this.unit,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      lastRestocked: lastRestocked ?? this.lastRestocked,
      supplier: supplier ?? this.supplier,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'sku': sku,
      'category': category,
      'currentStock': currentStock,
      'minStock': minStock,
      'maxStock': maxStock,
      'reorderPoint': reorderPoint,
      'unit': unit,
      'costPerUnit': costPerUnit,
      'lastRestocked': lastRestocked.toIso8601String(),
      'supplier': supplier,
      // Note: stockStatus and stockValue are computed, so we include them
      'stockStatus': stockStatus,
      'stockValue': stockValue,
    };
  }

  // From JSON
  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      sku: json['sku'] as String,
      category: json['category'] as String,
      currentStock: json['currentStock'] as int,
      minStock: json['minStock'] as int,
      maxStock: json['maxStock'] as int,
      reorderPoint: json['reorderPoint'] as int,
      unit: json['unit'] as String,
      costPerUnit: (json['costPerUnit'] as num).toDouble(),
      lastRestocked: DateTime.parse(json['lastRestocked'] as String),
      supplier: json['supplier'] as String,
    );
  }

  @override
  String toString() {
    return 'StockItem{productId: $productId, productName: $productName, currentStock: $currentStock, stockStatus: $stockStatus, stockValue: $stockValue}';
  }
}