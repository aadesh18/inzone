import 'package:flutter/material.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

import 'comment_model.dart';
import 'comment_sheet_widget.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<CommentModel> commentModelList = myAllCommentData();
  List<CommentModel> commentModelDetailList = myAllCommentDetailData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SlidingSheet(
          elevation: 8,
          cornerRadius: 16,
          snapSpec: const SnapSpec(
            snap: false,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return const CommentSheetWidget();
          },
        ),
      ),
    );
  }
}
