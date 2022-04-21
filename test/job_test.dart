import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_time_app/app/home/model/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });
  });
  test('job with all properties', () {
    final job = Job.fromMap({
      'name': 'Blogging',
      'ratePerHour': 10,
    }, 'acb');
    expect(job, Job(name: 'Blogging', ratePerHour: 10, id: 'acb'));
  });
}
