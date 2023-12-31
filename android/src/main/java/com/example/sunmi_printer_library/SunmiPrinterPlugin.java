package com.example.sunmi_printer_library;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.RemoteException;
import android.util.Log;
import android.content.Context;

import androidx.annotation.NonNull;

import com.example.sunmi_printer_library.utils.SunmiPrintHelper;
import com.sunmi.peripheral.printer.InnerResultCallback;

import org.json.JSONArray;
import org.json.JSONObject;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

public class SunmiPrinterPlugin implements FlutterPlugin, MethodCallHandler {
    private static Context context;
    private String CHANNEL = "sunmi_printer_library/method_channel";
    String bigFont = "SFPRODISPLAYRegular.ttf";
    String bigFontBold = "SFPRODISPLAYBOLD.ttf";
    String fontExtraBold = "SFPRODISPLAYBOLD.ttf";
    String fontLight = "SFPRODISPLAYLIGHT.ttf";
    String typeFont = "";

    SunmiPrintHelper sunmiPrintHelper;

    private void checkFont(boolean isBold, boolean isLight, boolean isExtra) {
        if (isExtra) {
            typeFont = fontExtraBold;
        } else if (isLight) {
            typeFont = fontLight;
        } else {
            typeFont = isBold ? bigFontBold : bigFont;
        }

    }

    @Override
    public void onAttachedToEngine(
            @NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(
                flutterPluginBinding.getBinaryMessenger(),
                CHANNEL);
        SunmiPrinterPlugin.context = flutterPluginBinding.getApplicationContext();
        sunmiPrintHelper = new SunmiPrintHelper(SunmiPrinterPlugin.context);

        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        // super.configureFlutterEngine(flutterEngine);
        // new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),
        // CHANNEL)
        // .setMethodCallHandler(
        // (call, result) -> {
        switch (call.method) {
            case "BIND_PRINTER_SERVICE":
                sunmiPrintHelper.initSunmiPrinterService();
                result.success(true);
                break;
            case "UNBIND_PRINTER_SERVICE":
                sunmiPrintHelper.deInitSunmiPrinterService();
                result.success(true);
                break;
            case "PRINTER_EXAMPLE":
                sunmiPrintHelper.printExample();
                result.success(true);
                break;
            case "INIT_PRINTER":
                sunmiPrintHelper.initPrinter(SunmiPrinterPlugin.context);
                result.success(true);
                break;
            case "ENTER_PRINTER_BUFFER":
                sunmiPrintHelper.enterPrinterBuffer();
                result.success(true);
                break;
            case "EXIT_PRINTER_BUFFER":
                sunmiPrintHelper.exitPrinterBufferWithCallback(new InnerResultCallback() {
                    @Override
                    public void onRunResult(boolean isSuccess) throws RemoteException {

                    }

                    @Override
                    public void onReturnString(String result) throws RemoteException {

                    }

                    @Override
                    public void onRaiseException(int code, String msg) throws RemoteException {

                    }

                    @Override
                    public void onPrintResult(int code, String msg) throws RemoteException {
                        String resultPrint = code + " - " + msg;
                        result.success(resultPrint);
                    }
                });
                break;
            case "COMMIT_PRINTER_BUFFER":
                sunmiPrintHelper.commitPrinterBuffer();
                result.success(true);
                break;
            case "FONT_SIZE":
                int fontSize = call.argument("size");
                sunmiPrintHelper.setFontSize(fontSize);
                result.success(true);
                break;
            case "PRINT_TEXT":
                String text = call.argument("text");
                boolean bold = call.argument("bold");
                boolean underLine = call.argument("under_line");
                boolean isLight = call.argument("is_light");
                boolean isExtra = call.argument("is_extra");
                int size = call.argument("size");
                checkFont(bold, isLight, isExtra);
                sunmiPrintHelper.printText(text, size, bold, underLine, typeFont);
                result.success(true);
                break;
            case "PRINT_IMAGE":
                byte[] bytes = call.argument("bitmap");
                Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                sunmiPrintHelper.printBitmap(bitmap,0);
                result.success(true);

                break;
            case "CUT_PAPER":
                sunmiPrintHelper.cutpaper();
                result.success(true);
                break;
            case "SET_ALIGNMENT":
                int align = call.argument("alignment");
                sunmiPrintHelper.setAlign(align);
                result.success(true);
                break;
            case "LINE_WRAP":
                int lines = call.argument("lines");
                sunmiPrintHelper.printLine(lines);
                result.success(true);
                break;

            case "PRINTER_VERSION":
                String version = sunmiPrintHelper.getPrinterVersion();
                result.success(version);
                break;
            case "PRINTER_SERIALNO":
                String serialNo = sunmiPrintHelper.getPrinterSerialNo();
                result.success(serialNo);
                break;
            case "PRINT_BARCODE":
                String dataBarCode = call.argument("data");
                int symbology = call.argument("symbology");
                int height = call.argument("height");
                int width = call.argument("width");
                int textposition = call.argument("textposition");
                Log.d("PRINT_BARCODE",
                        dataBarCode + symbology + height + width + textposition + "");
                sunmiPrintHelper.printBarCode(dataBarCode, symbology, height, width, textposition);
                result.success(true);
                break;
            case "PRINT_QRCODE":
                String dataQRCode = call.argument("data");
                int modulesize = call.argument("modulesize");
                int errorlevel = call.argument("errorlevel");
                sunmiPrintHelper.printQr(dataQRCode, modulesize, errorlevel);
                result.success(true);
                break;
            case "PRINT_TABLE":
                String colsStr = call.argument("cols");
                int fontSizeT = call.argument("size");
                try {
                    JSONArray cols = new JSONArray(colsStr);
                    String[] colsText = new String[cols.length()];
                    int[] colsWidth = new int[cols.length()];
                    int[] colsAlign = new int[cols.length()];
                    for (int i = 0; i < cols.length(); i++) {
                        JSONObject col = cols.getJSONObject(i);
                        String textColumn = col.getString("text");
                        int widthColumn = col.getInt("width");
                        int alignColumn = col.getInt("align");
                        colsText[i] = textColumn;
                        colsWidth[i] = widthColumn;
                        colsAlign[i] = alignColumn;
                    }

                    sunmiPrintHelper.printTable(colsText, colsWidth, colsAlign, fontSizeT);
                    result.success(true);
                } catch (Exception err) {
                    Log.d("SunmiPrinter", err.getMessage());
                }
                break;
//            case "PRINT_BITMAP":
//                Bitmap bitmap = call.argument("bitmap");
//                int orientation = call.argument("orientation");
//                sunmiPrintHelper.printBitmap(bitmap, orientation);
//                result.success(true);
//                break;
            case "PRINT_STATUS":
//                String resultStatus = sunmiPrintHelper.showPrinterStatus();
//                result.success(resultStatus);
//                break;
            final int status_code = sunmiPrintHelper.showPrinterStatus();
            String status_msg = "";

            // response printer status
            switch (status_code) {
                case 0:
                    status_msg = "ERROR";
                    break;
                case 1:
                    status_msg = "NORMAL";
                    break;
                case 2:
                    status_msg = "PREPARING";
                    break;
                case 3:
                    status_msg = "ABNORMAL_COMMUNICATION";
                    break;
                case 4:
                    status_msg = "OUT_OF_PAPER";
                    break;
                case 5:
                    status_msg = "OVERHEATED";
                    break;
                case 6:
                    status_msg = "NOT_CLOSED";
                    break;
                case 7:
                    status_msg = "PAPER_CUTTER_ABNORMAL";
                    break;
                case 8:
                    status_msg = "PAPER_CUTTER_RECOVERED";
                    break;
                case 9:
                    status_msg = "NO_BLACK_MARK";
                    break;
                case 505:
                    status_msg = "NO_PRINTER_DETECTED";
                    break;
                case 507:
                    status_msg = "FAILED_TO_UPGRADE_FIRMWARE";
                    break;
                default:
                    status_msg = Integer.toString(status_code);
                    break;
            }
            result.success(status_msg);
            break;
            case "OPEN_CASH_BOX":
                sunmiPrintHelper.openCashBox();
                result.success(true);
                break;
            case "SENT_RAW_DATA":
                byte[] dataRaw = call.argument("data");
                sunmiPrintHelper.sendRawData(dataRaw);
                result.success(true);
                break;
            case "DEVICE_MODEL":
                String deviceModel = sunmiPrintHelper.getDeviceModel();
                result.success(deviceModel);
                break;
            case "PRINT_PAPER":
                String getPrintPaper = sunmiPrintHelper.getPrinterPaper();
                result.success(getPrintPaper);
                break;
            case "FEED_PAPER":
                sunmiPrintHelper.feedPaper();
                result.success(true);
                break;
            case "AUTO_OUT":
                sunmiPrintHelper.autoOut();
                result.success(true);
                break;
            case "BACK_LABEL_MODE":
                boolean isBackkLabel = sunmiPrintHelper.isBlackLabelMode();
                result.success(isBackkLabel);
                break;
            case "LABEL_MODEL":
                boolean isLabelMode = sunmiPrintHelper.isLabelMode();
                result.success(isLabelMode);
                break;
            case "PRINT_TRANS":
                sunmiPrintHelper.printTrans(null);
                result.success(true);
                break;
            case "CONTROL_LCD":
                int flag = call.argument("flag");
                sunmiPrintHelper.controlLcd(flag);
                result.success(true);
                break;
            case "SEND_TEXT_TOLCD":
                sunmiPrintHelper.sendTextToLcd();
                result.success(true);
                break;
            case "SEND_TEXTS_TOLCD":
                sunmiPrintHelper.sendTextsToLcd();
                result.success(true);
                break;
            case "SEND_PIC_TOLCD":
                Bitmap pic = call.argument("pic");
                sunmiPrintHelper.sendPicToLcd(pic);
                result.success(true);
                break;
            case "PRINT_ONE_LABEL":
                sunmiPrintHelper.printOneLabel();
                result.success(true);
                break;
            case "PRINT_MULTILABEL":
                int num = call.argument("num");
                sunmiPrintHelper.printMultiLabel(num);
                result.success(true);
                break;
            case "PRINTE_HEAD":
                sunmiPrintHelper.getPrinterHead(null);
                result.success(true);
                break;
            case "PRINTE_DISTANCE":
                sunmiPrintHelper.getPrinterDistance(null);
                result.success(true);
                break;

        }
        // });
    }
}
