import 'package:enset_app/ui/widgets/drawer-item.widget.dart';
import 'package:enset_app/ui/widgets/main-drawer-header.widget.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> menus = [
      {
        "title": "Home",
        "leadingIcon": Icons.home,
        "trailingIcon": Icons.arrow_forward,
        "route": "/"
      },
      {
        "title": "Counter stateful",
        "leadingIcon": Icons.alarm,
        "trailingIcon": Icons.arrow_forward,
        "route": "/counter-stful"
      },
      {
        "title": "Counter Bloc",
        "leadingIcon": Icons.alarm,
        "trailingIcon": Icons.arrow_forward,
        "route": "/counter-bloc"
      },
      {
        "title": "Git Users",
        "leadingIcon": Icons.person,
        "trailingIcon": Icons.arrow_forward,
        "route": "/git-users"
      }
    ];
    return Drawer(
      child: Column(
        children: [
          const MainDrawerHeader(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return DrawerItem(
                    title: menus[index]["title"],
                    leadingIcon: menus[index]["leadingIcon"],
                    trailingIcon: menus[index]["trailingIcon"],
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, menus[index]["route"]);
                    });
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 6,
                );
              },
              itemCount: menus.length,
            ),
          )
        ],
      ),
    );
  }
}
