import 'package:flutter/material.dart';

class FirstDialog extends StatefulWidget {
  @override
  _FirstDialogState createState() => _FirstDialogState();
}

class _FirstDialogState extends State<FirstDialog> {
  DateTime _selectedDate;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  void _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text("Date :"),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                          "${_selectedDate == null ? 'Select Date' : _selectedDate.toLocal()}"),
                      onPressed: _selectDate,
                      color: _selectedDate == null ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text("Text :"),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(controller: _controller),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(child: Container()),
                  MaterialButton(
                    child: Text("Cancel"),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 16.0),
                  MaterialButton(
                    child: Text("Next"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(
                      context,
                      {"date": _selectedDate, "text": _controller.text},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future openFirstDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "First Dialog",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return FirstDialog();
    },
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}
