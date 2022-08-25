import 'package:flutter/material.dart';
import 'package:quick_cart/Model/record.dart';

import '../Widgets/NumPad.dart';

class AddRecord extends StatefulWidget {
  AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  TextEditingController titleCtrl = TextEditingController();
  DateTime? _dateTime;
  TimeOfDay _time=TimeOfDay(hour: 00, minute: 00);
  String? FormattedDate;
  String? FormattedTime;
  TextEditingController descriptionCtrl = TextEditingController();
  final TextEditingController _myController = TextEditingController();
  String dropdownValue="Expense";
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final hours=_time.hour.toString().padLeft(2,"0");
    final minutes=_time.minute.toString().padLeft(2,"0");
    FormattedTime="$hours : $minutes";

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.task_alt_rounded),
          onPressed: () {
            if(formkey.currentState!.validate()){
            var data = Record(
                titleCtrl.text, descriptionCtrl.text, dropdownValue,
                _myController.text,FormattedDate,FormattedTime);
            Navigator.pop(context, data);
          }},
        ),
        body: Form(
          key: formkey,
          child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(color: Color(0xffEAE8E9)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 45, right: 15, left: 15),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: 55,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Title  ";
                        }
                      },
                      controller: titleCtrl,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Enter Title"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: 155,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Description  ";
                        }
                      },
                      controller: descriptionCtrl,
                      maxLines: 7,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Description"),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate:DateTime(2023)
                          ).then((date) =>
                          setState((){
                            _dateTime=date;
                            FormattedDate= "${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year}";
                          })
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Center(child: Text("date")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15, right: 15),
                          height: 60,
                          decoration: const BoxDecoration(color: Colors.white),
                          child:   Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  FormattedDate==null? "DATE": "$FormattedDate",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          showTimePicker(context: context,
                              initialTime: _time,
                          ).then((time) =>
                              setState((){
                                _time=time!;
                                // FormattedTime="${_time.hour}:${_time.minute}";
                              })

                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Center(child: Text("Time")),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 15, right: 15),
                          height: 60,
                          decoration: const BoxDecoration(color: Colors.white),
                          child:   Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(FormattedTime==null?"Time ":'$FormattedTime'
                                ),
                              ],
                            ),
                        ),
                      ),
                      )],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                          height: 60,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 20,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Expense', 'Income', 'Saving']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15, right: 15, left: 15, bottom: 20),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    height: 55,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SizedBox(
                      height: 70,
                      child: Center(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Amount  ";
                              }
                            },
                            controller: _myController,
                            textAlign: TextAlign.center,
                            showCursor: false,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Amount'
                            ),
                            style: const TextStyle(fontSize: 20),
                            // Disable the default soft keybaord
                            keyboardType: TextInputType.none,
                          )),
                    ),
                  ),
                  // implement the custom NumPad
                  NumPad(
                    buttonSize: 75,

                    controller: _myController,
                    delete: () {
                      _myController.text = _myController.text
                          .substring(0, _myController.text.length - 1);
                    },
                  ),

                ],
              )),
        ));
  }

}
