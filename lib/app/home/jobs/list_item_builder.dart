import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/home/jobs/empty_context.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuider<T> extends StatelessWidget {
  final ItemWidgetBuilder<T> itemBuilder;
  final AsyncSnapshot<List<T>> snapshot;

  const ListItemBuider(
      {Key key, @required this.itemBuilder, @required this.snapshot})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
          message: "can\'t load items right now",
          title: "Something went wrong");
    }
    return CircularProgressIndicator();
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
        itemCount: items.length + 2,
        separatorBuilder: (contex, index) => Divider(
              height: 0.5,
            ),
        itemBuilder: (context, index) {
          if (index == 0 || index == items.length + 1) {
            return Container();
          }
          return itemBuilder(context, items[index - 1]);
        });
  }
}
