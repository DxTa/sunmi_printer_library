import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_print_library/sunmi_print_enums.dart';
import 'package:sunmi_print_library/sunmi_printer.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        home: HomePrinterView()),
  );
}

class HomePrinterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.bindPrinterService();
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint();
                  await SunmiPrinter.printText(
                      text: AppConst.nameCompany, bold: true, size: 20);
                  await SunmiPrinter.printText(
                      text: AppConst.addressConpany,
                      bold: false,
                      size: 18,
                      underLine: false);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.taxCodeName} ${AppConst.taxCodeCustomer}",
                      bold: false,
                      size: 20);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text: AppConst.nameTicket, bold: false, size: 27);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.fareTicket} ${AppConst.moneyTicket} đồng",
                      bold: false,
                      size: 25);
                  await SunmiPrinter.setAlignmentPlus(1);
                  //giờ vào
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.ticketStartingDateHP} ${DateTime.now().hour} h ${DateTime.now().minute} p",
                      bold: false,
                      size: 20);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.day} ${DateTime.now().day} ${AppConst.month} ${DateTime.now().month} ${AppConst.year} ${DateTime.now().year}",
                      bold: false,
                      size: 19);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.ncc} ${AppConst.nameCompanyNCC} - ${AppConst.nameTaxCode} ${AppConst.taxCode} \n \t ${AppConst.custommerService} ${AppConst.phoneCustomerService}",
                      bold: true,
                      size: 17);
                  await SunmiPrinter.lineWrap(3);
                  //await SunmiPrinter.cutPaper();
                  // await SunmiPrinter.submitTransactionPrint();
                  final result = await SunmiPrinter.exitTransactionPrint();
                  print("Result print: " + result);
                  await SunmiPrinter.unbindPrinterService();
                },
                child: const Text("In vé"),
              ),
            ),
            Center(
              child: ElevatedButton(
                // in table
                onPressed: () async {
                  await SunmiPrinter.bindPrinterService();
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint();
                  await SunmiPrinter.printTable(size: 21, cols: [
                    ColumnMaker(text: 'Name', width: 10, align: 0),
                    ColumnMaker(text: 'Qty', width: 6, align: 1),
                    ColumnMaker(text: 'UN', width: 10, align: 2),
                    ColumnMaker(text: 'TOT', width: 10, align: 2),
                  ]);
                  await SunmiPrinter.printTable(cols: [
                    ColumnMaker(text: 'Fries', width: 10, align: 0),
                    ColumnMaker(text: '4x', width: 6, align: 1),
                    ColumnMaker(text: '3.00', width: 10, align: 2),
                    ColumnMaker(text: '12.00', width: 10, align: 2),
                  ]);
                  await SunmiPrinter.printTable(size: 20, cols: [
                    ColumnMaker(text: 'Sản phẩm Ahq', width: 20, align: 0),
                    // ColumnMaker(text: '4x', width: 6, align: 1),
                    ColumnMaker(text: '120.00000', width: 10, align: 2),
                  ]);
                  //await SunmiPrinter.initPrinterExam();
                  await SunmiPrinter.lineWrap(3);
                  await SunmiPrinter.submitTransactionPrint();
                  final result = await SunmiPrinter.exitTransactionPrint();
                  print("Result print: " + result);
                  await SunmiPrinter.unbindPrinterService();
                },
                child: const Text("In bảng hoá đơn"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.bindPrinterService();
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint();
                  await SunmiPrinter.printText(
                      text: AppConst.nameCompany2, bold: true, size: 20);
                  await SunmiPrinter.printText(
                      text: AppConst.addressConpany2,
                      bold: false,
                      size: 18,
                      underLine: false);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.taxCodeName} ${AppConst.taxCodeCustomer}",
                      bold: false,
                      size: 21);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text: AppConst.nameTicket2, bold: false, size: 30);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text: AppConst.location, bold: false, size: 27);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.fareTicket} ${AppConst.moneyTicket2} đồng",
                      bold: false,
                      size: 25);

                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.ticketStartingDate} ${DateTime.now().hour} h ${DateTime.now().minute} p ",
                      bold: false,
                      size: 20);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.day} ${DateTime.now().day} ${AppConst.month} ${DateTime.now().month} ${AppConst.year} ${DateTime.now().year}",
                      bold: false,
                      size: 19);
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printText(
                      text:
                          "${AppConst.ncc} ${AppConst.nameCompanyNCC} - ${AppConst.nameTaxCode} ${AppConst.taxCode} \n \t ${AppConst.custommerService} ${AppConst.phoneCustomerService}",
                      bold: true,
                      size: 17);

                  await SunmiPrinter.lineWrap(3);
                  await SunmiPrinter.submitTransactionPrint();
                  final result = await SunmiPrinter.exitTransactionPrint();
                  print("Result print: " + result);
                  await SunmiPrinter.unbindPrinterService();
                },
                child: const Text("Bắc Ninh - Thanh Hoá"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.bindPrinterService();
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint();
                  await SunmiPrinter.printBarCode(
                      dataBarCode: "0123648445",
                      symbology: 1,
                      height: 162,
                      width: 2,
                      textposition: 1);
                  await SunmiPrinter.submitTransactionPrint();
                  final result = await SunmiPrinter.exitTransactionPrint();
                  print("Result print: " + result);
                  await SunmiPrinter.unbindPrinterService();
                },
                child: const Text("Bar code"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.bindPrinterService();
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint();
                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.printQr(
                      dataQRCode: "https://github.com/hueht21",
                      modulesize: 5,
                      errorlevel: 2);
                  await SunmiPrinter.lineWrap(3);
                  await SunmiPrinter.submitTransactionPrint();
                  final result = await SunmiPrinter.exitTransactionPrint();
                  print("Result print: " + result);
                  await SunmiPrinter.unbindPrinterService();
                },
                child: const Text("qr code"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.bindPrinterService();
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint();

                  await SunmiPrinter.setAlignmentPlus(1);
                  await SunmiPrinter.lineWrap(1);
                  String url = "https://firebasestorage.googleapis.com/v0/b/pepi-store-test.appspot.com/o/users%2FFXkJxtfxeBbbnLRuW155J4UYLLe2%2Frestaurants%2Fad9da1bf-ed6a-4dab-8951-170e83a7bc9e%2Fimages%2F2ed65e2e-f14d-4fa0-87d7-09668ce2e1c3.jpeg?alt=media&token=ad0d3219-bcea-4447-9320-1c470d4c1756";
                  // convert image to Uint8List format
                  Uint8List byte = (await NetworkAssetBundle(Uri.parse(url)).load(url))
                      .buffer
                      .asUint8List();
                  await SunmiPrinter.printImage(byte);

                  await SunmiPrinter.lineWrap(4);

                  final result = await SunmiPrinter.exitTransactionPrint();
                  await SunmiPrinter.unbindPrinterService();
                  print("Result print: " + result);
                },
                child: Text("In ảnh"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.bindPrinterService();
                  await SunmiPrinter.initPrinter();



                  final result1 = await SunmiPrinter.getPrinterStatus();
                  final result2 = await SunmiPrinter.getPrinterStatus();
                  final result3 = await SunmiPrinter.getPrinterStatus();
                  final result4 = await SunmiPrinter.getPrinterStatus();
                  final result5 = await SunmiPrinter.getPrinterStatus();
                  final result6 = await SunmiPrinter.getPrinterStatus();

                  print("Result1 status print: " + (result1?.originalStatus ?? ''));
                  print("Result2 status print: " + (result2?.originalStatus  ?? ''));
                  print("Result3 status print: " + (result3?.originalStatus ?? ''));
                  print("Result4 status print: " + (result4?.originalStatus  ?? ''));
                  print("Result5 status print: " + (result5?.originalStatus ?? ''));
                  print("Result6 status print: " + (result6?.originalStatus  ?? ''));
                  // await SunmiPrinter.unbindPrinterService();
                },
                child: Text("Check trạng thái máy in"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes(iconPath);
  }

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }
}

class AppConst {
  static const String nameCompany = "CÔNG TY TNHH GIẢI PHÁP ĐÔ THỊ NAM HẢI";
  static const String addressConpany = "Số 33 Ngõ 151 Láng Hạ, Đống Đa, Hà Nội";
  static const String nameTicket = "VÉ TRÔNG GIỮ XE Ô TÔ";
  static const String fareTicket = "Giá vé: ";
  static const String ticketStartingDateHP = "Giờ xe vào:";
  static const String day = "ngày";
  static const String month = "tháng";
  static const String year = "năm";
  static const String ncc = "NCC";
  static const String nameTaxCode = "MST";
  static const String taxCode = "0105987432";
  static const String nameCompanyNCC = "Softdreams";
  static const String custommerService = "CSKH";
  static const String moneyTicket = "25,000";
  static const String phoneCustomerService = "19003369";
  static const String taxCodeName = "Mã số thuế:";
  static const String taxCodeCustomer = "12589654";

  static const String nameCompany2 = "CÔNG TY CPTVXDMT VÀ VT THÀNH AN";
  static const String addressConpany2 =
      "Thôn 7, X.Thọ Lộc, H.Thọ Xuân, Thanh Hoá";
  static const String nameTicket2 = "VÉ XE KHÁCH";
  static const String moneyTicket2 = "90,000";
  static const String ticketStartingDate = "Thời gian xuất  bến: ";
  static const String location = "Bắc Ninh - Thanh Hoá";
}

const String PATTERN_1 = "dd/MM/yyyy";
const String PATTERN_DD = "dd";
const String PATTERN_MM = "MM";
const String PATTERN_YY = "yyyy";
const String PATTERN_2 = "dd/MM";
const String PATTERN_3 = "yyyy-MM-dd'T'HHmmss";
const String PATTERN_4 = "h:mm a dd/MM";
const String PATTERN_5 = "yyyy-MM-dd HH:mm:ss";
const String PATTERN_6 = "dd/MM/yyyy HH:mm";
const String PATTERN_7 = "HH:mm dd/MM/yyyy";
const String PATTERN_8 = "yyyy-MM-ddTHH:mm:ss";
const String PATTERN_9 = "HH:mm - dd/MM/yyyy";
const String PATTERN_10 = "dd/MM/yyyy HH:mm:ss";
const String PATTERN_11 = "HH:mm";
const String PATTERN_DEFAULT = "yyyy-MM-dd";

String convertDateToString(DateTime dateTime, String pattern) {
  return DateFormat(pattern).format(dateTime);
}
