import 'dart:io';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:doctor_finder_app/components/custom_snackbar.dart';

class PdfGeneratorController extends GetxController {
  var isGeneratingPdf = false.obs;

  Future<void> generateDoctorDetailsPdf({
    required String doctorName,
    required String consultingTime,
    required String location,
    required String department,
    required String gender,
  }) async {
    try {
      isGeneratingPdf.value = true;

      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  child: pw.Text(
                    'Doctor Details',
                    style: const pw.TextStyle(fontSize: 24),
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(vertical: 10),
                  height: 2,
                  color: PdfColors.black,
                ),
                pw.SizedBox(height: 20),

                pw.Text(
                  'Dr. $doctorName',
                  style: const pw.TextStyle(fontSize: 20),
                ),
                pw.SizedBox(height: 30),

                // Details Table
                pw.Table(
                  columnWidths: {
                    0: const pw.FixedColumnWidth(120),
                    1: const pw.FlexColumnWidth(),
                  },
                  children: [
                    buildTableRow('Consulting Time', consultingTime),
                    buildTableRow('Location', location),
                    buildTableRow('Department', department),
                    buildTableRow('Gender', gender),
                  ],
                ),

                pw.SizedBox(height: 40),

                // Footer
                pw.Spacer(),
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(vertical: 10),
                  height: 1,
                  color: PdfColors.grey,
                ),
                pw.Text(
                  'Generated on: ${DateTime.now().toString().split(' ')[0]}',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey),
                ),
              ],
            );
          },
        ),
      );

      await _savePdf(pdf, doctorName);

      CustomSnackbar.success('Success', 'PDF generated and ready to share!');
    } catch (e) {
      print('Error generating PDF: $e');
      CustomSnackbar.error(
        'Error',
        'Failed to generate PDF. Please try again.',
      );
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  pw.TableRow buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 8),
          child: pw.Text('$label:', style: const pw.TextStyle(fontSize: 14)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 8),
          child: pw.Text(value, style: const pw.TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  Future<void> _savePdf(pw.Document pdf, String doctorName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'Dr_${doctorName.replaceAll(' ', '_')}_Details.pdf';
      final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(await pdf.save());

      print('PDF saved: $fileName');
      print('Location: ${file.path}');

      // Share the PDF so user can save it anywhere
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Doctor Details - Dr. $doctorName',
        subject: 'Doctor Details PDF',
      );
    } catch (e) {
      print('Error saving/sharing PDF: $e');
      throw e;
    }
  }
}
