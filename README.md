# 🍽️ Application de Cuisine & Planification des Repas

Application Flutter complète avec 5 écrans et design fidèle au maquette.

## Structure du projet

```
lib/
├── main.dart                    # Point d'entrée + Navigation principale
├── theme/
│   └── app_theme.dart           # Couleurs, ThemeData
├── models/
│   └── models.dart              # Recipe, MealPlan, ShoppingItem + données
├── widgets/
│   └── widgets.dart             # Widgets réutilisables
└── screens/
    ├── home_screen.dart          # Écran Accueil
    ├── planner_screen.dart       # Meal Planner
    ├── recipes_screen.dart       # Liste recettes + filtres
    ├── recipe_detail_screen.dart # Détail recette
    ├── shopping_screen.dart      # Liste de courses + scanner
    └── suggestion_screen.dart    # Suggestions IA
```

## Fonctionnalités

-  **Navigation** — BottomNavigationBar avec 5 onglets
-  **Accueil** — Greeting, stats calories, repas du jour, recettes suggérées
-  **Meal Planner** — Planning semaine, ajouter/modifier repas
-  **Recettes** — Grid, recherche texte, filtres (Facile/Rapide/Healthy)
-  **Détail recette** — Ingrédients + étapes de préparation + partage
-  **Liste de courses** — Checkbox animées, progress bar, ajout manuel
-  **Scanner code-barres** — UI scanner avec simulation
-  **Suggestions IA** — Interface avec ingrédients disponibles

## Lancer le projet

```bash
flutter pub get
flutter run
```

## Intégrations futures (Room/Firebase/Retrofit)

Pour intégrer les technologies mentionnées dans le brief :

### Room (via sqflite)
```yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
```

### Firebase
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
```

### Retrofit (via dio)
```yaml
dependencies:
  dio: ^5.4.0
  retrofit: ^4.0.3
```

### Scanner code-barres (mobile_scanner)
```yaml
dependencies:
  mobile_scanner: ^3.5.6
```

## Design

- Couleur principale : `#3A8A3F` (Vert)
- Couleur secondaire : `#E8631A` (Orange)
- Font : Nunito (disponible sur Google Fonts)
- Design fidèle au maquette fourni
