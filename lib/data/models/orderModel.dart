class OrderModel {
  final String id;
  final String orderId;
  final String customerName;
  final int items;
  final double amount;
  final String status;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.items,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    return OrderModel(
      id: id,
      orderId: map['orderId'],
      customerName: map['customerName'],
      items: map['items'],
      amount: (map['amount']).toDouble(),
      status: map['status'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "customerName": customerName,
      "items": items,
      "amount": amount,
      "status": status,
      "date": date.toIso8601String(),
    };
  }
}
