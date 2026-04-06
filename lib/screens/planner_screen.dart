import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  int _selectedWeekTab = 0;
  final List<String> _weekTabs = ['Cette semaine', 'Semaine proch.', 'Perso'];
  late List<MealPlan> _plan;

  @override
  void initState() {
    super.initState();
    _plan = List.from(AppData.weekPlan);
  }

  void _showAddMealDialog(int dayIndex) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Ajouter repas — ${_plan[dayIndex].day}',
            style: const TextStyle(fontWeight: FontWeight.w800)),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Ex: Salade, Pasta...'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.green),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _plan[dayIndex] = _plan[dayIndex].copyWith(lunch: controller.text);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('📅 Meal Planner'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(Icons.ios_share_rounded, color: AppTheme.green),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _weekTabs.length,
              itemBuilder: (context, i) {
                final selected = i == _selectedWeekTab;
                return GestureDetector(
                  onTap: () => setState(() => _selectedWeekTab = i),
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
                      _weekTabs[i],
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
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: _plan.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppTheme.border),
              itemBuilder: (context, i) {
                final plan = _plan[i];
                final hasAnyMeal =
                    plan.breakfast != null || plan.lunch != null || plan.dinner != null;

                return Container(
                  color: AppTheme.cardBg,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: Text(
                          plan.day,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textMuted),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (plan.breakfast != null)
                              Text(plan.breakfast!,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.dark)),
                            if (plan.lunch != null)
                              Text(plan.lunch!,
                                  style: TextStyle(
                                      fontSize: plan.breakfast != null ? 11 : 13,
                                      fontWeight: plan.breakfast != null
                                          ? FontWeight.w400
                                          : FontWeight.w700,
                                      color: plan.breakfast != null
                                          ? AppTheme.textMuted
                                          : AppTheme.dark)),
                            if (plan.dinner != null)
                              Text(plan.dinner!,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: AppTheme.textMuted)),
                            if (!hasAnyMeal)
                              const Text('— Non planifié',
                                  style: TextStyle(
                                      fontSize: 13, color: AppTheme.textMuted)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (hasAnyMeal)
                        _PillButton(
                          label: 'Envoyer',
                          color: AppTheme.orange,
                          bg: AppTheme.orangeBg,
                          onTap: () {},
                        )
                      else
                        _PillButton(
                          label: '+ Ajouter',
                          color: AppTheme.green,
                          bg: AppTheme.greenBg,
                          onTap: () => _showAddMealDialog(i),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Summary strip
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppTheme.cardBg,
              border: Border(top: BorderSide(color: AppTheme.border)),
            ),
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
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;
  final VoidCallback onTap;
  const _PillButton(
      {required this.label,
      required this.color,
      required this.bg,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
      ),
    );
  }
}
