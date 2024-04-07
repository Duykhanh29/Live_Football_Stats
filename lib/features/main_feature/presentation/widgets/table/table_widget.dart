import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/image_data.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TableWidget extends StatefulWidget {
  TableWidget({super.key, required this.standings});
  List<Standing> standings;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  StandingsDataSource? standingsDataSource;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    standingsDataSource = StandingsDataSource(list: widget.standings);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(color: AppColors.cardColor),
      //height: MediaQuery.of(context).size.height * 0.5,
      // padding: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.appBorder)),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Expanded(
                child: SfDataGrid(
                  key: _key,
                  allowSorting: true,
                  selectionMode: SelectionMode.multiple,
                  shrinkWrapRows: true,
                  source: standingsDataSource!,
                  columns: [
                    GridColumn(
                      columnName: 'Position',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Position',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Club',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Club',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Games',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Games',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Wins',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Wins',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Draws',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Draws',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Losses',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Losses',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'GF',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'GF',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'GA',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'GA',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'GD',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'GD',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Points',
                      label: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Points',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: Image.asset(
                ImageData.excelImage,
                height: 20,
                width: 20,
              ),
              onPressed: exportDataGridToExcel,
              label: const Text('Export to Excel'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: Image.asset(
                ImageData.pdfImage,
                height: 15,
                width: 15,
              ),
              onPressed: () async {
                exportDataGridToPdf();
              },
              label: const Text('Export to PDF'),
            )
          ],
        ),
      ),
    );
  }

  void exportDataGridToPdf() async {
    if (await isPermissionGranted()) {
      final PdfDocument document = _key.currentState!.exportToPdfDocument();
      final List<int> bytes = await document.save();

      Directory? appDocDir = await getDownloadsDirectory();
      String appDocPath = appDocDir!.path;
      String filePath = '$appDocPath/DataGrid.pdf';

      File file = File(filePath);
      await file.writeAsBytes(bytes);

      bool isFileExist = await file.exists();
      if (isFileExist) {
        print('PDF file created successfully.');
      } else {
        print('Failed to create PDF file.');
      }

      document.dispose();
    }
  }

  Future<bool> isPermissionGranted() async {
    // Check if storage permission is already granted
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
      // Permission is already granted, you can proceed with writing to storage
      // Or perform any other action that requires storage access
    } else {
      // Permission is not granted, request it
      status = await Permission.storage.request();
      if (status.isGranted) {
        // Permission granted, you can proceed with writing to storage
        // Or perform any other action that requires storage access
        return true;
      } else {
        // Permission denied
        return false;
      }
    }
  }

  Future<void> exportDataGridToExcel() async {
    if (await isPermissionGranted()) {
      final xlsio.Workbook workbook =
          _key.currentState!.exportToExcelWorkbook();
      final List<int> bytes = workbook.saveAsStream();

      Directory? appDocDir = await getDownloadsDirectory();
      String appDocPath = appDocDir!.path;
      String filePath = '$appDocPath/DataGrid.xlsx';

      File file = File(filePath);
      await file.writeAsBytes(bytes);

      bool isFileExist = await file.exists();
      if (isFileExist) {
        print('Excel file created successfully.');
      } else {
        print('Failed to create Excel file.');
      }

      workbook.dispose();
    } else {}
  }
}

class StandingsDataSource extends DataGridSource {
  StandingsDataSource({required List<Standing> list}) {
    dataGridRows = list
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: "Position", value: e.position),
              DataGridCell<String>(columnName: "Club", value: e.teamName),
              DataGridCell<int>(columnName: "Games", value: e.gamesPlayed),
              DataGridCell<int>(columnName: "Wins", value: e.wins),
              DataGridCell<int>(columnName: "Draws", value: e.draws),
              DataGridCell<int>(columnName: "Losses", value: e.losses),
              DataGridCell<int>(columnName: "GF", value: e.goalsFor),
              DataGridCell<int>(columnName: "GA", value: e.goalsAgainst),
              DataGridCell<int>(
                  columnName: "GD", value: e.goalsFor - e.goalsAgainst),
              DataGridCell<int>(columnName: "Points", value: e.points),
            ]))
        .toList();
  }
  late List<DataGridRow> dataGridRows;
  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
