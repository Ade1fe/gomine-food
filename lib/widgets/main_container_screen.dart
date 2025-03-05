// import 'package:flutter/material.dart';

// import '../screens/dashboard/home_screen.dart' show HomeScreen;
// // Import your other screens
// // import 'user_profile_screen.dart';
// // import 'cart_screen.dart';
// // import 'message_screen.dart';

// class MainContainerScreen extends StatefulWidget {
//   const MainContainerScreen({Key? key}) : super(key: key);

//   @override
//   State<MainContainerScreen> createState() => _MainContainerScreenState();
// }

// class _MainContainerScreenState extends State<MainContainerScreen> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

//   // Placeholder screens - replace with your actual screens
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const Center(child: Text('User Profile')), // Replace with your UserProfileScreen
//     const Center(child: Text('Cart')),         // Replace with your CartScreen
//     const Center(child: Text('Messages')),     // Replace with your MessageScreen
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _onTabChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//       _pageController.animateToPage(
//         index,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationFloating(
//         initialIndex: _currentIndex,
//         onTabChanged: _onTabChanged,
//         cartItemCount: 3,  // Make this dynamic based on your cart state
//         unreadMessageCount: 5,  // Make this dynamic based on message state
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart'; // Make sure this path is correct
import '../screens/dashboard/home_screen.dart' show HomeScreen;
// Import your other screens
// import 'user_profile_screen.dart';
// import 'cart_screen.dart';
// import 'message_screen.dart';

class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({Key? key}) : super(key: key);

  @override
  State<MainContainerScreen> createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State<MainContainerScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // Placeholder screens - replace with your actual screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(
        child: Text('User Profile')), // Replace with your UserProfileScreen
    const Center(child: Text('Cart')), // Replace with your CartScreen
    const Center(child: Text('Messages')), // Replace with your MessageScreen
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationWithBadges(
        initialIndex: _currentIndex,
        onTabChanged: _onTabChanged,
        cartItemCount: 3, // Make this dynamic based on your cart state
        unreadMessageCount: 5, // Make this dynamic based on message state
      ),
    );
  }
}
