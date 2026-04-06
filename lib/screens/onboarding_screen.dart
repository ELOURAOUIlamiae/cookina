import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      emoji: '📅',
      color: Color(0xFF3A8A3F),
      bgColor: Color(0xFFEAF5EA),
      title: 'Planifiez vos repas',
      subtitle:
          'Organisez votre semaine facilement avec notre meal planner intuitif. Gagnez du temps et mangez mieux.',
    ),
    _OnboardingPage(
      emoji: '🍽️',
      color: Color(0xFFE8631A),
      bgColor: Color(0xFFFEF0E6),
      title: 'Des recettes pour tous',
      subtitle:
          'Découvrez des centaines de recettes filtrées par difficulté, temps et préférences alimentaires.',
    ),
    _OnboardingPage(
      emoji: '🛒',
      color: Color(0xFF1565C0),
      bgColor: Color(0xFFE3F2FD),
      title: 'Liste de courses auto',
      subtitle:
          'Générez automatiquement votre liste de courses. Scannez les codes-barres pour ajouter des produits.',
    ),
    _OnboardingPage(
      emoji: '✨',
      color: Color(0xFF6A1B9A),
      bgColor: Color(0xFFF3E5F5),
      title: 'Suggestions intelligentes',
      subtitle:
          "L'IA analyse vos ingrédients disponibles et vous suggère les meilleures recettes à préparer.",
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      _goToApp();
    }
  }

  void _goToApp() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MainNavigation(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToApp,
                child: const Text('Passer',
                    style: TextStyle(
                        color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (context, i) {
                  final page = _pages[i];
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      double value = 1.0;
                      if (_controller.position.haveDimensions) {
                        value = _controller.page! - i;
                        value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                      }
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: page.bgColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(page.emoji,
                                  style: const TextStyle(fontSize: 64)),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            page.title,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: page.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.subtitle,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppTheme.textMuted,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Dots + Button
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: Column(
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == _currentPage ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _currentPage
                              ? _pages[_currentPage].color
                              : AppTheme.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Next / Get Started button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pages[_currentPage].color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      onPressed: _next,
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Commencer 🚀'
                            : 'Suivant →',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String emoji;
  final Color color;
  final Color bgColor;
  final String title;
  final String subtitle;
  const _OnboardingPage({
    required this.emoji,
    required this.color,
    required this.bgColor,
    required this.title,
    required this.subtitle,
  });
}
