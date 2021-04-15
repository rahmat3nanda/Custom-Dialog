import 'package:flutter/material.dart';
import 'package:update_value_inside_dialog/dialog/first_dialog.dart';
import 'package:update_value_inside_dialog/dialog/second_dialog.dart';
import 'package:update_value_inside_dialog/tool/helper.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Helper _helper;
  String _text;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _helper = new Helper();
  }

  void _onPressed()async{
    Map<String,dynamic> first = await openFirstDialog(context);
    //respon dari first dialog ada 2, default null & json
    //jadi Map<String, dynamic> bisa di gatikan dengan Data Model

    if(first == null){
      _helper.showSnackbar(_scaffoldKey, "Anda Membatalkan First Dialog!");
    }else{
      bool second = await openSecondDialog(context);
      //respon dari second dialog ada 3, default null, false & true

      if(second == null || !second){
        _helper.showSnackbar(_scaffoldKey, "Anda Membatalkan Seecond Dialog!");
      }else{
        setState(() {
          _text = "$first";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Main Page")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Text("${_text ?? ''}"),
            ),
          ),
        ),
        Container(
          height: kToolbarHeight,
          width: MediaQuery.of(context).size.width,
          child: MaterialButton(
            child: Text("Open Dialog"),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: _onPressed,
          ),
        ),
      ],
    );
  }
}
