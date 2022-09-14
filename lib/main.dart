import 'package:dealwithcsvfiles/file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel Read App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(create: (_) => FileCubit(), child: const MyHomePage(title: 'Excel Read App')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    FileCubit.get(context).selectFile();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocBuilder<FileCubit, FileState>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text(widget.title),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FileCubit.get(context).fileData.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Table(border: TableBorder.all(), columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                              3: FlexColumnWidth(),
                            }, children: [
                              TableRow(
                                children: <Widget>[
                                  TableCell(
                                      child: Center(
                                    child: Text(
                                      'id',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  )),
                                  TableCell(
                                      child: Center(
                                    child: Text(
                                      'area',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  )),
                                  TableCell(
                                      child: Center(
                                    child: Text(
                                      'name',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  )),
                                  TableCell(
                                      child: Center(
                                    child: Text(
                                      'amount',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  )),
                                  TableCell(
                                      child: Center(
                                    child: Text(
                                      'brand',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  )),
                                ],
                              ),
                              ...FileCubit.get(context)
                                  .fileData
                                  .map((e) => TableRowDataFile(
                                      id: e.id ?? 0, area: e.area ?? '', brand: e.brand ?? '', name: e.name ?? '', amount: e.amount ?? 0))
                                  .toList()
                            ]),
                            FileCubit.get(context).productAverageMap.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "0_input_example",
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                FileCubit.get(context).generateReportAverage(context);
                                              },
                                              icon: const Icon(Icons.share))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Table(border: TableBorder.all(), columnWidths: const <int, TableColumnWidth>{
                                        0: FlexColumnWidth(),
                                        1: FlexColumnWidth(),
                                      }, children: [
                                        TableRow(
                                          children: <Widget>[
                                            TableCell(
                                                child: Center(
                                              child: Text(
                                                'Name',
                                                style: Theme.of(context).textTheme.headline6,
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                              child: Text(
                                                'Average',
                                                style: Theme.of(context).textTheme.headline6,
                                              ),
                                            )),
                                          ],
                                        ),
                                        ...FileCubit.get(context)
                                            .productAverageMap
                                            .entries
                                            .map((e) => TableRowDataOutPut(key: e.key, value: e.value))
                                      ]),
                                    ],
                                  ),
                            FileCubit.get(context).productBrandMap.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "1_input_example",
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                FileCubit.get(context).generateBrandAverage(context);
                                              },
                                              icon: const Icon(Icons.share))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Table(border: TableBorder.all(), columnWidths: const <int, TableColumnWidth>{
                                        0: FlexColumnWidth(),
                                        1: FlexColumnWidth(),
                                      }, children: [
                                        TableRow(
                                          children: <Widget>[
                                            TableCell(
                                                child: Center(
                                              child: Text(
                                                'Name',
                                                style: Theme.of(context).textTheme.headline6,
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                              child: Text(
                                                'Brand',
                                                style: Theme.of(context).textTheme.headline6,
                                              ),
                                            )),
                                          ],
                                        ),
                                        ...FileCubit.get(context)
                                            .productBrandMap
                                            .entries
                                            .map((e) => TableRowDataOutPut(key: e.key, value: e.value))
                                      ]),
                                    ],
                                  ),
                          ],
                        )
                      : const Center(
                          child: Text('No File Loaded Yet'),
                        ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _incrementCounter,
                child: const Icon(Icons.add),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }

  TableRow TableRowDataFile({required int id, required String area, required String name, required int amount, required String brand}) {
    return TableRow(
      children: <Widget>[
        TableCell(
            child: Center(
          child: Text(
            '$id',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )),
        TableCell(
            child: Center(
          child: Text(
            area,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )),
        TableCell(
            child: Center(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )),
        TableCell(
            child: Center(
          child: Text(
            '$amount',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )),
        TableCell(
            child: Center(
          child: Text(
            brand,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )),
      ],
    );
  }

  TableRow TableRowDataOutPut({required String key, required String value}) {
    return TableRow(
      children: <Widget>[
        TableCell(
            child: Center(
          child: Text(
            key,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )),
        TableCell(
            child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )),
      ],
    );
  }
}
