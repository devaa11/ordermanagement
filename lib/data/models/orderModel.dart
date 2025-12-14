class Order {
  final String id;
  final String customerName;
  final String status;
  final double total;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.customerName,
    required this.status,
    required this.total,
    required this.createdAt,
  });

  Order copyWith({String? customerName, String? status, double? total}) {
    return Order(
      id: id,
      customerName: customerName ?? this.customerName,
      status: status ?? this.status,
      total: total ?? this.total,
      createdAt: createdAt,
    );
  }

  factory Order.fromMap(Map<String, dynamic> map, String id) {
    return Order(
      id: id,
      customerName: map['customerName'] ?? '',
      status: map['status'] ?? 'pending',
      total: (map['total'] ?? 0).toDouble(),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'status': status,
      'total': total,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
