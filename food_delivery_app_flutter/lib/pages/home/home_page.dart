import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_flutter/pages/cart/cart_history.dart';
import 'package:food_delivery_app_flutter/pages/home/main_food_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;

//   List pages = [
//     MainFoodPage(),
//     Container(
//       child: Center(child: Text("Next page")),
//     ),
//     Container(
//       child: Center(child: Text("Next Next page")),
//     ),
//     Container(
//       child: Center(child: Text("Next Next Next page")),
//     ),
//   ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(
        child: Center(child: Text("Next page")),
      ),
      CartHistory(),
      Container(
        child: Center(child: Text("Next Next Next page")),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.archive),
        title: ("Archive"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Personal"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//           selectedItemColor: AppColors.mainColor,
//           unselectedItemColor: Colors.amberAccent,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           selectedFontSize: 0.0,
//           unselectedFontSize: 0.0,
//           currentIndex: _selectedIndex,
//           onTap: onTapNav,
//           items: const [
//             BottomNavigationBarItem(
//               label: "home",
//               icon: Icon(Icons.home_outlined),
//             ),
//             BottomNavigationBarItem(
//               label: "history",
//               icon: Icon(Icons.archive),
//             ),
//             BottomNavigationBarItem(
//               label: "cart",
//               icon: Icon(Icons.shopping_cart),
//             ),
//             BottomNavigationBarItem(
//               label: "personal",
//               icon: Icon(Icons.person),
//             ),
//           ]),
//     );
//   }
}
