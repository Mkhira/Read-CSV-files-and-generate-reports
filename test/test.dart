import 'package:dealwithcsvfiles/controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test the Excel file reading first list', () {
    List<String> dataList1 = [
      'ID1,Minneapolis,shoes,2,Air',
      'ID2,Chicago,shoes,1,Air',
      'ID3,Central Department Store,shoes,5,BonPied',
      'ID4,Quail Hollow,forks,3,Pfitzcraft'
    ];
    Controller controller = Controller();
    Map<String, Map<String, String>> value1 = controller.getData(dataList1);
    expect(value1, {
      'productAverageMap': {'shoes': '2.0', 'forks': '0.75'},
      'productBrandMap': {'shoes': 'Air', 'forks': 'Pfitzcraft'}
    });
  });
  test('Test the Excel file reading Second list', () {
    List<String> dataList1 = [
      'ID944806,Willard Vista,Intelligent Copper Knife,3,Hilll-Gorczany',
      'ID644525,Roger Centers,Intelligent Copper Knife,1,Kunze-Bernhard',
      'ID348204,Roger Centers,Small Granite Shoes,4,Rowe and Legros',
      'ID710139,Roger Centers,Intelligent Copper Knife,4,Hilll-Gorczany',
      'ID426632,Willa Hollow,Intelligent Copper Knife,4,Hilll-Gorczany'
    ];
    Controller controller = Controller();
    Map<String, Map<String, String>> value1 = controller.getData(dataList1);
    expect(value1, {
      'productAverageMap': {'Intelligent Copper Knife': '2.4', 'Small Granite Shoes': '0.8'},
      'productBrandMap': {'Intelligent Copper Knife': 'Hilll-Gorczany', 'Small Granite Shoes': 'Rowe and Legros'}
    });
  });
}
