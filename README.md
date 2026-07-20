# SHOP APP - ARCHITECTURE RIVERPOD ET CLEAN DESIGN

Cette application e-commerce Flutter de haute rigueur est construite selon les standards de la Clean Architecture et du pattern MVVM. Elle utilise exclusivement Riverpod pour la gestion des états asynchrones et SharedPreferences pour la persistance locale des données.

## ARCHITECTURE DU PROJET

Le projet est structuré selon une séparation stricte des responsabilités en trois couches :

### 1. COUCHE DOMAINE (Domain Layer)
- **lib/domain/models/** : Définition des modèles métiers immuables (Freezed, json_serializable).
- **lib/domain/wiewmodel/provider/** : Gestionnaires d'état (AsyncNotifier, Notifier) et injection des dépendances Riverpod.

### 2. COUCHE DONNÉES (Data Layer)
- **lib/data/** : Gestion des sources de données locales, de la sérialisation (DTOs) et de l'intégration avec SharedPreferences.

### 3. COUCHE PRÉSENTATION (Presentation Layer)
- **lib/presentation/** : Écrans et widgets de l'application. Les états asynchrones y sont consommés de manière réactive via la méthode `.when` de Riverpod (gestion stricte des états Chargement, Erreur et Données).

## STANDARDS ET SPÉCIFICATIONS TECHNIQUES

- **Gestion d'État** : Utilisation de Riverpod (AsyncNotifier, FutureProvider). Aucun setState global n'est utilisé pour la logique métier.
- **Persistance Locale** : Sauvegarde robuste du panier et des favoris via SharedPreferences.
- **Robustesse** : Intégration de mécanismes de gestion des erreurs et de résilience face aux réseaux instables.

## CHARTE VISUELLE ET DESIGN SYSTEM (STYLE CARRE)

L'interface de l'application applique un style épuré et ultra-technique :
- **Couleur de fond** : Deep Blue-Gray (`#263238`)
- **Couleur de premier plan** : Pure White (`#FFFFFF`)
- **Typographie** : `GoogleFonts.abel` pour un rendu sobre et professionnel.
- **Contrainte géométrique** : Border radius à `0.0` (strictement aucun bord arrondi).

## COMMANDES DE DÉVELOPPEMENT

Installation des dépendances :
```bash
flutter pub get
```

Génération des fichiers de sérialisation et modèles (Freezed) :
```bash
dart run build_runner build --delete-conflicting-outputs
```

Lancement de l'application :
```bash
flutter run
```

Exécution des tests :
```bash
flutter test
```
