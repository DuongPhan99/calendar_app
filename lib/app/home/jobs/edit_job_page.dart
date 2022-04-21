import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/home/model/job.dart';
import 'package:flutter_time_app/common_widget/show_alert_dialog.dart';
import 'package:flutter_time_app/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_time_app/services/database.dart';

class EditJobPage extends StatefulWidget {
  final Database database;
  final Job job;
  const EditJobPage({Key key, @required this.database, @required this.job})
      : super(key: key);
  static Future<void> show(BuildContext context,
      {Database database, Job job}) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => EditJobPage(
              database: database,
              job: job,
            ),
        fullscreenDialog: true));
  }

  @override
  State<EditJobPage> createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formkey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;
  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _summit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_name)) {
          showAlertDialog(context,
              title: "Name already used",
              content: "Please choose different job name",
              defaultActionText: "Ok");
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _name, ratePerHour: _ratePerHour);
          await widget.database.setJob(job);

          Navigator.pop(context);
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: "Operation failed", exception: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job == null ? "New Job" : "Edit Job"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: [
          FlatButton(
              onPressed: _summit,
              child: Text("save",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  )))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormChildren(),
        ));
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: "Job name"),
        onSaved: (value) => _name = value,
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : "Name can\'t be empty",
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: "Rate per hour",
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
      )
    ];
  }
}
