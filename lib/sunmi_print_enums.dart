// ignore_for_file: constant_identifier_name

class SunmiStyle {
  int? fontSize;
  int? align;
  bool? bold;

  SunmiStyle({this.fontSize, this.align, this.bold});
}

///*PrinterStatus*
///
///This enum will give you the status of the printer.
///Sometimes the status can be ERROR, but don't worry about this status, always try co print anyway!
enum PrinterStatus {
  UNKNOWN,
  ERROR,
  NORMAL,
  PREPARING,
  ABNORMAL_COMMUNICATION,
  OUT_OF_PAPER,
  OVERHEATED,
  NOT_CLOSED,
  PAPER_CUTTER_ABNORMAL,
  PAPER_CUTTER_RECOVERED,
  NO_BLACK_MARK,
  NO_PRINTER_DETECTED,
  FAILED_TO_UPGRADE_FIRMWARE,
  EXCEPTION,
}

extension PrinterStatusExtension on PrinterStatus {
  String get statusString {
    switch (this) {
      case PrinterStatus.ERROR:
        return 'Something went wrong.';
      case PrinterStatus.NORMAL:
        return "Printer is running";
      case PrinterStatus.ABNORMAL_COMMUNICATION:
        return "Printer hardware interface is abnormal and needs to be reprinted";
      case PrinterStatus.OUT_OF_PAPER:
        return "Printer is out of paper";
      case PrinterStatus.PREPARING:
        return "Printer found but still initializing";
      case PrinterStatus.OVERHEATED:
        return "Printer is overheating";
      case PrinterStatus.NOT_CLOSED:
        return "Printer's cover is not closed";
      case PrinterStatus.PAPER_CUTTER_ABNORMAL:
        return "Printer's cutter is abnormal";
      case PrinterStatus.PAPER_CUTTER_RECOVERED:
        return "Printer's cutter is normal";
      case PrinterStatus.NO_BLACK_MARK:
        return "Not found black mark paper";
      case PrinterStatus.NO_PRINTER_DETECTED:
        return "No printer had been detected";
      case PrinterStatus.FAILED_TO_UPGRADE_FIRMWARE:
        return "Failed to upgrade firmware";
      case PrinterStatus.EXCEPTION:
        return "Unknown Error code";
      default:
        return "Unknown";
    }
  }

  /// Get status string from enum status
  String get statusKey {
    switch (this) {
      case PrinterStatus.ERROR:
        return 'ERROR';
      case PrinterStatus.NORMAL:
        return 'NORMAL';
      case PrinterStatus.ABNORMAL_COMMUNICATION:
        return 'ABNORMAL_COMMUNICATION';
      case PrinterStatus.OUT_OF_PAPER:
        return 'OUT_OF_PAPER';
      case PrinterStatus.PREPARING:
        return 'PREPARING';
      case PrinterStatus.OVERHEATED:
        return 'OVERHEATED';
      case PrinterStatus.NOT_CLOSED:
        return 'NOT_CLOSED';
      case PrinterStatus.PAPER_CUTTER_ABNORMAL:
        return 'PAPER_CUTTER_ABNORMAL';
      case PrinterStatus.PAPER_CUTTER_RECOVERED:
        return 'PAPER_CUTTER_RECOVERED';
      case PrinterStatus.NO_BLACK_MARK:
        return 'NO_BLACK_MARK';
      case PrinterStatus.NO_PRINTER_DETECTED:
        return 'NO_PRINTER_DETECTED';
      case PrinterStatus.FAILED_TO_UPGRADE_FIRMWARE:
        return 'FAILED_TO_UPGRADE_FIRMWARE';
      case PrinterStatus.EXCEPTION:
        return 'EXCEPTION';
      default:
        return 'UNKNOWN';
    }
  }
}

///*PrinterMode*
///
///Enum to set printer mode
enum PrinterMode {
  UNKNOWN,
  NORMAL_MODE,
  BLACK_LABEL_MODE,
  LABEL_MODE,
}

///*SunmiPrintAlign*
///
///Enum to set printer aligntment
enum SunmiPrintAlign {
  LEFT,
  CENTER,
  RIGHT,
}

extension SunmiPrintAlignExtension on SunmiPrintAlign {
  int get intValue {
    switch (this) {
      case SunmiPrintAlign.LEFT:
        return 0;
      case SunmiPrintAlign.CENTER:
        return 1;
      case SunmiPrintAlign.RIGHT:
        return 2;
      default:
        return 1;
    }
  }
}

///*SunmiQrcodeLevel*
///
//Enum to set a QRcode Level (Low to High)
enum SunmiQrcodeLevel {
  LEVEL_L,
  LEVEL_M,
  LEVEL_Q,
  LEVEL_H,
}

///*SunmiBarcodeType*
///
///Enum to set Barcode Type
enum SunmiBarcodeType {
  UPCA,
  UPCE,
  JAN13,
  JAN8,
  CODE39,
  ITF,
  CODABAR,
  CODE93,
  CODE128,
}

///*SunmiBarcodeTextPos*
///
///Enum to set how the thex will be printed in barcode
enum SunmiBarcodeTextPos {
  NO_TEXT,
  TEXT_ABOVE,
  TEXT_UNDER,
  BOTH,
}

///*SunmiFontSize*
///Enum to set font in the printer
enum SunmiFontSize {
  XS,
  SM,
  MD,
  LG,
  XL,
}

/*
case 'xs':
        return 14;
      case 'sm':
        return 18;
      case 'md':
        return 24;
      case 'lg':
        return 36;
      case 'xl':
        return 42;
      default:
        return 24;
 */
extension SunmiFontSizeExtension on SunmiFontSize {
  int get intValue {
    switch (this) {
      case SunmiFontSize.XS:
        return 14;
      case SunmiFontSize.SM:
        return 18;
      case SunmiFontSize.MD:
        return 24;
      case SunmiFontSize.LG:
        return 36;
      case SunmiFontSize.XL:
        return 42;
      default:
        return 24;
    }
  }
}
