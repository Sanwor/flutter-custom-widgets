import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:get/get.dart';
import 'package:syuseiclub/src/app_config/app_styles.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerPage({
    super.key,
    required this.pdfUrl,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Theme(
  data: ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: darkBlue),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearTrackColor: darkBlue,
    ),
  ),
  child: SfPdfViewer.network(
    widget.pdfUrl,
    key: _pdfViewerKey,
    controller: _pdfViewerController,
    enableDoubleTapZooming: true,
    canShowScrollHead: true,
    canShowScrollStatus: true,
    enableTextSelection: true,
  ),
)

    );
  }

  _buildAppbar() {
    return AppBar(
      backgroundColor: white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.pdfUrl, style: interBold(size: 14.sp, color: black),) ,
        ],
      ),
      shadowColor: grey1 ,
      actions: [
        IconButton(
          onPressed:() => Get.back(), 
          icon: const Icon(
            Icons.close, 
            color: grey4, 
            size: 30
          )
        ),
      ],
    );
  }
}
