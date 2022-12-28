import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/home_page.dart';
import 'package:phison_realestate_mobile/pages/payments/view/payments_page.dart';
import 'package:phison_realestate_mobile/pages/profile/view/profile_page.dart';
import 'package:phison_realestate_mobile/pages/properties/view/properties_page.dart';
import 'package:phison_realestate_mobile/shared/widgets/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPage = 0;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: const [
          HomePage(),
          PropertiesPage(),
          PaymentsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: getBottomNavigationBar(
        context: context,
        currentIndex: _currentPage,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}
