import 'package:flutter/material.dart';
import 'package:qpay2/qpay_list.dart';

import 'colors.dart';


class Internet extends StatefulWidget {
  const Internet({Key? key}) : super(key: key);

  @override
  State<Internet> createState() => _InternetState();
}

class _InternetState extends State<Internet> {
  List<Qpay> qpaylist = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Интернет банк",
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
        height: MediaQuery.of(context).size.height * 0.3,
        child: qpaylist.isNotEmpty ? ListView.builder(
          itemCount: qpaylist.length,
            itemBuilder: (BuildContext context, index){
               Qpay qpaying1 = qpaylist[index];
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
                   onPressed: () async{
                     
                   },
                   child: InkResponse(
                     child: Ink(
                       child: Container(
                         constraints: BoxConstraints.expand(height: 48),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             SizedBox(child: Image.network(qpaying1.logo, height: 80, width: 80,),),
                             SizedBox(width: 10,),
                             Expanded(child: Center(
                               child: Text(qpaying1.description),
                             )),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               );
            }) : Container(
          child: Text('1'),
        ),
      ),
    );
  }
}
