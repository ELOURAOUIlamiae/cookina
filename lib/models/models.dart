class Recipe {
  final String id;
  final String name;
  final String emoji;
  final int durationMin;
  final int calories;
  final String difficulty; // 'easy', 'medium', 'hard'
  final String category; // 'healthy', 'quick', 'all'
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.emoji,
    required this.durationMin,
    required this.calories,
    required this.difficulty,
    required this.category,
    this.ingredients = const [],
    this.steps = const [],
  });
}

class MealPlan {
  final String day;
  final String? breakfast;
  final String? lunch;
  final String? dinner;

  const MealPlan({
    required this.day,
    this.breakfast,
    this.lunch,
    this.dinner,
  });

  MealPlan copyWith({String? breakfast, String? lunch, String? dinner}) {
    return MealPlan(
      day: day,
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
    );
  }
}

class ShoppingItem {
  final String name;
  bool isChecked;

  ShoppingItem({required this.name, this.isChecked = false});
}

// Sample Data
class AppData {
  static final List<Recipe> recipes = [
    Recipe(
      id: '1',
      name: 'Margherita Pizza',
      emoji: '🍕',
      durationMin: 25,
      calories: 450,
      difficulty: 'easy',
      category: 'all',
      ingredients: ['Pâte à pizza', 'Sauce tomate', 'Mozzarella', 'Basilic'],
      steps: [
        'Préchauffer le four à 220°C.',
        'Étaler la pâte sur une surface farinée.',
        'Étaler la sauce tomate sur la pâte.',
        'Ajouter la mozzarella et le basilic.',
        'Cuire 15-20 min jusqu\'à ce que la croûte soit dorée.',
      ],
    ),
    Recipe(
      id: '2',
      name: 'Beef Tacos',
      emoji: '🌮',
      durationMin: 30,
      calories: 380,
      difficulty: 'medium',
      category: 'all',
      ingredients: ['Boeuf haché', 'Tortillas', 'Tomates', 'Cheddar', 'Salade'],
      steps: [
        'Faire revenir le boeuf haché avec les épices.',
        'Chauffer les tortillas.',
        'Garnir avec le boeuf, tomates, fromage et salade.',
      ],
    ),
    Recipe(
      id: '3',
      name: 'Quinoa Salad',
      emoji: '🥗',
      durationMin: 30,
      calories: 280,
      difficulty: 'easy',
      category: 'healthy',
      ingredients: ['Quinoa', 'Concombre', 'Tomates cerises', 'Feta', 'Citron'],
      steps: [
        'Cuire le quinoa selon les instructions.',
        'Couper les légumes en dés.',
        'Mélanger quinoa, légumes et feta.',
        'Arroser de jus de citron et d\'huile d\'olive.',
      ],
    ),
    Recipe(
      id: '4',
      name: 'Chocolate Cake',
      emoji: '🎂',
      durationMin: 45,
      calories: 520,
      difficulty: 'hard',
      category: 'all',
      ingredients: ['Farine', 'Cacao', 'Oeufs', 'Beurre', 'Sucre', 'Levure'],
      steps: [
        'Préchauffer le four à 180°C.',
        'Mélanger les ingrédients secs.',
        'Incorporer les oeufs et le beurre fondu.',
        'Verser dans un moule et cuire 35 min.',
      ],
    ),
    Recipe(
      id: '5',
      name: 'Chicken Curry',
      emoji: '🍛',
      durationMin: 20,
      calories: 420,
      difficulty: 'easy',
      category: 'all',
      ingredients: ['Poulet', 'Lait de coco', 'Curry', 'Oignons', 'Tomates'],
      steps: [
        'Faire revenir les oignons.',
        'Ajouter le poulet et les épices.',
        'Verser le lait de coco et les tomates.',
        'Laisser mijoter 15 min.',
      ],
    ),
    Recipe(
      id: '6',
      name: 'Salmon Grillé',
      emoji: '🐟',
      durationMin: 15,
      calories: 320,
      difficulty: 'easy',
      category: 'healthy',
      ingredients: ['Saumon', 'Citron', 'Herbes', 'Huile d\'olive'],
      steps: [
        'Mariner le saumon avec citron et herbes.',
        'Chauffer le grill à feu moyen-fort.',
        'Griller 4-5 min de chaque côté.',
      ],
    ),
    Recipe(
      id: '7',
      name: 'Smoothie Bowl',
      emoji: '🥤',
      durationMin: 10,
      calories: 280,
      difficulty: 'easy',
      category: 'healthy',
      ingredients: ['Banane', 'Myrtilles', 'Lait d\'amande', 'Granola', 'Miel'],
      steps: [
        'Mixer banane et myrtilles avec le lait.',
        'Verser dans un bol.',
        'Garnir avec granola, fruits frais et miel.',
      ],
    ),
    Recipe(
      id: '8',
      name: 'Pasta Carbonara',
      emoji: '🍝',
      durationMin: 25,
      calories: 580,
      difficulty: 'medium',
      category: 'all',
      ingredients: ['Spaghetti', 'Lardons', 'Oeufs', 'Parmesan', 'Poivre noir'],
      steps: [
        'Cuire les pâtes al dente.',
        'Faire revenir les lardons.',
        'Mélanger oeufs et parmesan.',
        'Mélanger pâtes chaudes avec la sauce hors du feu.',
      ],
    ),
  ];

  static final List<MealPlan> weekPlan = [
    MealPlan(day: 'Lun', breakfast: 'Oatmeal', lunch: 'Chicken Wrap'),
    MealPlan(day: 'Mar', lunch: 'Chicken Wrap'),
    MealPlan(day: 'Mer', dinner: 'Vegetable Curry'),
    MealPlan(day: 'Jeu', lunch: 'Pasta Carbonara'),
    MealPlan(day: 'Ven'),
    MealPlan(day: 'Sam'),
    MealPlan(day: 'Dim'),
  ];

  static final List<ShoppingItem> shoppingItems = [
    ShoppingItem(name: 'Légumes (Épinards, Carottes)', isChecked: true),
    ShoppingItem(name: 'Tomates', isChecked: true),
    ShoppingItem(name: 'Épinards', isChecked: true),
    ShoppingItem(name: 'Lait'),
    ShoppingItem(name: 'Fromage'),
    ShoppingItem(name: 'Poulet (500g)'),
    ShoppingItem(name: 'Pâtes (400g)'),
    ShoppingItem(name: "Huile d'olive"),
  ];
}
