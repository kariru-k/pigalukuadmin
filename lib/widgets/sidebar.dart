import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../screens/admin_users.dart';
import '../screens/category_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/manage_banners.dart';
import '../screens/notification_screen.dart';
import '../screens/order_screen.dart';
import '../screens/settings_screen.dart';

class SideBarWidget {
  SideBarMenus(context, selectedRoute){
    return SideBar(
      activeBackgroundColor: Colors.greenAccent,
      activeIconColor: Colors.purpleAccent,
      header: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black45,
        child: const Center(
          child: Text(
            "MENU",
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 2
            ),
          ),
        ),
      ),
      items: const [
        AdminMenuItem(
          title: 'Dashboard',
          route: HomeScreen.id,
          icon: Icons.dashboard,
        ),
        AdminMenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: CupertinoIcons.photo,
        ),
        AdminMenuItem(
            title: 'Categories',
            route: CategoryScreen.id,
            icon: Icons.category
        ),
        AdminMenuItem(
          title: 'Orders',
          route: OrderScreen.id,
          icon: CupertinoIcons.cart_fill,
        ),
        AdminMenuItem(
          title: 'Admin Users',
          route: AdminUsers.id,
          icon: Icons.admin_panel_settings_sharp,
        ),
        AdminMenuItem(
          title: 'Send Notifications',
          route: NotificationScreen.id,
          icon: Icons.notification_important,
        ),
        AdminMenuItem(
          title: 'Settings',
          route: SettingScreen.id,
          icon: Icons.settings,
        ),
        AdminMenuItem(
          title: 'Exit',
          route: LoginScreen.id,
          icon: Icons.logout_sharp,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
    );
  }
}