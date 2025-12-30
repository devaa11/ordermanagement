class Productmodel {
  final String id;
  final String productName;
  final double amount;
  final String description;
  final String type;

  Productmodel({
    required this.id,
    required this.productName,
    required this.description,
    required this.amount,
    required this.type
  });

  factory Productmodel.fromMap(Map<String, dynamic> map, String id) {
    return Productmodel(
      id: id,
      productName: map['productName'],
      description: map['description'],
      amount: (map['amount'] as num).toDouble(),
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productName": productName,
      "amount": amount,
      "type": type,
      "description" :description
    };
  }
}
