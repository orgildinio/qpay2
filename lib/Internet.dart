import 'package:flutter/material.dart';
import 'package:qpay2/colors.dart';

class Internet extends StatelessWidget {
  const Internet({Key? key, required this.qpay, required this.index}) : super(key: key);
  final List<Map<String, Object>> qpay;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 245, 248, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Жишээ",
          style: TextStyle(
              fontFamily: "Ubuntu",
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: primarycolor),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: secondarycolor,
          ),
        ),
        elevation: 0.0,
      ),
      body: Text(
        '${qpay[index]['description']}',
      ),
    );
  }
}
