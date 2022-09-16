import 'package:collection/collection.dart';
import 'package:dealwithcsvfiles/data/toast.dart';
import 'package:flutter/material.dart';

import 'data/model/file_data.dart';

class Controller {
  Map<String, String> productAverageMap = {};
  Map<String, String> productBrandMap = {};

  static double getAvrage({required List<FileData> fileData, required String name}) {
    return fileData.where((e) => e.name == name).map((e) => e.amount!).toList().sum / fileData.length;
  }

  static int getCount({required List<FileData> fileData, required String name, required String brand}) {
    return fileData.where((e) => e.name == name).where((e) => e.name == name && e.brand == brand).toList().length;
  }

  Map<String, Map<String, String>> getData(List<String> dataList) {
    List<FileData> fileData = dataList
        .map((e) => FileData(
            id: e.split(',')[0],
            area: e.split(',')[1],
            name: e.split(',')[2],
            amount: int.tryParse(e.split(',')[3]) ?? 0,
            brand: e.split(',')[4]))
        .toList();

    try {
      for (var element in fileData) {
        if (!productAverageMap.containsKey(element.name)) {
          productAverageMap.addAll({element.name!: '${getAvrage(fileData: fileData, name: element.name!)}'});
        }

        if (!productBrandMap.containsKey(element.name)) {
          productBrandMap.addAll({element.name!: element.brand!});
        } else {
          if (getCount(fileData: fileData, name: element.name!, brand: element.brand!) >
              getCount(name: element.name!, brand: productBrandMap[element.name!]!, fileData: fileData)) {
            productBrandMap.update(element.name!, (value) => element.brand!);
          }
        }
      }
    } on Exception catch (e) {
      Toasts.customToast(customMsg: "Error while reading file Data", backgroundColor: Colors.red);
    }
    print(productAverageMap);
    print(productBrandMap);

    return {'productAverageMap': productAverageMap, 'productBrandMap': productBrandMap};
  }
}
