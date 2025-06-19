# 🌱 Wellness Nutrition App

Application mobile Flutter de suivi nutritionnel révolutionnaire basée sur une approche psychologique bienveillante et déculpabilisante.

![Flutter](https://img.shields.io/badge/Flutter-3.16.0-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.1.0-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## 🎯 Philosophie

Cette application rompt avec le tracking traditionnel anxiogène pour proposer une approche révolutionnaire du bien-être nutritionnel :

- **🚫 Anti-tracking traditionnel** : Pas de comptage calorique obligatoire ni d'objectifs de perte de poids imposés
- **🧘 Alimentation intuitive** : Privilégier l'écoute des signaux corporels sur les métriques externes
- **📚 Éducation progressive** : Apprendre plutôt que surveiller, comprendre plutôt que contrôler
- **💚 Bienveillance systémique** : Chaque interaction encourage sans culpabiliser
- **🌍 Respect de la diversité** : Inclusion culturelle et corporelle dans tous les aspects

## ✨ Fonctionnalités Principales

### 📱 Scanner Bienveillant
- Interface de scan de codes-barres douce et encourageante
- Feedback positif avec chaque découverte
- Intégration OpenFoodFacts pour les données nutritionnelles
- Animations apaisantes et micro-interactions

### 📖 Journal Alimentaire Intuitif
- Suivi des repas sans obsession des chiffres
- Check-in émotionnel intégré
- Insights bienveillants sur la diversité alimentaire
- Timeline mindful des repas

### 🧘‍♀️ Mindfulness Intégré
- Sessions de méditation alimentaire guidée
- Exercices de pleine conscience avant/pendant/après les repas
- Exploration sensorielle des aliments
- Pratiques de gratitude alimentaire

### 💚 Dashboard Bien-être
- Métriques anti-toxiques focalisées sur le bien-être
- Suivi de la diversité alimentaire (couleurs, origines)
- Achievements bienveillants non-compétitifs
- Messages d'encouragement personnalisés

### 🌟 Page Découverte
- Recommandations contextuelles douces
- Tips nutritionnels éducatifs
- Actions rapides pour une utilisation fluide
- Insights quotidiens inspirants

## 🏗️ Architecture Technique

L'application suit une **Clean Architecture** pour maintenir la séparation des responsabilités :

```
lib/
├── core/                    # Configuration commune
│   ├── constants/          # Constantes et couleurs wellness
│   ├── themes/            # Thème bienveillant
│   └── error/             # Gestion d'erreurs douce
├── features/              # Fonctionnalités par domaine
│   ├── home/             # Navigation principale
│   ├── discover/         # Page d'accueil
│   ├── scanner/          # Scanner de codes-barres
│   ├── journal/          # Journal alimentaire
│   ├── wellness/         # Dashboard bien-être
│   └── nutrition/        # Gestion des données alimentaires
├── shared/               # Composants réutilisables
│   └── widgets/         # Widgets wellness personnalisés
└── main.dart           # Point d'entrée
```

### 🛠️ Stack Technique

- **🎯 State Management** : Riverpod pour une gestion d'état réactive
- **💾 Stockage Local** : Hive pour le cache offline-first
- **🌐 Networking** : Dio avec gestion intelligente des erreurs
- **📱 Scanner** : Mobile Scanner optimisé pour performance
- **🍎 API Nutritionnelle** : OpenFoodFacts pour données ouvertes
- **🎨 UI/UX** : Design system bienveillant avec animations Flutter
- **🔒 Sécurité** : Flutter Secure Storage pour données sensibles

## 🚀 Installation et Setup

### Prérequis
- Flutter SDK 3.16.0+
- Dart 3.1.0+
- Android Studio / VS Code
- Émulateur Android ou appareil physique

### 1. Cloner le repository
```bash
git clone https://github.com/creach-t/wellness-nutrition-app.git
cd wellness-nutrition-app
```

### 2. Installer les dépendances
```bash
flutter pub get
```

### 3. Générer les fichiers de code
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 4. Lancer l'application
```bash
# Mode debug
flutter run

# Mode release
flutter run --release
```

## 🎨 Design System Bienveillant

### Palette de Couleurs Thérapeutiques
- **🔵 Bleu Apaisant** (`#4A90E2`) - Couleur primaire pour la sérénité
- **🟢 Vert Nature** (`#68B684`) - Couleur secondaire pour la croissance
- **🤍 Accents Doux** (`#E8F4FD`) - Tons apaisants pour les backgrounds
- **⚫ Texte Doux** (`#2C3E50`) - Contraste optimal sans agressivité

### Typography Accessible
- Police Poppins pour la lisibilité
- Taille minimum 16px sur mobile
- Contraste 4.5:1 respecté partout
- Hauteur de ligne optimisée pour le confort

### Animations Bienveillantes
- Transitions douces (300ms)
- Effet "heartbeat" pour boutons principaux
- Feedback haptique léger
- Particules dorées pour les réussites

## 📊 Métriques Wellness (Anti-Toxiques)

### ✅ Ce que nous mesurons
- **🌈 Diversité alimentaire** : Couleurs, origines, familles d'aliments
- **🧘 Moments mindful** : Qualité de présence pendant les repas
- **💚 Bien-être général** : Ressenti subjectif de l'utilisateur
- **🌱 Progression douce** : Apprentissages et découvertes

### ❌ Ce que nous évitons absolument
- ❌ Comptage calorique obsessionnel
- ❌ Objectifs de perte de poids
- ❌ Comparaisons avec autres utilisateurs
- ❌ Streaks rigides créant de la pression
- ❌ Notifications culpabilisantes

## 🧪 Tests et Qualité

### Structure de Tests
```bash
test/
├── unit/              # Tests unitaires
├── widget/            # Tests de widgets
├── integration/       # Tests d'intégration
└── wellness/          # Tests spécifiques bien-être
```

### Lancer les tests
```bash
# Tests unitaires
flutter test

# Tests d'intégration
flutter drive --target=test_driver/app.dart
```

### Métriques de Succès MVP
- **📈 Amélioration bien-être** : +20% à 4 semaines
- **😌 Réduction anxiété alimentaire** : -25%
- **🧘 Pratique mindfulness** : 70% des utilisateurs
- **📱 Rétention 30 jours** : 45% (vs 23% moyenne)
- **💚 Relation positive nourriture** : 80% d'amélioration

## 🌍 Contribution

Nous accueillons les contributions qui respectent notre philosophie bienveillante !

### Principes de Contribution
1. **🤝 Bienveillance first** : Chaque PR doit améliorer le bien-être utilisateur
2. **📚 Éducation > Control** : Favoriser l'apprentissage sur la surveillance
3. **🌈 Inclusivité** : Respecter la diversité culturelle et corporelle
4. **🧘 Mindfulness** : Intégrer des moments de pause et réflexion

### Process
1. Fork le repository
2. Créer une branche (`feature/amazing-wellness-feature`)
3. Commit les changements avec messages explicites
4. Push vers la branche
5. Ouvrir une Pull Request avec description détaillée

## 📱 Screenshots et Démo

### 🏠 Page d'Accueil
- Interface accueillante avec message personnalisé
- Actions rapides pour scanner, ajouter, méditer
- Insights quotidiens inspirants

### 📱 Scanner Bienveillant
- Interface de scan avec guidage doux
- Animations encourageantes
- Feedback positif immédiat

### 📖 Journal Intuitif
- Timeline des repas avec émotions
- Check-in d'humeur intégré
- Suggestions bienveillantes

### 💚 Dashboard Bien-être
- Métriques focalisées sur le positif
- Achievements non-compétitifs
- Messages d'encouragement personnalisés

## 🔮 Roadmap

### Phase 1 : MVP Foundations ✅
- [x] Architecture Clean + Riverpod
- [x] Design system bienveillant
- [x] Scanner de codes-barres
- [x] Journal alimentaire de base
- [x] Dashboard bien-être

### Phase 2 : Mindfulness & IA 🚧
- [ ] Sessions mindfulness complètes
- [ ] Moteur de recommandations IA
- [ ] Système d'éducation progressive
- [ ] Mode offline complet

### Phase 3 : Communauté & Expansion 🔮
- [ ] Partage bienveillant entre utilisateurs
- [ ] Contenu éducatif expert
- [ ] Intégrations wearables wellness
- [ ] Versions iOS et Web

## 📚 Ressources et Inspiration

### Études Scientifiques
- **Tribole & Resch (2020)** : "Intuitive Eating, 4th Edition"
- **Romano et al. (2018)** : Impact négatif du tracking traditionnel
- **HAES® Research (2024)** : 6 essais contrôlés validant l'approche

### APIs et Services
- **OpenFoodFacts** : Base de données nutritionnelle ouverte
- **Flutter Packages** : Écosystème riche pour développement rapide

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🙏 Remerciements

- **🧠 Recherche en psychologie nutritionnelle** pour les fondements scientifiques
- **🌍 Communauté OpenFoodFacts** pour les données ouvertes
- **💙 Équipe Flutter** pour le framework exceptionnel
- **✨ Tous les contributeurs** qui croient en une approche plus humaine

---

## 📞 Contact et Support

- **🐛 Bugs & Issues** : [GitHub Issues](https://github.com/creach-t/wellness-nutrition-app/issues)
- **💡 Suggestions** : [GitHub Discussions](https://github.com/creach-t/wellness-nutrition-app/discussions)
- **📧 Contact Direct** : wellness@nutrition-app.com

---

💚 *Créé avec amour pour une relation plus saine et bienveillante avec la nourriture*

**⭐ N'oubliez pas de star le repository si ce projet vous inspire ! ⭐**
