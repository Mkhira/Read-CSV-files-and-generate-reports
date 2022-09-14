import 'dart:convert';

List<FileData> fileDataFromJson(String str) => List<FileData>.from(json.decode(str).map((x) => FileData.fromJson(x)));

String fileDataToJson(List<FileData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileData {
  int? id;
  String? name;
  String? area;
  int? amount;
  String? brand;

  FileData({this.id, this.name, this.area, this.amount, this.brand});

  factory FileData.fromJson(Map<String, dynamic> json) => FileData(
        id: json["id"],
        area: json["area"],
        name: json["name"],
        amount: json["amount"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "name": name,
        "amount": amount,
        "brand": brand,
      };
}
