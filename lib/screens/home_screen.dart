import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todayMeals = AppData.recipes.take(3).toList();
    final suggested = AppData.recipes.skip(3).take(3).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppTheme.cardBg,
            elevation: 0,
            title: const Text('Bonjour Lamiae 👋',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.dark)),
            actions: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.orangeBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_rounded, color: AppTheme.orange, size: 18),
                  ),
                  Positioned(
                    top: 4,
                    right: 14,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                height: 48,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Row(
                  children: [
                    StatBadge(
                      number: '1250',
                      label: "Cal aujourd'hui",
                      numColor: AppTheme.orange,
                      bgColor: AppTheme.orangeBg,
                    ),
                    const SizedBox(width: 10),
                    StatBadge(
                      number: '5',
                      label: 'Repas semaine',
                      numColor: AppTheme.green,
                      bgColor: AppTheme.greenBg,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Today's Meals
          SliverToBoxAdapter(
            child: SectionHeader(title: "Repas d'aujourd'hui", actionLabel: 'Voir tout', onAction: () {}),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: todayMeals.length,
                itemBuilder: (context, i) {
                  final r = todayMeals[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: r))),
                    child: Container(
                      width: 130,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 88,
                            decoration: BoxDecoration(
                              color: i.isOdd ? AppTheme.greenBg : AppTheme.orangeBg,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: Center(
                              child: Text(r.emoji, style: const TextStyle(fontSize: 40)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.name,
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.dark),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: i.isOdd ? AppTheme.green : AppTheme.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text('${r.durationMin} min',
                                        style:
                                            const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Suggested Recipes
          SliverToBoxAdapter(
            child: SectionHeader(title: 'Recettes suggérées', actionLabel: 'Voir tout', onAction: () {}),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => RecipeCardHorizontal(
                recipe: suggested[i],
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RecipeDetailScreen(recipe: suggested[i]))),
              ),
              childCount: suggested.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
