import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/home/account/account_page.dart';
import 'package:flutter_time_app/app/home/cupetino_home_scaffold.dart';
import 'package:flutter_time_app/app/home/entries/entries_page.dart';
import 'package:flutter_time_app/app/home/tab_item.dart';

import 'jobs/job_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };
  Map<TabItem, WidgetBuilder> get WidgetBuilders {
    return {
      TabItem.jobs: (_) => JobPage(),
      TabItem.entries: (_) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        WidgetBuilders: WidgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
