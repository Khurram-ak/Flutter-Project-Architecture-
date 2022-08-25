import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/record.dart';
import 'AddRecord.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, double> dataMap = {
    "Expense": 0,
    "Income": 0,
    "Saving": 0,
  };

  int Expense = 0;
  int Income = 0;
  int Saving = 0;
  List<Record> records = [];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color(0xffEAE8E9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push<Record>(
                          context,
                          MaterialPageRoute(builder: (context) => AddRecord()),
                        ).then((value) => {
                              if (value != null)
                                {
                                  setState(() {
                                    records.add(Record(
                                        value.title,
                                        value.description,
                                        value.dropdownValue,
                                        value.amount,
                                        value.FormattedDate,
                                        value.FormattedTime));
                                    if (value.dropdownValue == "Expense") {
                                      dataMap["Expense"] = Expense + 1;
                                      Expense = Expense + 1;
                                    } else if (value.dropdownValue ==
                                        "Income") {
                                      dataMap["Income"] = Income + 1;
                                      Income = Income + 1;
                                    } else if (value.dropdownValue ==
                                        "Saving") {
                                      dataMap["Saving"] = Saving + 1;
                                      Saving = Saving + 1;
                                    }
                                  })
                                }
                            });
                      },
                      child: Text("ADD")),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 20, left: 90),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartType: ChartType.ring,
                  ringStrokeWidth: 22,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontFamily: "PoppinsMed",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  chartValuesOptions:
                      ChartValuesOptions(showChartValues: false),
                )),
            SizedBox(
              height: 30,
            ),
            !records.isEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: records.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: 10, left: 17, right: 17, bottom: 10),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                records[index].dropdownValue == "Expense"
                                    ? Container(
                                        margin: EdgeInsets.only(left: 20),
                                        height: 62,
                                        width: 62,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffEAE8E9),
                                        ),
                                        child: Center(
                                            child: Image.asset(
                                          "lib/assets/images/redArrow.png",
                                          width: 35,
                                          height: 35,
                                        )))
                                    : Container(
                                        margin: EdgeInsets.only(left: 20),
                                        height: 62,
                                        width: 62,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffEAE8E9),
                                        ),
                                        child: Center(
                                            child: Image.asset(
                                          "lib/assets/images/greenArrow.png",
                                          width: 35,
                                          height: 35,
                                        ))),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${records[index].title}",
                                            style: const TextStyle(
                                              fontFamily: "PoppinsMed",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(" ${records[index].description}",
                                            style: const TextStyle(
                                                fontFamily: "PoppinsMed",
                                                fontSize: 12,
                                                color: Colors.grey)),
                                        Text(
                                            "${records[index].FormattedDate}  ${records[index].FormattedTime}  ",
                                            style: const TextStyle(
                                                fontFamily: "PoppinsMed",
                                                fontSize: 12,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 15, left: 10),
                                        child: Text(
                                          "${records[index].amount}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "PoppinsMed"),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Text(
                            "NO RECORDS ADDED YET",
                            style: TextStyle(
                                fontFamily: "PoppinsBold", fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
