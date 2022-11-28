// @dart=2.9

// ignore_for_file: missing_return, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';



class DrobDown extends StatefulWidget {
  const DrobDown({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DrobDown> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiSelect Formfield Example'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: AutovalidateMode.disabled,
                  title: const Text('My workouts'),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                  },
                  dataSource: const [
                    {
                      "display": "Running",
                      "value": "Running",
                    },
                    {
                      "display": "Climbing",
                      "value": "Climbing",
                    },
                    {
                      "display": "Walking",
                      "value": "Walking",
                    },
                    {
                      "display": "Swimming",
                      "value": "Swimming",
                    },
                    {
                      "display": "Soccer Practice",
                      "value": "Soccer Practice",
                    },
                    {
                      "display": "Baseball Practice",
                      "value": "Baseball Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },

                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,

                  // value: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  child: const Text('Save'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )
            ],
          ),
        ),
      ),
    );
  }
}