import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'recipe_detail_screen.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _filter = 'all';
  String _search = '';
  final _searchCtrl = TextEditingController();

  final List<Map<String, String>> _filters = [
    {'key': 'all', 'label': 'Tout'},
    {'key': 'easy', 'label': 'Facile'},
    {'key': 'quick', 'label': 'Rapide'},
    {'key': 'healthy', 'label': 'Healthy'},
  ];

  List<Recipe> get _filtered {
    return AppData.recipes.where((r) {
      final matchSearch =
          _search.isEmpty || r.name.toLowerCase().contains(_search.toLowerCase());
      final matchFilter = _filter == 'all' ||
          (_filter == 'easy' && r.difficulty == 'easy') ||
          (_filter == 'quick' && r.durationMin <= 20) ||
          (_filter == 'healthy' && r.category == 'healthy');
      return matchSearch && matchFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('🍽️ Recettes')),
      body: Column(
        children: [
          // Search bar
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _search = v),
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                hintText: 'Chercher une recette...',
                hintStyle: TextStyle(fontSize: 13, color: AppTheme.textMuted),
                prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textMuted, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Filter chips
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              itemCount: _filters.length,
              itemBuilder: (context, i) {
                final f = _filters[i];
                final selected = _filter == f['key'];
                return GestureDetector(
                  onTap: () => setState(() => _filter = f['key']!),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.green : AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: selected ? AppTheme.green : AppTheme.border),
                    ),
                    child: Text(
                      f['label']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : AppTheme.textMuted,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Recipe Grid
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text('Aucune recette trouvée',
                        style: TextStyle(color: AppTheme.textMuted)))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (context, i) => RecipeGridCard(
                      recipe: _filtered[i],
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  RecipeDetailScreen(recipe: _filtered[i]))),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
