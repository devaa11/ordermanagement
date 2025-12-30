// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  DateTime? createdAt;
  String? pName;
  String? pDesc;
  double? pAmount;
  String? pType;
  String? id;

  ProductModel({
    this.createdAt,
    this.pName,
    this.pDesc,
    this.pAmount,
    this.pType,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    pName: json["p_name"],
    pDesc: json["p_desc"],
    pAmount: double.parse(json["p_amount"].toString()),
    pType: json["p_type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "p_name": pName,
    "p_desc": pDesc,
    "p_amount": pAmount,
    "p_type": pType,
    "id": id,
  };
}
