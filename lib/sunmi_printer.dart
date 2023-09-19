import 'dart:convert';

import 'package:flutter/services.dart';
import 'sunmi_print_enums.dart';

class SunmiPrinter {
  static const platform = MethodChannel('sunmi_printer_library/method_channel');

  static final Map _PrinterStatus = {
    'ERROR': 'Something went wrong.',
    'NORMAL': 'Printer is running',
    'PREPARING': 'Printer found but still initializing',
    'ABNORMAL_COMMUNICATION': 'Printer hardware interface is abnormal and needs to be reprinted',
    'OUT_OF_PAPER': 'Printer is out of paper',
    'OVERHEATED': 'Printer is overheating',
    'NOT_CLOSED': "Printer's cover is not closed",
    'PAPER_CUTTER_ABNORMAL': "Printer's cutter is abnormal",
    'PAPER_CUTTER_RECOVERED': "Printer's cutter is normal",
    'NO_BLACK_MARK': "Not found black mark paper",
    'NO_PRINTER_DETECTED': 'No printer had been detected',
    'FAILED_TO_UPGRADE_FIRMWARE': 'Failed to upgrade firmware',
    'EXCEPTION': 'Unknown Error code',
  };


  static Future<bool?> bindPrinterService() async {
    // Khởi tạo máy in
    final bool? status = await platform.invokeMethod('BIND_PRINTER_SERVICE');
    return status;
  }

  static Future<bool?> unbindPrinterService() async {
    // Tắt máy in
    final bool? status = await platform.invokeMethod('UNBIND_PRINTER_SERVICE');
    return status;
  }

  static Future<bool?> initPrinter() async {
    // start máy in
    final bool? status = await platform.invokeMethod('INIT_PRINTER');
    return status;
  }

  ///*startTransactionPrint*
  static Future<void> startTransactionPrint() async {
    await platform.invokeMethod("ENTER_PRINTER_BUFFER");
  }

  ///*submitTransactionPrint*
  ///
  ///This method will submit your transaction to the bufffer
  static Future<void> submitTransactionPrint() async {
    await platform.invokeMethod("COMMIT_PRINTER_BUFFER");
  }

  ///*exitTransactionPrint*
  ///
  ///This method will close the transaction

  static Future<String> exitTransactionPrint() async {
    return await platform.invokeMethod("EXIT_PRINTER_BUFFER");
  }

  ///*resetFontSize*
  ///
  ///This method will reset the font size to the medium (default) size
  static Future<void> resetFontSize() async {
    Map<String, dynamic> arguments = <String, dynamic>{"size": 24};
    await platform.invokeMethod("FONT_SIZE", arguments);
  }

  static Future<void> startPrinterExam() async {
    // in ví dụ
    await platform.invokeMethod('PRINTER_EXAMPLE');
  }

  static Future<void> cut() async {
    // cắt giấy
    await platform.invokeMethod('CUT_PAPER');
  }

  static Future<void> lineWrap(int line) async {
    Map<String, dynamic> arguments = <String, dynamic>{"lines": line};
    await platform.invokeMethod('LINE_WRAP', arguments);
  }

  ///*line*
  ///
  ///With this method you can draw a line to divide sections.
  static Future<void> line({
    String ch = '-',
    int len = 31,
  }) async {
    resetFontSize();
    await printText(text: List.filled(len, ch[0]).join());
  }

  ///*line*
  ///
  ///With this method you can draw a line to divide sections.
  static Future<void> lineDash({
    String ch = '- ',
    int len = 18,
  }) async {
    resetFontSize();
    await printText(text: List.filled(len, ch).join());
  }

  static Future<void> printText({
    required String text,
    int size = 24,
    bool bold = false,
    bool underLine = false,
    String? typeface,
    bool isLight = false,
    bool isExtra = false,
  }) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "text": '$text\n',
      "size": size,
      "bold": bold,
      "under_line": underLine,
      "is_light": isLight,
      "is_extra": isExtra
    };
    await platform.invokeMethod("PRINT_TEXT", arguments);
  }
  
  ///*printTextPlus*
  ///
  ///This method will print a simple text in your printer
  /// With the [SunmiStyle] you can put in one line, the size, alignment and bold
  static Future<void> printTextPlus(String text, {SunmiStyle? style}) async {
    if (style != null) {
      if (style.align != null) {
        await setAlignment(style.align!);
      }

      int _fontSize = 24;
      if (style.fontSize != null) {
        switch (style.fontSize) {
          case SunmiFontSize.XS:
            _fontSize = 14;
            break;
          case SunmiFontSize.SM:
            _fontSize = 18;
            break;
          case SunmiFontSize.MD:
            _fontSize = 24;
            break;
          case SunmiFontSize.LG:
            _fontSize = 36;
            break;
          case SunmiFontSize.XL:
            _fontSize = 42;
            break;
        }
      }

      bool isBold = false;
      if (style.bold != null) {
        if (style.bold == true) {
          isBold = true;
        }
      }


      await printText(
          text: text, bold: isBold, size: _fontSize);
    }
  }

  static Future<void> setAlignmentPlus(int value) async {
    Map<String, dynamic> arguments = <String, dynamic>{"alignment": value};
    await platform.invokeMethod("SET_ALIGNMENT", arguments);
  }

  static Future<String> getPrinterVersion() async {
    return await platform.invokeMethod("PRINTER_VERSION");
  }

  static Future<void> printImage(Uint8List img) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent("bitmap", () => img);
    await platform.invokeMethod("PRINT_IMAGE", arguments);
  }

  static Future<String> getPrinterSerialNo() async {
    return await platform.invokeMethod("PRINTER_SERIALNO");
  }

  static Future<void> printDrawRow() async {
    await platform.invokeMethod("PRINT_DRAW_ROW");
  }

  static Future<void> printBarCode(
      {required String dataBarCode,
      required int symbology,
      required int height,
      required int width,
      required int textposition}) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": dataBarCode,
      "symbology": symbology,
      "height": height,
      "width": width,
      "textposition": textposition
    };
    await platform.invokeMethod("PRINT_BARCODE", arguments);
  }

  static Future<void> printQr(
      {required String dataQRCode,
      required int modulesize,
      required int errorlevel}) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": dataQRCode,
      "modulesize": modulesize,
      "errorlevel": errorlevel
    };
    await platform.invokeMethod("PRINT_QRCODE", arguments);
  }

  ///*printQRCode*
  ///
  ///With this method you can print a qrcode with some errorLevel and size.
  static Future<void> printQRCode(String data,
      {int size = 5,
        SunmiQrcodeLevel errorLevel = SunmiQrcodeLevel.LEVEL_H}) async {
    int _errorlevel = 3;
    switch (errorLevel) {
      case SunmiQrcodeLevel.LEVEL_L:
        _errorlevel = 0;
        break;
      case SunmiQrcodeLevel.LEVEL_M:
        _errorlevel = 1;

        break;
      case SunmiQrcodeLevel.LEVEL_Q:
        _errorlevel = 2;
        break;
      case SunmiQrcodeLevel.LEVEL_H:
        _errorlevel = 3;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": data,
      'modulesize': size,
      'errorlevel': _errorlevel
    };
    await platform.invokeMethod("PRINT_QRCODE", arguments);
  }

  static Future<void> printTable(
      {required List<ColumnMaker> cols, int? size}) async {
    size ??= 20;
    final _jsonCols = List<Map<String, String>>.from(
        cols.map<Map<String, String>>((ColumnMaker col) => col.toJson()));
    Map<String, dynamic> arguments = <String, dynamic>{
      "cols": json.encode(_jsonCols),
      "size": size
    };
    await platform.invokeMethod("PRINT_TABLE", arguments);
  }

  static Future<String> printStatus() async {
    return await platform.invokeMethod("PRINT_STATUS");
  }

  ///*getPrinterStatus*
  ///
  ///This method will give you the status of the printer.
  ///Sometimes the printer can give you an error, so, try to print anyway.
  static Future<PrinterStatus> getPrinterStatus() async {
    final String? status = await platform.invokeMethod('PRINT_STATUS');
    print('getPrinterStatus');
    print(status);
    switch (status) {
      case 'ERROR':
        return PrinterStatus.ERROR;
      case 'NORMAL':
        return PrinterStatus.NORMAL;
      case 'ABNORMAL_COMMUNICATION':
        return PrinterStatus.ABNORMAL_COMMUNICATION;
      case 'OUT_OF_PAPER':
        return PrinterStatus.OUT_OF_PAPER;
      case 'PREPARING':
        return PrinterStatus.PREPARING;
      case 'OVERHEATED':
        return PrinterStatus.OVERHEATED;
      case 'OPEN_THE_LID':
        return PrinterStatus.OPEN_THE_LID;
      case 'PAPER_CUTTER_ABNORMAL':
        return PrinterStatus.PAPER_CUTTER_ABNORMAL;
      case 'PAPER_CUTTER_RECOVERED':
        return PrinterStatus.PAPER_CUTTER_RECOVERED;
      case 'NO_BLACK_MARK':
        return PrinterStatus.NO_BLACK_MARK;
      case 'NO_PRINTER_DETECTED':
        return PrinterStatus.NO_PRINTER_DETECTED;
      case 'FAILED_TO_UPGRADE_FIRMWARE':
        return PrinterStatus.FAILED_TO_UPGRADE_FIRMWARE;
      case 'EXCEPTION':
        return PrinterStatus.EXCEPTION;
      default:
        return PrinterStatus.UNKNOWN;
    }
  }

  ///*getPrinterStatusWithVerbose*
  ///
  ///Almos the same of  [getPrinterStatus] , but will return a text explaned
  ///@see the _printerStatus map!
  static Future<String?> getPrinterStatusWithVerbose() async {
    final String? status = await platform.invokeMethod('PRINT_STATUS');
    final statusMsg = _PrinterStatus[status];
    print(statusMsg);
    return statusMsg;
  }

  static Future<String> getPrintPaper() async {
    return await platform.invokeMethod("PRINT_PAPER");
  }

  static Future<void> feedPaper() async {
    await platform.invokeMethod("FEED_PAPER");
  }

  static Future<bool> getBackLabelMode() async {
    return await platform.invokeMethod("BACK_LABEL_MODE");
  }

  static Future<bool> getLabelModel() async {
    return await platform.invokeMethod("LABEL_MODEL");
  }

  static Future<void> printTrans() async {
    await platform.invokeMethod("PRINT_TRANS");
  }

  static Future<void> controlLCD(int flag) async {
    Map<String, dynamic> arguments = <String, dynamic>{"flag": flag};
    await platform.invokeMethod("CONTROL_LCD", arguments);
  }

  static Future<void> sentTextLCD() async {
    await platform.invokeMethod("SEND_TEXT_TOLCD");
  }

  static Future<void> sentTextsLCD() async {
    await platform.invokeMethod("SEND_TEXTS_TOLCD");
  }

  static Future<void> printMultiLabel(int num) async {
    Map<String, dynamic> arguments = <String, dynamic>{"num": num};
    await platform.invokeMethod("PRINT_MULTILABEL", arguments);
  }

  static Future<void> printeHead() async {
    await platform.invokeMethod("PRINTE_HEAD");
  }

  static Future<void> printeDistance() async {
    await platform.invokeMethod("PRINTE_DISTANCE");
  }

  ///*setFontSize*
  ///
  ///This method will change the fontsize , between extra small and extra large.
  ///You can see the sizes below or in the enum file.

  static Future<void> setFontSize(SunmiFontSize _size) async {
    int _fontSize = 24;
    switch (_size) {
      case SunmiFontSize.XS:
        _fontSize = 14;
        break;
      case SunmiFontSize.SM:
        _fontSize = 18;
        break;
      case SunmiFontSize.MD:
        _fontSize = 24;
        break;
      case SunmiFontSize.LG:
        _fontSize = 36;
        break;
      case SunmiFontSize.XL:
        _fontSize = 42;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{"size": _fontSize};

    await platform.invokeMethod("FONT_SIZE", arguments);
  }

  ///*setCustomFontSize*
  ///
  ///This method will allow you to put any font size integer and try the best fit for you
  static Future<void> setCustomFontSize(int _size) async {
    Map<String, dynamic> arguments = <String, dynamic>{"size": _size};
    await platform.invokeMethod("FONT_SIZE", arguments);
  }

  static Future<void> setAlignment(SunmiPrintAlign alignment) async {
    late int value;
    switch (alignment) {
      case SunmiPrintAlign.LEFT:
        value = 0;
        break;
      case SunmiPrintAlign.CENTER:
        value = 1;
        break;
      case SunmiPrintAlign.RIGHT:
        value = 2;
        break;
      default:
        value = 0;
    }
    
    Map<String, dynamic> arguments = <String, dynamic>{"alignment": value};
    await platform.invokeMethod("SET_ALIGNMENT", arguments);
  }

  ///*bold*
  ///
  ///With this method you can bold a string very easy, just put this method before a [printText] and everyting after this mehod will be bold

  static Future<void> bold() async {
    final List<int> boldOn = [27, 69, 1];

    await printRawData(Uint8List.fromList(boldOn));
  }

  ///*resetBold*
  ///
  ///This method will just reset the bold to a normal font weight
  static Future<void> resetBold() async {
    final List<int> boldOff = [27, 69, 0];

    await printRawData(Uint8List.fromList(boldOff));
  }

  ///*printRawData*
  ///
  ///With this method you can print a raw data, or a data that was made with some esc/pos package to simplify your calls
  ///*This is good if you have another print method that give you a [List<int>] that you can convert to esc/pos here
  static Future<void> printRawData(Uint8List data) async {
    Map<String, dynamic> arguments = <String, dynamic>{"data": data};
    await platform.invokeMethod("SENT_RAW_DATA", arguments);
  }
}

class ColumnMaker {
  String text;
  int width;
  int align;
  ColumnMaker({
    this.text = '',
    this.width = 2,
    this.align = 0,
  });
  //Convert to json
  Map<String, String> toJson() {
    int value = 0;
    switch (align) {
      case 0:
        value = 0;
        break;
      case 1:
        value = 1;
        break;
      case 2:
        value = 2;
        break;
      default:
        value = 0;
    }
    return {
      "text": text,
      "width": width.toString(),
      "align": value.toString(),
    };
  }
}

