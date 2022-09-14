import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dealwithcsvfiles/data/toast.dart';
import 'package:excel_kit/excel_kit.dart';
import 'package:excel_kit/sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'data/model/file_data.dart';

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileInitial());

  static FileCubit get(BuildContext context) => BlocProvider.of(context);
  static String path = '';

  Future getExcelPath(String name) async {
    path = await saveFile(name);
  }

  Future<String> saveFile(String name) async {
    String excelPath = (await getApplicationDocumentsDirectory()).path;

    return '$excelPath/$name.xlsx';
  }

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (result.files.single.path!.contains('.xlsx')) {
        getData(result.files.single.path!);
      }
    } else {
      Toasts.customToast(customMsg: "In correct file Type", backgroundColor: Colors.red);
    }
  }

  static double getAvrage({required List<FileData> fileData, required String name}) {
    return fileData.where((e) => e.name == name).map((e) => e.amount!).toList().sum / fileData.length;
  }

  static int getCount({required List<FileData> fileData, required String name, required String brand}) {
    return fileData.where((e) => e.name == name).where((e) => e.name == name && e.brand == brand).toList().length;
  }

  List<FileData> fileData = [];
  Map<String, String> productAverageMap = {};
  Map<String, String> productBrandMap = {};
  getData(String filePath) {
    Map<String, String> fieldMap = {
      "id": "id",
      "area": "area",
      "name": "name",
      "amount": "amount",
      "brand": "brand",
    };
    var sheet = ExcelKit.readFile(filePath).getSheet("Sheet1", fieldMap: fieldMap);

// get data list
    var dataList = sheet.getDataList();
    fileData = fileDataFromJson(jsonEncode(dataList));

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
    emit(FileLoaded());
    print(productAverageMap);
    print(productBrandMap);
  }

  generateReportAverage(BuildContext context) async {
    await getExcelPath('Product average report');
    List<Map<String, String>> sheetList = [];
    Map<String, String> sellerExcelHeaders = {
      "name": "Name",
      "average": 'Average',
    };
    sheetList = productAverageMap.entries.map((e) => {'Name': e.key, 'Average': e.value}).toList();

    ExcelKit.writeFile(path, [SheetOption("Sheet1", sheetList, fieldMap: sellerExcelHeaders)]);

    final box = context.findRenderObject() as RenderBox?;

    await Share.shareFilesWithResult(
      [path],
      subject: 'Read Excel File',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  generateBrandAverage(BuildContext context) async {
    await getExcelPath('Product Brand report');
    List<Map<String, String>> sheetList = [];
    Map<String, String> sellerExcelHeaders = {
      "name": "Name",
      "brand": 'Brand',
    };
    sheetList = productBrandMap.entries.map((e) => {'Name': e.key, 'Brand': e.value}).toList();

    ExcelKit.writeFile(path, [SheetOption("Sheet1", sheetList, fieldMap: sellerExcelHeaders)]);

    final box = context.findRenderObject() as RenderBox?;

    await Share.shareFilesWithResult(
      [path],
      subject: 'Read Excel File',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
