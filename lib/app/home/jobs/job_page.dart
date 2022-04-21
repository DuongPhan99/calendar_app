import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/home/job_entries/job_entries_page.dart';
import 'package:flutter_time_app/app/home/jobs/edit_job_page.dart';
import 'package:flutter_time_app/app/home/jobs/empty_context.dart';
import 'package:flutter_time_app/app/home/jobs/job_list_title.dart';
import 'package:flutter_time_app/app/home/jobs/list_item_builder.dart';
import 'package:flutter_time_app/app/home/model/job.dart';
import 'package:flutter_time_app/common_widget/show_alert_dialog.dart';
import 'package:flutter_time_app/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_time_app/services/auth.dart';
import 'package:flutter_time_app/services/database.dart';

import 'package:provider/provider.dart';

import '../../../services/auth.dart';

class JobPage extends StatelessWidget {
  Future<void> _detele(BuildContext context, job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context, title: "Operation faied", exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Jobs",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
              onPressed: () => EditJobPage.show(context,
                  database: Provider.of<Database>(context, listen: false)),
              child: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          return ListItemBuider(
              snapshot: snapshot,
              itemBuilder: (context, job) => Dismissible(
                    key: Key('job-${job.id}'),
                    background: Container(
                      color: Colors.red,
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) => _detele(context, job),
                    child: JobListTitle(
                      job: job,
                      ontap: () => JobEntriesPage.show(context, job),
                    ),
                  ));
        });
  }
}
