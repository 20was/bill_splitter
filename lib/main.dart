import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(BillSplitter());

//Bill splitter

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bill Splitter'),
          centerTitle: true,
          backgroundColor: Color(0xff11224d),
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          color: Color(0xff11224d),
          child: ListView(
            //reverse: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xff2e406e),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total Per Person',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff37e3d5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '\$${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Color(0xff2e406e),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Bill Amount',
                        border: new OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff37e3d5))),
                        helperText: 'Input your total amount paid',
                        //labelText: 'Life story',
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        //contentPadding: EdgeInsets.only(right: 10)),
                      ),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (exception) {
                          _billAmount = 0.0;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xff11224d),
                      height: 2,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Split',
                          style: TextStyle(
                            color: Color(0xff37e3d5),
                            fontSize: 17,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  } else {
                                    //do nothing
                                  }
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff37e3d5),
                                ),
                                child: Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff11224d),
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '$_personCounter',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personCounter++;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff37e3d5),
                                ),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Color(0xff11224d),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xff11224d),
                      height: 2,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Tip',
                          style: TextStyle(
                            color: Color(0xff37e3d5),
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '\$ ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '$_tipPercentage%',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 17,
                          ),
                        ),
                        Slider(
                          value: _tipPercentage.toDouble(),
                          min: 0,
                          max: 100,
                          activeColor: Colors.green,
                          inactiveColor: Colors.red,
                          //divisions: 5,
                          onChanged: (double value) {
                            setState(() {
                              _tipPercentage = value.round();
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
  var totalPerPerson =
      (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
          splitBy;
  return totalPerPerson.toStringAsFixed(2);
}

calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
  double totalTip = 0.0;
  if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
  } else {
    totalTip = (billAmount * tipPercentage) / 100;
  }
  return totalTip;
}
