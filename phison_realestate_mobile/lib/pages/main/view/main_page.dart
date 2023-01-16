import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/home_page.dart';
import 'package:phison_realestate_mobile/pages/payments/view/payments_page.dart';
import 'package:phison_realestate_mobile/pages/profile/view/profile_page.dart';
import 'package:phison_realestate_mobile/pages/properties/view/properties_page.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';
import 'package:phison_realestate_mobile/shared/widgets/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

  static Page page() => const MaterialPage<void>(child: MainPage());
}

class _MainPageState extends State<MainPage> {
  int _currentPage = 0;
  final _controller = PageController();
  final _propertiesRepository = PropertiesRepository();

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
        children: [
          HomePage(propertiesRepository: _propertiesRepository),
          const PropertiesPage(),
          const PaymentsPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: PhisonBottomBar(
        containerHeight: 40,
        backgroundColor: Colors.white,
        selectedIndex: _currentPage,
        showElevation: true,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 270),
            curve: Curves.easeIn,
          );
        },
        items: <BottomNavBarItem>[
          BottomNavBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            textAlign: TextAlign.center,
          ),
          BottomNavBarItem(
            icon: const Icon(Icons.explore_outlined),
            title: const Text('Properties'),
            textAlign: TextAlign.center,
          ),
          BottomNavBarItem(
            icon: const Icon(Icons.credit_card_outlined),
            title: const Text('Payments'),
            textAlign: TextAlign.center,
          ),
          BottomNavBarItem(
            icon: const Icon(Icons.person_outline_outlined),
            title: const Text('Profile '),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
