import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ExportService {
  static Future<String> export(List students) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/data.csv');

    String csv = "name,start,end\n";

    for (var s in students) {
      for (var sess in s['sessions'] ?? []) {
        csv += "${s['name']},${sess['start']},${sess['end']}\n";
      }
    }

    await file.writeAsString(csv);
    return file.path;
  }
}
