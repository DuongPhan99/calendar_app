import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/home/model/job.dart';

class JobListTitle extends StatelessWidget {
  final Job job;
  final VoidCallback ontap;
  JobListTitle({this.job, this.ontap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: ontap,
    );
  }
}
