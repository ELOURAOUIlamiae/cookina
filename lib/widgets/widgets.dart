import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

// ── Difficulty Tag ──────────────────────────────────────────────
class DifficultyTag extends StatelessWidget {
  final String difficulty;
  const DifficultyTag(this.difficulty, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;
    String label;
    switch (difficulty) {
      case 'easy':
        bg = const Color(0xFFE6F4EA);
        text = const Color(0xFF2E7D32);
        label = 'Facile';
        break;
      case 'medium':
        bg = const Color(0xFFFFF8E1);
        text = const Color(0xFFE65100);
        label = 'Moyen';
        break;
      default:
        bg = const Color(0xFFFFEBEE);
        text = const Color(0xFFC62828);
        label = 'Difficile';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: text)),
    );
  }
}

// ── Category Tag ─────────────────────────────────────────────────
class CategoryTag extends StatelessWidget {
  final String label;
  final Color bg;
  final Color text;
  const CategoryTag({super.key, required this.label, required this.bg, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: text)),
    );
  }
}

// ── Recipe Card (horizontal) ─────────────────────────────────────
class RecipeCardHorizontal extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  const RecipeCardHorizontal({super.key, required this.recipe, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.border),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppTheme.orangeBg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
              child: Center(child: Text(recipe.emoji, style: const TextStyle(fontSize: 30))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppTheme.dark)),
                  const SizedBox(height: 2),
                  Text('${recipe.durationMin} min · ${recipe.calories} cal',
                      style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                  const SizedBox(height: 4),
                  DifficultyTag(recipe.difficulty),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

// ── Recipe Grid Card ─────────────────────────────────────────────
class RecipeGridCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  const RecipeGridCard({super.key, required this.recipe, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.greenBg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Center(child: Text(recipe.emoji, style: const TextStyle(fontSize: 42))),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.dark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text('${recipe.durationMin} min',
                      style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
                  const SizedBox(height: 4),
                  DifficultyTag(recipe.difficulty),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Header ───────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.dark)),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(actionLabel!,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.green)),
            ),
        ],
      ),
    );
  }
}

// ── Stat Badge ───────────────────────────────────────────────────
class StatBadge extends StatelessWidget {
  final String number;
  final String label;
  final Color numColor;
  final Color bgColor;
  const StatBadge({
    super.key,
    required this.number,
    required this.label,
    required this.numColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(number,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: numColor)),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
        ],
      ),
    );
  }
}
