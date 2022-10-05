import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:qpay2/Internet.dart';
import 'package:qpay2/qpay_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'colors.dart';
class Internetbank extends StatefulWidget {
  const Internetbank({Key? key,}) : super(key: key);
  @override
  State<Internetbank> createState() => _InternetbankState();
}
class _InternetbankState extends State<Internetbank> {
  int payingloan = 0;
  List<Qpay> qpaylist = [];
  List<String> qpaystring = [];
  late List data;
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onSurface: Colors.white,
                  elevation: 0.0,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: Colors.white,
                  shadowColor: Colors.white),
              onPressed: () {
                internet();
              },
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "Интернэт банкаар",
                      style: TextStyle(
                        fontFamily: "Ubuntu",
                        color: primarycolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: secondarycolor,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: qpaylist.isNotEmpty ? ListView.builder(
                  itemCount: qpaylist.length,
                  itemBuilder: (BuildContext context, index) {
                    Qpay qpaying11 = qpaylist[index];
                    return Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          primary: Colors.white,
                          onPrimary: Colors.black87,
                          elevation: 0.0,
                          shadowColor: Colors.yellow[200],
                        ),
                        onPressed: () async {
                          final url = Uri.parse(qpaying11.link);
                          if(!await launchUrl(url, )){
                            throw 'Could not launch $url';
                          }
                        },
                        child: InkResponse(
                          child: Ink(
                            child: Container(
                              constraints: BoxConstraints.expand(height: 48),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(child: Image.network(qpaying11.logo,height: 80, width: 80,),),
                                  SizedBox(height: 10,),
                                  Expanded(child: Center(
                                    child: Text(qpaying11.description),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

              ) : Container(),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
Future<List<Qpay>> internet() async {
  setState(() {
    qpaylist.clear();
  });
  http.post(
    Uri.parse("http://192.168.1.110:3000/qpay/invoice"),
    headers: {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNlM2UzNmI0LTAwMmItNDEwNi1iZWYzLWE4NDJkNGNhOGUzZCIsInNlc3Npb25fc2VjcmV0IjoiJDJiJDEwJEg3R3JuY3JEdmtGLmNjRWJ5eTZXTnUxNmZrQW9KTkg4bGxMYWRzMGlzR3Y0QW5NRnEwcFlDIiwiaWF0IjoxNjY0MzQ3OTIxLCJleHAiOjMzMjg3OTY2NDJ9.PghkodAFn4tEgku6PPlbMHhhpvBccHzHZE3NofAmQoU',
    },
    body: jsonEncode({
      //'amount': payingloan / 0.99,
      'amount': 100 / 0.99,
    }),
  ).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw Exception("error");
    }
    var listData = json.decode(response.body);
    data = listData['urls'];
    if(data != null) {
      for(Map respdata in data ) {
        Qpay qpay= Qpay(respdata['description'], respdata['logo'], respdata['link']);
        qpaylist.add(qpay);
        qpaystring.addAll([
          respdata['description'],
          respdata['logo'],
          respdata['link']
        ]);
      }
      //print(qpaylist);
      setState(() {
       // Navigator.push(context, MaterialPageRoute(builder: (context) =>  Internet(qpay: [], index: 1,)));
      });
    }
  });
  return qpaylist;
}
}

