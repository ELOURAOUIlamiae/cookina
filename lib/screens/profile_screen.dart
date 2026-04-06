import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  bool _weeklyReport = false;
  bool _darkMode = false;
  String _diet = 'Omnivore';

  final List<String> _diets = [
    'Omnivore',
    'Végétarien',
    'Végan',
    'Sans gluten',
    'Halal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('👤 Profil')),
      body: ListView(
        children: [
          // Avatar section
          Container(
            color: AppTheme.cardBg,
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: AppTheme.greenBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('👩‍🍳', style: TextStyle(fontSize: 44)),
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppTheme.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.edit_rounded,
                          color: Colors.white, size: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text('Lamiae',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.dark)),
                const SizedBox(height: 4),
                const Text('lamiae@email.com',
                    style:
                        TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StatChip(label: '24', sub: 'Recettes'),
                    const SizedBox(width: 16),
                    _StatChip(label: '7', sub: 'Semaines'),
                    const SizedBox(width: 16),
                    _StatChip(label: '1250', sub: 'Cal/jour'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Preferences
          _SectionTitle('Préférences alimentaires'),
          Container(
            color: AppTheme.cardBg,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Régime alimentaire',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textMuted)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _diets
                      .map((d) => GestureDetector(
                            onTap: () => setState(() => _diet = d),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: _diet == d
                                    ? AppTheme.green
                                    : AppTheme.greenBg,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _diet == d
                                      ? AppTheme.green
                                      : AppTheme.border,
                                ),
                              ),
                              child: Text(
                                d,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _diet == d
                                      ? Colors.white
                                      : AppTheme.green,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Notifications
          _SectionTitle('Notifications'),
          _SettingsTile(
            icon: Icons.notifications_rounded,
            iconColor: AppTheme.orange,
            iconBg: AppTheme.orangeBg,
            title: 'Rappels de préparation',
            subtitle: 'Notifier avant chaque repas',
            trailing: Switch(
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
              activeColor: AppTheme.green,
            ),
          ),
          _SettingsTile(
            icon: Icons.bar_chart_rounded,
            iconColor: AppTheme.green,
            iconBg: AppTheme.greenBg,
            title: 'Rapport hebdomadaire',
            subtitle: 'Résumé nutrition chaque lundi',
            trailing: Switch(
              value: _weeklyReport,
              onChanged: (v) => setState(() => _weeklyReport = v),
              activeColor: AppTheme.green,
            ),
          ),

          const SizedBox(height: 12),

          // App settings
          _SectionTitle('Application'),
          _SettingsTile(
            icon: Icons.dark_mode_rounded,
            iconColor: const Color(0xFF5E35B1),
            iconBg: const Color(0xFFEDE7F6),
            title: 'Mode sombre',
            subtitle: 'Thème foncé',
            trailing: Switch(
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              activeColor: AppTheme.green,
            ),
          ),
          _SettingsTile(
            icon: Icons.share_rounded,
            iconColor: const Color(0xFF1565C0),
            iconBg: const Color(0xFFE3F2FD),
            title: 'Partager l\'application',
            subtitle: 'Inviter des amis',
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textMuted),
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.info_outline_rounded,
            iconColor: AppTheme.textMuted,
            iconBg: const Color(0xFFF1F3F5),
            title: 'À propos',
            subtitle: 'Version 1.0.0',
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textMuted),
            onTap: () {},
          ),

          const SizedBox(height: 12),

          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout_rounded, color: Colors.red),
              label: const Text('Se déconnecter',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700)),
              onPressed: () {},
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Text(title,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppTheme.textMuted,
              letterSpacing: 0.5)),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppTheme.cardBg,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.dark)),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.textMuted)),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String sub;
  const _StatChip({required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.dark)),
        Text(sub,
            style:
                const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
      ],
    );
  }
}
