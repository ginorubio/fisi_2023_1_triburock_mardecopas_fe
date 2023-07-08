import 'dart:html' as html;
import 'dart:typed_data';

class PDFredirectUtility{

  static void openPDFInNewTab(Uint8List pdfBytes) {
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
  }

  static void downloadPDF(Uint8List pdfBytes, String codigo){
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement;
    anchor.href = url;
    anchor.download = 'reporte_movimiento_$codigo.pdf';
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }
  
}