import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeHubApp());
}

class RecipeHubApp extends StatelessWidget {
  const RecipeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFBFBFB),
        primaryColor: const Color(0xFF22C55E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF22C55E),
          primary: const Color(0xFF22C55E),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ---------------- MODELS ----------------
class Ingredient {
  final String name;
  final String quantity;
  bool isChecked;
  Ingredient({required this.name, required this.quantity, this.isChecked = false});
}

class CookingStep {
  final int stepNumber;
  final String instruction;
  final String duration;
  final String imageUrl;
  CookingStep({required this.stepNumber, required this.instruction, required this.duration, required this.imageUrl});
}

class Recipe {
  final String title;
  final double rating;
  final int reviews;
  final String duration;
  final String difficulty;
  final int servings;
  final String desc;
  final String imageUrl;
  final List<String> tags;
  final List<Ingredient> ingredients;
  final List<CookingStep> steps;

  Recipe({
    required this.title,
    required this.rating,
    required this.reviews,
    required this.duration,
    required this.difficulty,
    required this.servings,
    required this.desc,
    required this.imageUrl,
    required this.tags,
    required this.ingredients,
    required this.steps,
  });
}

final Recipe chickenKarahi = Recipe(
  title: 'Chicken Karahi',
  rating: 4.8,
  reviews: 2500,
  duration: '45 mins',
  difficulty: 'Medium',
  servings: 4,
  desc: 'Chicken Karahi is a traditional Pakistani dish known for its rich flavor and spicy taste. Simple to make and perfect for family dinners.',
  imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=600&q=80',
  tags: ['Non-Veg', 'Spicy', 'Pakistani', 'Traditional'],
  ingredients: [
    Ingredient(name: 'Chicken (boneless)', quantity: '500g', isChecked: true),
    Ingredient(name: 'Tomatoes', quantity: '4 medium', isChecked: true),
    Ingredient(name: 'Green chilies', quantity: '4'),
    Ingredient(name: 'Garlic paste', quantity: '1 tbsp'),
    Ingredient(name: 'Ginger paste', quantity: '1 tbsp'),
    Ingredient(name: 'Yogurt', quantity: '1/2 cup'),
  ],
  steps: [
    CookingStep(stepNumber: 1, instruction: 'Heat oil in a pan, add chicken and cook until it changes color.', duration: '10 mins', imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=300&q=80'),
    CookingStep(stepNumber: 2, instruction: 'Add tomatoes, ginger, garlic and spices. Cook for 10 minutes.', duration: '10 mins', imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=300&q=80'),
    CookingStep(stepNumber: 3, instruction: 'Add yogurt and green chilies. Cook until oil separates.', duration: '15 mins', imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=300&q=80'),
    CookingStep(stepNumber: 4, instruction: 'Garnish with fresh coriander and serve hot.', duration: '5 mins', imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=300&q=80'),
  ],
);

// ---------------- SCREENS ----------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant_menu, size: 80, color: Color(0xFF22C55E)),
            SizedBox(height: 16),
            Text('RecipeHub', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            Text('Cook • Eat • Be Happy', style: TextStyle(color: Colors.white54, fontSize: 13, letterSpacing: 1.2)),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Color(0xFF22C55E)),
          ],
        ),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0;
  final _screens = const [HomeScreen(), CategoriesScreen(), FavoritesScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        selectedItemColor: const Color(0xFF22C55E),
        unselectedItemColor: Colors.black45,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.restaurant, color: Color(0xFF22C55E)),
            SizedBox(width: 8),
            Text('RecipeHub', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Today's Special", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 4),
                        const Text("Chicken Karahi", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E)),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: chickenKarahi))),
                          child: const Text('View Recipe →', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(chickenKarahi.imageUrl, width: 85, height: 85, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Popular Recipes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: chickenKarahi))),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(chickenKarahi.imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(chickenKarahi.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              Text(' ${chickenKarahi.rating}'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title), backgroundColor: const Color(0xFF22C55E)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(recipe.imageUrl, height: 220, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('${recipe.duration} • ${recipe.difficulty} • ${recipe.servings} Servings', style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 12),
                  Text(recipe.desc),
                  const SizedBox(height: 16),
                  const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...recipe.ingredients.map((ing) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 18),
                    title: Text(ing.name),
                    trailing: Text(ing.quantity),
                  )),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E)),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StepsScreen(steps: recipe.steps))),
                      child: const Text('Start Cooking', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StepsScreen extends StatelessWidget {
  final List<CookingStep> steps;
  const StepsScreen({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cooking Steps'), backgroundColor: const Color(0xFF22C55E)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: steps.length,
        itemBuilder: (_, i) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFF22C55E), child: Text('${steps[i].stepNumber}', style: const TextStyle(color: Colors.white))),
            title: Text(steps[i].instruction),
            subtitle: Text(steps[i].duration),
          ),
        ),
      ),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), backgroundColor: const Color(0xFF22C55E)),
      body: const Center(child: Text('Breakfast, Lunch, Dinner, Snacks')),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), backgroundColor: const Color(0xFF22C55E)),
      body: const Center(child: Text('Your saved recipes appear here')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), backgroundColor: const Color(0xFF22C55E)),
      body: const Center(child: Text('Ahmad Khan\nahmadkhan@gmail.com')),
    );
  }
}
