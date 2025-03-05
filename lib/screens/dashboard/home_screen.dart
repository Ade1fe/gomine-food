// import 'dart:math' show Random;

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../widgets/app_scaffold.dart' show AppScaffold;
// import '../../widgets/category_detail_screen.dart' show CategoryDetailScreen;
// import '../../widgets/custom_search_field.dart' show CustomSearchField;

// class HomeScreen extends StatefulWidget {
//   final Widget? bottomNavigationBar;

//   const HomeScreen({
//     super.key,
//     this.bottomNavigationBar,
//   });

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class MealCategory {
//   final String idCategory;
//   final String strCategory;
//   final String strCategoryThumb;
//   final String strCategoryDescription;

//   MealCategory({
//     required this.idCategory,
//     required this.strCategory,
//     required this.strCategoryThumb,
//     required this.strCategoryDescription,
//   });

//   factory MealCategory.fromJson(Map<String, dynamic> json) {
//     return MealCategory(
//       idCategory: json['idCategory'],
//       strCategory: json['strCategory'],
//       strCategoryThumb: json['strCategoryThumb'],
//       strCategoryDescription: json['strCategoryDescription'],
//     );
//   }
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final Random _random = Random();

//   bool isLoading = true;
//   List<MealCategory> categories = [];
//   List<dynamic> popularMeals = [];
//   List<dynamic> randomMeals = [];
//   String errorMessage = '';
//   bool showAllCategories = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   Future<void> _fetchData() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       // Fetch categories
//       final categoriesResponse = await http.get(
//         Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
//       );

//       // Fetch some popular meals (using Beef category as example)
//       final popularMealsResponse = await http.get(
//         Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef'),
//       );

//       // Fetch some random meals for featured section
//       List<dynamic> randomMealsList = [];
//       for (int i = 0; i < 3; i++) {
//         final randomResponse = await http.get(
//           Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
//         );
//         if (randomResponse.statusCode == 200) {
//           final data = json.decode(randomResponse.body);
//           if (data['meals'] != null && data['meals'].isNotEmpty) {
//             randomMealsList.add(data['meals'][0]);
//           }
//         }
//       }

//       if (categoriesResponse.statusCode == 200 &&
//           popularMealsResponse.statusCode == 200) {
//         final categoriesData = json.decode(categoriesResponse.body);
//         final popularMealsData = json.decode(popularMealsResponse.body);

//         List<MealCategory> parsedCategories = [];
//         if (categoriesData['categories'] != null) {
//           for (var category in categoriesData['categories']) {
//             parsedCategories.add(MealCategory.fromJson(category));
//           }
//         }

//         setState(() {
//           categories = parsedCategories;
//           popularMeals = popularMealsData['meals'] ?? [];
//           randomMeals = randomMealsList;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to load data. Please try again.';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }

//   // Generate a random cooking time for demo purposes
//   String getRandomCookingTime() {
//     final times = ['15 min', '20 min', '30 min', '45 min', '1 hour'];
//     return times[_random.nextInt(times.length)];
//   }

//   // Generate a random difficulty level for demo purposes
//   String getRandomDifficulty() {
//     final difficulties = ['Easy', 'Medium', 'Hard'];
//     return difficulties[_random.nextInt(difficulties.length)];
//   }

//   void _navigateToCategoryDetail(MealCategory category) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CategoryDetailScreen(
//           category: category,
//           cookingTime: getRandomCookingTime(),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       padding: EdgeInsets.zero,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 Icons.restaurant_menu,
//                 color: Theme.of(context).primaryColor,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'MealDB Recipes',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Find your favorite recipes',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(right: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 1,
//                   blurRadius: 6,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: IconButton(
//                 icon: const Icon(Icons.notifications_none, color: Colors.black),
//                 onPressed: () {
//                   // Notification action
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.error_outline, size: 48, color: Colors.red),
//                       SizedBox(height: 16),
//                       Text(
//                         errorMessage,
//                         style: TextStyle(fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: _fetchData,
//                         child: Text('Try Again'),
//                       ),
//                     ],
//                   ),
//                 )
//               : RefreshIndicator(
//                   onRefresh: _fetchData,
//                   child: SingleChildScrollView(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Welcome message
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//                           child: Text(
//                             'What would you like to cook today?',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),

//                         // Search and filter
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: CustomSearchField(
//                                   controller: _searchController,
//                                   hintText: 'Search for recipes...',
//                                   onChanged: (query) {
//                                     print("Search query: $query");
//                                   },
//                                   onClear: () {
//                                     _searchController.clear();
//                                   },
//                                   backgroundColor: Colors.grey[100]!,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Container(
//                                 width: 48,
//                                 height: 48,
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).primaryColor,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: IconButton(
//                                   icon: const Icon(Icons.tune,
//                                       color: Colors.white),
//                                   onPressed: () {
//                                     // Filter action
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // Featured recipes carousel
//                         Container(
//                           height: 180,
//                           margin: const EdgeInsets.symmetric(vertical: 15),
//                           child: ListView.builder(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             scrollDirection: Axis.horizontal,
//                             itemCount: randomMeals.length,
//                             itemBuilder: (context, index) {
//                               final meal = randomMeals[index];
//                               return Container(
//                                 width: MediaQuery.of(context).size.width * 0.85,
//                                 margin:
//                                     const EdgeInsets.symmetric(horizontal: 5),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(16),
//                                   image: DecorationImage(
//                                     image: NetworkImage(meal['strMealThumb']),
//                                     fit: BoxFit.cover,
//                                     colorFilter: ColorFilter.mode(
//                                       Colors.black.withOpacity(0.3),
//                                       BlendMode.darken,
//                                     ),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 5),
//                                         decoration: BoxDecoration(
//                                           color: Colors.red,
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Text(
//                                           'FEATURED RECIPE',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         meal['strMeal'],
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         meal['strArea'] ??
//                                             'International Cuisine',
//                                         style: TextStyle(
//                                           color: Colors.white.withOpacity(0.8),
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),

//                         // Categories
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Categories',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 120,
//                           child: ListView.builder(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             scrollDirection: Axis.horizontal,
//                             itemCount: categories.length,
//                             itemBuilder: (context, index) {
//                               final category = categories[index];
//                               return GestureDetector(
//                                 onTap: () =>
//                                     _navigateToCategoryDetail(category),
//                                 child: Container(
//                                   width: 100,
//                                   margin:
//                                       const EdgeInsets.symmetric(horizontal: 5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         width: 70,
//                                         height: 70,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                                 category.strCategoryThumb),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         category.strCategory,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),

//                         // Popular recipes
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Popular Recipes',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   // View all recipes
//                                 },
//                                 child: Text(
//                                   'See All',
//                                   style: TextStyle(
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListView.builder(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount:
//                               popularMeals.length > 3 ? 3 : popularMeals.length,
//                           itemBuilder: (context, index) {
//                             final meal = popularMeals[index];
//                             final cookingTime = getRandomCookingTime();
//                             final difficulty = getRandomDifficulty();

//                             return Container(
//                               margin: const EdgeInsets.only(bottom: 16),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(16),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     spreadRadius: 1,
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(16),
//                                       topRight: Radius.circular(16),
//                                     ),
//                                     child: Image.network(
//                                       meal['strMealThumb'],
//                                       height: 150,
//                                       width: double.infinity,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(12),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 meal['strMeal'],
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.star,
//                                                   color: Colors.amber,
//                                                   size: 18,
//                                                 ),
//                                                 const SizedBox(width: 4),
//                                                 Text(
//                                                   (4.0 +
//                                                           (meal['idMeal']
//                                                                       .hashCode %
//                                                                   10) /
//                                                               10)
//                                                       .toStringAsFixed(1),
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Row(
//                                           children: [
//                                             Container(
//                                               margin: const EdgeInsets.only(
//                                                   right: 8),
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal: 8,
//                                                 vertical: 4,
//                                               ),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.orange
//                                                     .withOpacity(0.2),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(Icons.access_time,
//                                                       size: 14,
//                                                       color: Colors.orange),
//                                                   SizedBox(width: 4),
//                                                   Text(
//                                                     cookingTime,
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.orange,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal: 8,
//                                                 vertical: 4,
//                                               ),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.blue
//                                                     .withOpacity(0.2),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(Icons.trending_up,
//                                                       size: 14,
//                                                       color: Colors.blue),
//                                                   SizedBox(width: 4),
//                                                   Text(
//                                                     difficulty,
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.blue,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               'Beef', // MealDB doesn't provide category in filter results
//                                               style: TextStyle(
//                                                 color: Colors.grey[600],
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 // View recipe details
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor:
//                                                     Theme.of(context)
//                                                         .primaryColor,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 12,
//                                                         vertical: 6),
//                                               ),
//                                               child: Text('View Recipe'),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),

//                         // Recommended recipes
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Recommended For You',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   // View all recommended
//                                 },
//                                 child: Text(
//                                   'See All',
//                                   style: TextStyle(
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 220,
//                           child: ListView.builder(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             scrollDirection: Axis.horizontal,
//                             itemCount: popularMeals.length,
//                             itemBuilder: (context, index) {
//                               final meal = popularMeals[index];
//                               final cookingTime = getRandomCookingTime();

//                               return Container(
//                                 width: 160,
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 5, vertical: 5),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(16),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.1),
//                                       spreadRadius: 1,
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 3),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(16),
//                                         topRight: Radius.circular(16),
//                                       ),
//                                       child: Image.network(
//                                         meal['strMealThumb'],
//                                         height: 120,
//                                         width: double.infinity,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             meal['strMeal'],
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             'Beef Recipe', // MealDB doesn't provide category in filter results
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.grey[600],
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.access_time,
//                                                     size: 14,
//                                                     color: Colors.grey[600],
//                                                   ),
//                                                   const SizedBox(width: 4),
//                                                   Text(
//                                                     cookingTime,
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.grey[600],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 16,
//                                                   ),
//                                                   const SizedBox(width: 2),
//                                                   Text(
//                                                     (4.0 +
//                                                             (meal['idMeal']
//                                                                         .hashCode %
//                                                                     10) /
//                                                                 10)
//                                                         .toStringAsFixed(1),
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),

//                         // Recently viewed
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
//                           child: Text(
//                             'Recently Viewed',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(20, 5, 20, 30),
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 spreadRadius: 1,
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   popularMeals.isNotEmpty
//                                       ? popularMeals[0]['strMealThumb']
//                                       : 'https://via.placeholder.com/70',
//                                   width: 70,
//                                   height: 70,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       popularMeals.isNotEmpty
//                                           ? popularMeals[0]['strMeal']
//                                           : 'Recipe Name',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       'Beef Recipe',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       'Viewed 2 days ago',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[500],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   // View recipe action
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                       Theme.of(context).primaryColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 8),
//                                 ),
//                                 child: Text('View'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//       bottomNavigationBar: widget.bottomNavigationBar,
//     );
//   }
// }

import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:gomine_food/widgets/custom_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../consants/image_constants.dart' show ImageConstants;
import '../../widgets/app_scaffold.dart' show AppScaffold;
import '../../widgets/category_detail_screen.dart' show CategoryDetailScreen;
import '../../widgets/custom_search_field.dart' show CustomSearchField;

class HomeScreen extends StatefulWidget {
  final Widget? bottomNavigationBar;

  const HomeScreen({
    super.key,
    this.bottomNavigationBar,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class MealCategory {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  MealCategory({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      idCategory: json['idCategory'],
      strCategory: json['strCategory'],
      strCategoryThumb: json['strCategoryThumb'],
      strCategoryDescription: json['strCategoryDescription'],
    );
  }
}

// Create a new screen to display all items
class AllItemsScreen extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final bool isPopular;
  final bool isRecommended;
  final Function getRandomCookingTime;
  final Function getRandomDifficulty;

  const AllItemsScreen({
    Key? key,
    required this.title,
    required this.items,
    this.isPopular = false,
    this.isRecommended = false,
    required this.getRandomCookingTime,
    required this.getRandomDifficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isRecommended
          ? GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final meal = items[index];
                final cookingTime = getRandomCookingTime();

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          meal['strMealThumb'],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal['strMeal'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Beef Recipe',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      cookingTime,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      (4.0 +
                                              (meal['idMeal'].hashCode % 10) /
                                                  10)
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final meal = items[index];
                final cookingTime = getRandomCookingTime();
                final difficulty = getRandomDifficulty();

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          meal['strMealThumb'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    meal['strMeal'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      (4.0 +
                                              (meal['idMeal'].hashCode % 10) /
                                                  10)
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time,
                                          size: 14, color: Colors.orange),
                                      SizedBox(width: 4),
                                      Text(
                                        cookingTime,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.trending_up,
                                          size: 14, color: Colors.blue),
                                      SizedBox(width: 4),
                                      Text(
                                        difficulty,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Beef',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                CustomButton(
                                    text: 'View recipe', onPressed: () {})
                                // ElevatedButton(
                                //   onPressed: () {
                                //     // View recipe details
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor:
                                //         Theme.of(context).primaryColor,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //     ),
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 12, vertical: 6),
                                //   ),
                                //   child: Text('View Recipe'),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// Create a screen to display all categories
class AllCategoriesScreen extends StatelessWidget {
  final List<MealCategory> categories;
  final Function navigateToCategoryDetail;
  final Function getRandomCookingTime;

  const AllCategoriesScreen({
    Key? key,
    required this.categories,
    required this.navigateToCategoryDetail,
    required this.getRandomCookingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          'All Categories',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => navigateToCategoryDetail(category),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(category.strCategoryThumb),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.strCategory,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Random _random = Random();

  bool isLoading = true;
  List<MealCategory> categories = [];
  List<dynamic> popularMeals = [];
  List<dynamic> randomMeals = [];
  String errorMessage = '';
  bool showAllCategories = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Fetch categories
      final categoriesResponse = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
      );

      // Fetch some popular meals (using Beef category as example)
      final popularMealsResponse = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef'),
      );

      // Fetch some random meals for featured section
      List<dynamic> randomMealsList = [];
      for (int i = 0; i < 3; i++) {
        final randomResponse = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
        );
        if (randomResponse.statusCode == 200) {
          final data = json.decode(randomResponse.body);
          if (data['meals'] != null && data['meals'].isNotEmpty) {
            randomMealsList.add(data['meals'][0]);
          }
        }
      }

      if (categoriesResponse.statusCode == 200 &&
          popularMealsResponse.statusCode == 200) {
        final categoriesData = json.decode(categoriesResponse.body);
        final popularMealsData = json.decode(popularMealsResponse.body);

        List<MealCategory> parsedCategories = [];
        if (categoriesData['categories'] != null) {
          for (var category in categoriesData['categories']) {
            parsedCategories.add(MealCategory.fromJson(category));
          }
        }

        setState(() {
          categories = parsedCategories;
          popularMeals = popularMealsData['meals'] ?? [];
          randomMeals = randomMealsList;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data. Please try again.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  // Generate a random cooking time for demo purposes
  String getRandomCookingTime() {
    final times = ['15 min', '20 min', '30 min', '45 min', '1 hour'];
    return times[_random.nextInt(times.length)];
  }

  // Generate a random difficulty level for demo purposes
  String getRandomDifficulty() {
    final difficulties = ['Easy', 'Medium', 'Hard'];
    return difficulties[_random.nextInt(difficulties.length)];
  }

  void _navigateToCategoryDetail(MealCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(
          category: category,
          cookingTime: getRandomCookingTime(),
        ),
      ),
    );
  }

  // Navigate to see all categories
  void _navigateToAllCategories() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllCategoriesScreen(
          categories: categories,
          navigateToCategoryDetail: _navigateToCategoryDetail,
          getRandomCookingTime: getRandomCookingTime,
        ),
      ),
    );
  }

  // Navigate to see all popular recipes
  void _navigateToAllPopularRecipes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllItemsScreen(
          title: 'Popular Recipes',
          items: popularMeals,
          isPopular: true,
          getRandomCookingTime: getRandomCookingTime,
          getRandomDifficulty: getRandomDifficulty,
        ),
      ),
    );
  }

  // Navigate to see all recommended recipes
  void _navigateToAllRecommendedRecipes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllItemsScreen(
          title: 'Recommended For You',
          items: popularMeals,
          isRecommended: true,
          getRandomCookingTime: getRandomCookingTime,
          getRandomDifficulty: getRandomDifficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero, // Remove default padding
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              // child: Icon(
              //   Icons.restaurant_menu,
              //   color: Theme.of(context).primaryColor,
              //   size: 20,
              // ),
              child: Image.asset(
                ImageConstants.logo,
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gomine-Food',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Find your favorite recipes',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {
                  // Notification action
                },
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        errorMessage,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchData,
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome message
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Text(
                            'What would you like to cook today?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // Search and filter
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomSearchField(
                                  controller: _searchController,
                                  hintText: 'Search for recipes...',
                                  onChanged: (query) {
                                    print("Search query: $query");
                                  },
                                  onClear: () {
                                    _searchController.clear();
                                  },
                                  backgroundColor: Colors.grey[100]!,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.tune,
                                      color: Colors.white),
                                  onPressed: () {
                                    // Filter action
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Featured recipes carousel
                        Container(
                          height: 180,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: randomMeals.length,
                            itemBuilder: (context, index) {
                              final meal = randomMeals[index];
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(meal['strMealThumb']),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'FEATURED RECIPE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        meal['strMeal'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        meal['strArea'] ??
                                            'International Cuisine',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Categories
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: _navigateToAllCategories,
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return GestureDetector(
                                onTap: () =>
                                    _navigateToCategoryDetail(category),
                                child: Container(
                                  width: 100,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                category.strCategoryThumb),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        category.strCategory,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Popular recipes
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular Recipes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: _navigateToAllPopularRecipes,
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              popularMeals.length > 3 ? 3 : popularMeals.length,
                          itemBuilder: (context, index) {
                            final meal = popularMeals[index];
                            final cookingTime = getRandomCookingTime();
                            final difficulty = getRandomDifficulty();

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.network(
                                      meal['strMealThumb'],
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                meal['strMeal'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  (4.0 +
                                                          (meal['idMeal']
                                                                      .hashCode %
                                                                  10) /
                                                              10)
                                                      .toStringAsFixed(1),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.orange
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.access_time,
                                                      size: 14,
                                                      color: Colors.orange),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    cookingTime,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.trending_up,
                                                      size: 14,
                                                      color: Colors.blue),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    difficulty,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Beef',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                              ),
                                            ),
                                            CustomButton(
                                                text: 'View recipe',
                                                onPressed: () {})
                                            // ElevatedButton(
                                            //   onPressed: () {
                                            //     // View recipe details
                                            //   },
                                            //   style: ElevatedButton.styleFrom(
                                            //     backgroundColor:
                                            //         Theme.of(context)
                                            //             .primaryColor,
                                            //     shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(12),
                                            //     ),
                                            //     padding:
                                            //         const EdgeInsets.symmetric(
                                            //             horizontal: 12,
                                            //             vertical: 6),
                                            //   ),
                                            //   child: Text('View Recipe'),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        // Recommended recipes
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recommended For You',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: _navigateToAllRecommendedRecipes,
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: popularMeals.length,
                            itemBuilder: (context, index) {
                              final meal = popularMeals[index];
                              final cookingTime = getRandomCookingTime();

                              return Container(
                                width: 160,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                      child: Image.network(
                                        meal['strMealThumb'],
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            meal['strMeal'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Beef Recipe', // MealDB doesn't provide category in filter results
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    cookingTime,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    (4.0 +
                                                            (meal['idMeal']
                                                                        .hashCode %
                                                                    10) /
                                                                10)
                                                        .toStringAsFixed(1),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        // Recently viewed
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Text(
                            'Recently Viewed',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  popularMeals.isNotEmpty
                                      ? popularMeals[0]['strMealThumb']
                                      : 'https://via.placeholder.com/70',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      popularMeals.isNotEmpty
                                          ? popularMeals[0]['strMeal']
                                          : 'Recipe Name',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Beef Recipe',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Viewed 2 days ago',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomButton(text: 'View', onPressed: () {})
                              // ElevatedButton(
                              //   onPressed: () {
                              //     // View recipe action
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor:
                              //         Theme.of(context).primaryColor,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 16, vertical: 8),
                              //   ),
                              //   child: Text('View'),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
