// import 'package:flutter/material.dart';

// class BottomNavigation extends StatefulWidget {
//   final int initialIndex;
//   final Function(int) onTabChanged;

//   const BottomNavigation({
//     Key? key,
//     this.initialIndex = 0,
//     required this.onTabChanged,
//   }) : super(key: key);

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation>
//     with SingleTickerProviderStateMixin {
//   late int _selectedIndex;
//   late AnimationController _animationController;
//   final List<GlobalKey> _navKeys = List.generate(4, (index) => GlobalKey());

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.initialIndex;
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     if (_selectedIndex == index) return;

//     setState(() {
//       _selectedIndex = index;
//       _animationController.reset();
//       _animationController.forward();
//     });

//     widget.onTabChanged(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(0, 'Home', Icons.home_rounded),
//               _buildNavItem(1, 'User', Icons.person_rounded),
//               _buildNavItem(2, 'Cart', Icons.shopping_cart_rounded),
//               _buildNavItem(3, 'Message', Icons.chat_bubble_rounded),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, String label, IconData icon) {
//     final isSelected = _selectedIndex == index;

//     return GestureDetector(
//       key: _navKeys[index],
//       onTap: () => _onItemTapped(index),
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOutCubic,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Theme.of(context).primaryColor.withOpacity(0.1)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: isSelected
//                       ? Offset(0, _animationController.value * -4)
//                       : Offset.zero,
//                   child: child,
//                 );
//               },
//               child: Icon(
//                 icon,
//                 color:
//                     isSelected ? Theme.of(context).primaryColor : Colors.grey,
//                 size: isSelected ? 28 : 24,
//               ),
//             ),
//             const SizedBox(height: 4),
//             AnimatedDefaultTextStyle(
//               duration: const Duration(milliseconds: 200),
//               style: TextStyle(
//                 fontSize: isSelected ? 12 : 11,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                 color:
//                     isSelected ? Theme.of(context).primaryColor : Colors.grey,
//               ),
//               child: Text(label),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Example usage in a scaffold
// class BottomNavigationExample extends StatefulWidget {
//   const BottomNavigationExample({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigationExample> createState() =>
//       _BottomNavigationExampleState();
// }

// class _BottomNavigationExampleState extends State<BottomNavigationExample> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

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
//         children: [
//           _buildPage('Home', Colors.blue),
//           _buildPage('User Profile', Colors.green),
//           _buildPage('Shopping Cart', Colors.orange),
//           _buildPage('Messages', Colors.purple),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigation(
//         initialIndex: _currentIndex,
//         onTabChanged: _onTabChanged,
//       ),
//     );
//   }

//   Widget _buildPage(String title, Color color) {
//     return Container(
//       color: color.withOpacity(0.1),
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // For a more advanced version with badges for cart and messages
// class BottomNavigationWithBadges extends StatefulWidget {
//   final int initialIndex;
//   final Function(int) onTabChanged;
//   final int cartItemCount;
//   final int unreadMessageCount;

//   const BottomNavigationWithBadges({
//     Key? key,
//     this.initialIndex = 0,
//     required this.onTabChanged,
//     this.cartItemCount = 0,
//     this.unreadMessageCount = 0,
//   }) : super(key: key);

//   @override
//   State<BottomNavigationWithBadges> createState() =>
//       _BottomNavigationWithBadgesState();
// }

// class _BottomNavigationWithBadgesState extends State<BottomNavigationWithBadges>
//     with SingleTickerProviderStateMixin {
//   late int _selectedIndex;
//   late AnimationController _animationController;
//   final List<GlobalKey> _navKeys = List.generate(4, (index) => GlobalKey());

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.initialIndex;
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     if (_selectedIndex == index) return;

//     setState(() {
//       _selectedIndex = index;
//       _animationController.reset();
//       _animationController.forward();
//     });

//     widget.onTabChanged(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(0, 'Home', Icons.home_rounded),
//               _buildNavItem(1, 'User', Icons.person_rounded),
//               _buildNavItemWithBadge(
//                   2, 'Cart', Icons.shopping_cart_rounded, widget.cartItemCount),
//               _buildNavItemWithBadge(3, 'Message', Icons.chat_bubble_rounded,
//                   widget.unreadMessageCount),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, String label, IconData icon) {
//     final isSelected = _selectedIndex == index;

//     return GestureDetector(
//       key: _navKeys[index],
//       onTap: () => _onItemTapped(index),
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOutCubic,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Theme.of(context).primaryColor.withOpacity(0.1)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: isSelected
//                       ? Offset(0, _animationController.value * -4)
//                       : Offset.zero,
//                   child: child,
//                 );
//               },
//               child: Icon(
//                 icon,
//                 color:
//                     isSelected ? Theme.of(context).primaryColor : Colors.grey,
//                 size: isSelected ? 28 : 24,
//               ),
//             ),
//             const SizedBox(height: 4),
//             AnimatedDefaultTextStyle(
//               duration: const Duration(milliseconds: 200),
//               style: TextStyle(
//                 fontSize: isSelected ? 12 : 11,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                 color:
//                     isSelected ? Theme.of(context).primaryColor : Colors.grey,
//               ),
//               child: Text(label),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItemWithBadge(
//       int index, String label, IconData icon, int count) {
//     final isSelected = _selectedIndex == index;

//     return GestureDetector(
//       key: _navKeys[index],
//       onTap: () => _onItemTapped(index),
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOutCubic,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Theme.of(context).primaryColor.withOpacity(0.1)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 AnimatedBuilder(
//                   animation: _animationController,
//                   builder: (context, child) {
//                     return Transform.translate(
//                       offset: isSelected
//                           ? Offset(0, _animationController.value * -4)
//                           : Offset.zero,
//                       child: child,
//                     );
//                   },
//                   child: Icon(
//                     icon,
//                     color: isSelected
//                         ? Theme.of(context).primaryColor
//                         : Colors.grey,
//                     size: isSelected ? 28 : 24,
//                   ),
//                 ),
//                 if (count > 0)
//                   Positioned(
//                     right: -8,
//                     top: -8,
//                     child: TweenAnimationBuilder<double>(
//                       tween: Tween(begin: 0.0, end: 1.0),
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.elasticOut,
//                       builder: (context, value, child) {
//                         return Transform.scale(
//                           scale: value,
//                           child: child,
//                         );
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 18,
//                           minHeight: 18,
//                         ),
//                         child: Center(
//                           child: Text(
//                             count > 99 ? '99+' : count.toString(),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             AnimatedDefaultTextStyle(
//               duration: const Duration(milliseconds: 200),
//               style: TextStyle(
//                 fontSize: isSelected ? 12 : 11,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                 color:
//                     isSelected ? Theme.of(context).primaryColor : Colors.grey,
//               ),
//               child: Text(label),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  final Function(int) onTabChanged;

  const BottomNavigation({
    Key? key,
    this.initialIndex = 0,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _animationController;
  final List<GlobalKey> _navKeys = List.generate(4, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
      _animationController.reset();
      _animationController.forward();
    });

    widget.onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Increased height to accommodate content
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        // Set maintainBottomViewPadding to true to handle bottom insets properly
        maintainBottomViewPadding: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, 'Home', Icons.home_rounded),
              _buildNavItem(1, 'User', Icons.person_rounded),
              _buildNavItem(2, 'Cart', Icons.shopping_cart_rounded),
              _buildNavItem(3, 'Message', Icons.chat_bubble_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      key: _navKeys[index],
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 6), // Reduced vertical padding
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: isSelected
                      ? Offset(0, _animationController.value * -4)
                      : Offset.zero,
                  child: child,
                );
              },
              child: Icon(
                icon,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.grey,
                size: isSelected ? 26 : 22, // Slightly reduced icon size
              ),
            ),
            const SizedBox(height: 2), // Reduced spacing
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 11 : 10, // Slightly reduced font size
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

// For a more advanced version with badges for cart and messages
class BottomNavigationWithBadges extends StatefulWidget {
  final int initialIndex;
  final Function(int) onTabChanged;
  final int cartItemCount;
  final int unreadMessageCount;

  const BottomNavigationWithBadges({
    Key? key,
    this.initialIndex = 0,
    required this.onTabChanged,
    this.cartItemCount = 0,
    this.unreadMessageCount = 0,
  }) : super(key: key);

  @override
  State<BottomNavigationWithBadges> createState() =>
      _BottomNavigationWithBadgesState();
}

class _BottomNavigationWithBadgesState extends State<BottomNavigationWithBadges>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _animationController;
  final List<GlobalKey> _navKeys = List.generate(4, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
      _animationController.reset();
      _animationController.forward();
    });

    widget.onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Increased height to accommodate content with badges
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, 'Home', Icons.home_rounded),
              _buildNavItem(1, 'User', Icons.person_rounded),
              _buildNavItemWithBadge(
                  2, 'Cart', Icons.shopping_cart_rounded, widget.cartItemCount),
              _buildNavItemWithBadge(3, 'Message', Icons.chat_bubble_rounded,
                  widget.unreadMessageCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      key: _navKeys[index],
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 6), // Reduced vertical padding
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: isSelected
                      ? Offset(0, _animationController.value * -4)
                      : Offset.zero,
                  child: child,
                );
              },
              child: Icon(
                icon,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.grey,
                size: isSelected ? 26 : 22, // Slightly reduced icon size
              ),
            ),
            const SizedBox(height: 2), // Reduced spacing
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 11 : 10, // Slightly reduced font size
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItemWithBadge(
      int index, String label, IconData icon, int count) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      key: _navKeys[index],
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 6), // Reduced vertical padding
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: isSelected
                          ? Offset(0, _animationController.value * -4)
                          : Offset.zero,
                      child: child,
                    );
                  },
                  child: Icon(
                    icon,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    size: isSelected ? 26 : 22, // Slightly reduced icon size
                  ),
                ),
                if (count > 0)
                  Positioned(
                    right: -6, // Adjusted position
                    top: -6, // Adjusted position
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3), // Reduced padding
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16, // Reduced size
                          minHeight: 16, // Reduced size
                        ),
                        child: Center(
                          child: Text(
                            count > 99 ? '99+' : count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9, // Reduced font size
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2), // Reduced spacing
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 11 : 10, // Slightly reduced font size
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
