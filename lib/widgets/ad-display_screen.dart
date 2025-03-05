// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';

// class AdDisplayScreen extends StatefulWidget {
//   const AdDisplayScreen({super.key});

//   @override
//   _AdDisplayScreenState createState() => _AdDisplayScreenState();
// }

// class Advertisement {
//   final String backgroundImage;
//   final String title;
//   final String description;
//   final Color titleColor;
//   final Color descriptionColor;

//   Advertisement({
//     required this.backgroundImage,
//     required this.title,
//     required this.description,
//     required this.titleColor,
//     required this.descriptionColor,
//   });
// }

// class _AdDisplayScreenState extends State<AdDisplayScreen>
//     with SingleTickerProviderStateMixin {
//   // Timer to update ad content
//   Timer? _timer;
//   int _currentAdIndex = 0;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   // List of advertisements (you can add more ads)
//   final List<Advertisement> _ads = [
//     Advertisement(
//       backgroundImage: 'lib/assets/ice-cream.jpg',
//       title: 'Special Offer!',
//       description: '50% off on all items',
//       titleColor: Colors.white,
//       descriptionColor: Colors.yellow,
//     ),
//     Advertisement(
//       backgroundImage: 'lib/assets/rice.jpg',
//       title: 'Flash Sale!',
//       description: 'Limited time only!',
//       titleColor: Colors.white,
//       descriptionColor: Colors.white,
//     ),
//     Advertisement(
//       backgroundImage: 'lib/assets/cocktail.jpg',
//       title: 'New Arrival!',
//       description: 'Check out our new menu items.',
//       titleColor: Colors.white,
//       descriptionColor: Colors.white,
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Set up animation controller
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     _fadeAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//     _animationController.forward();

//     // Set up the timer to update the ad every minute
//     _timer = Timer.periodic(const Duration(minutes: 1), _updateAdContent);
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _animationController.dispose();
//     super.dispose();
//   }

//   // Function to change the ad content
//   void _updateAdContent(Timer timer) {
//     _animationController.reset();
//     setState(() {
//       _currentAdIndex = (_currentAdIndex + 1) % _ads.length;
//     });
//     _animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentAd = _ads[_currentAdIndex];

//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Container(
//         height: 200,
//         margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(16.0),
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: Image.asset(
//                   currentAd.backgroundImage,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned.fill(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                   child: Container(
//                     color: Colors.black.withOpacity(0.2),
//                   ),
//                 ),
//               ),
//               Positioned.fill(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.2),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               // Content
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         currentAd.title,
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: currentAd.titleColor,
//                           shadows: [
//                             Shadow(
//                               blurRadius: 3.0,
//                               color: Colors.black.withOpacity(0.5),
//                               offset: const Offset(1, 1),
//                             ),
//                           ],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         currentAd.description,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: currentAd.descriptionColor,
//                           shadows: [
//                             Shadow(
//                               blurRadius: 3.0,
//                               color: Colors.black.withOpacity(0.5),
//                               offset: const Offset(1, 1),
//                             ),
//                           ],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
