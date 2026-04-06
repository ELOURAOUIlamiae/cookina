import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppTheme.cardBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_rounded, color: AppTheme.green),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppTheme.greenBg,
                child: Center(
                  child: Text(recipe.emoji, style: const TextStyle(fontSize: 90)),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.cardBg,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.dark)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer_rounded, size: 16, color: AppTheme.textMuted),
                      const SizedBox(width: 4),
                      Text('${recipe.durationMin} min',
                          style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                      const SizedBox(width: 12),
                      const Icon(Icons.local_fire_department_rounded,
                          size: 16, color: AppTheme.orange),
                      const SizedBox(width: 4),
                      Text('${recipe.calories} cal',
                          style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                      const SizedBox(width: 12),
                      DifficultyTag(recipe.difficulty),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Ingredients
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: const Text('Ingrédients',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.dark)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: AppTheme.green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Text(recipe.ingredients[i],
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.dark)),
                  ],
                ),
              ),
              childCount: recipe.ingredients.length,
            ),
          ),

          // Steps
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: const Text('Préparation',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.dark)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                          color: AppTheme.green, shape: BoxShape.circle),
                      child: Center(
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(recipe.steps[i],
                          style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.dark,
                              height: 1.5)),
                    ),
                  ],
                ),
              ),
              childCount: recipe.steps.length,
            ),
          ),

          // Start Cooking Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {},
                child: const Text(
                  'Commencer la recette 🍳',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
