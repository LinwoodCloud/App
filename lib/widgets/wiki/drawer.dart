import 'package:flutter/material.dart';
import 'package:linwood_app/models/wiki.dart';
import 'package:linwood_app/pages.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../main.dart';

class WikiDrawer extends StatefulWidget {
  const WikiDrawer({@required this.permanentlyDisplay, Key key, @required this.wiki})
      : super(key: key);

  final bool permanentlyDisplay;
  final Wiki wiki;
  @override
  _WikiDrawerState createState() => _WikiDrawerState();
}

class _WikiDrawerState extends State<WikiDrawer> with RouteAware {
  String _selectedRoute;
  AppRouteObserver _routeObserver;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _updateSelectedRoute();
    super.didPush();
  }

  @override
  void didPop() {
    _updateSelectedRoute();
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    // return Drawer(
    //     child: Row(children: [
    //   Expanded(
    //       child: ListView(padding: EdgeInsets.zero, children: [
    //     DrawerHeader(
    //       child: Column(children: [
    //         Center(
    //           child: new ListView(
    //             shrinkWrap: true,
    //             scrollDirection: Axis.horizontal,
    //             padding: const EdgeInsets.all(20.0),
    //             children: [
    //               IconButton(
    //                 icon: Icon(MdiIcons.cogs),
    //                 onPressed: () {},
    //               ),
    //               IconButton(
    //                 icon: Icon(MdiIcons.logout),
    //                 onPressed: () {},
    //               )
    //             ],
    //           ),
    //         ),
    //         Image.asset(
    //           "assets/icon.png",
    //           height: 70,
    //         ),
    //         SizedBox(
    //           height: 50,
    //         ),
    //         Text("Evervent", style: Theme.of(context).textTheme.headline5),
    //         Text("github.com/codedoctorde/evervent",
    //             style: Theme.of(context).textTheme.subtitle1),
    //       ]),
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.home),
    //       title: const Text("Home"),
    //       onTap: () async {
    //         await _navigateTo(context, RoutePages.home);
    //       },
    //       selected: _selectedRoute == RoutePages.home,
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.home),
    //       title: const Text("Settings"),
    //       onTap: () async {
    //         await _navigateTo(context, RoutePages.settings);
    //       },
    //       selected: _selectedRoute == RoutePages.settings,
    //     ),
    //   ]))
    // ]));
    return SafeArea(
        right: false,
        child: Drawer(
            child: Row(children: [
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: [
              FlatButton.icon(
                color: Theme.of(context).primaryColor,
                textTheme: ButtonTextTheme.primary,
                icon: Icon(MdiIcons.keyboardBackspace),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                onPressed: () {
                  if (!widget.permanentlyDisplay) Navigator.pop(context);
                  Navigator.of(context).pop();
                },
                label: Text("Back"),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(widget.wiki.name, style: Theme.of(context).textTheme.headline5),
                    Text(widget.wiki.description, style: Theme.of(context).textTheme.subtitle2),
                  ])),
              ListTile(
                leading: const Icon(MdiIcons.homeOutline),
                title: const Text("Home"),
                onTap: () async {
                  await _replaceNavigateTo(context, RoutePages.home);
                },
                selected: _selectedRoute == RoutePages.home,
              ),
              ListTile(
                leading: const Icon(MdiIcons.forumOutline),
                title: const Text("Guilds"),
                onTap: () async {
                  await _replaceNavigateTo(context, RoutePages.guilds);
                },
                selected: _selectedRoute == RoutePages.guilds,
              ),
              ListTile(
                leading: const Icon(MdiIcons.bellOutline),
                title: const Text("Notification"),
                onTap: () async {
                  await _replaceNavigateTo(context, RoutePages.notification);
                },
                selected: _selectedRoute == RoutePages.notification,
              )
            ]),
          ),
          if (widget.permanentlyDisplay)
            const VerticalDivider(
              width: 5,
              thickness: 0.5,
            )
        ])));
  }

  /// Closes the drawer if applicable (which is only when it's not been displayed permanently) and navigates to the specified route
  /// In a mobile layout, the a modal drawer is used so we need to explicitly close it when the user selects a page to display
  Future<void> _replaceNavigateTo(BuildContext context, String routeName) async {
    if (!widget.permanentlyDisplay) Navigator.pop(context);
    await Navigator.pushReplacementNamed(context, routeName);
  }

  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context).settings.name;
    });
  }
}
