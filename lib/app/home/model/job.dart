import 'package:flutter/material.dart';
import 'dart:ui';

class Job {
  Job({@required this.name, @required this.ratePerHour, @required this.id});
  final String id;
  final String name;
  final int ratePerHour;
  factory Job.fromMap(Map<String, dynamic> data, String documentid) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];
    return Job(name: name, ratePerHour: ratePerHour, id: documentid);
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'ratePerHour': ratePerHour};
  }

  @override
  // TODO: implement hashCode
  int get hashCode => hashValues(id, name, ratePerHour);
  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Job otherJob = other;
    return id == otherJob.id &&
        name == otherJob.name &&
        ratePerHour == otherJob.ratePerHour;
  }
}
