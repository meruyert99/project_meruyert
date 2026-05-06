<div align="center">

# 📊 Student Activity Monitoring System

### 🚀 Flutter + Hive + BLoC + Data Visualization

Система мониторинга активности учеников с аналитикой и графиками

---

<img src="https://img.shields.io/badge/Flutter-3.0-blue?style=for-the-badge&logo=flutter"/>
<img src="https://img.shields.io/badge/Hive-Database-orange?style=for-the-badge"/>
<img src="https://img.shields.io/badge/BLoC-State%20Management-purple?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Status-Completed-green?style=for-the-badge"/>

</div>

---

## ✨ О проекте

Это система для мониторинга активности учеников, позволяющая:

- 👤 Добавлять и удалять учеников
- ⚡ Отслеживать активность в реальном времени
- 📈 Визуализировать данные через графики
- 💾 Хранить данные локально (Hive)

  ## 🚀 Установка и запуск

### 1️⃣ Клонировать проект
git clone https://github.com/your-username/your-repo.git
2️⃣ Перейти в проект
cd my_new_app
3️⃣ Установить зависимости
flutter pub get
4️⃣ Запустить приложение
flutter run
⚙️ Инициализация Hive

Перед запуском убедись, что Hive инициализирован:

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('classesBox');



  ⚙️ Технологии
Flutter
Dart
Firebase Auth
Hive (local database)
BLoC (flutter_bloc)
GoRouter
Provider (theme management)
📂 Архитектура проекта
lib/
 ├ core/                 # theme, utils
 ├ domain/
 │   └ repositories/    # логика данных
 ├ presentation/
 │   ├ bloc/           # Cubit / BLoC
 │   └ screens/        # UI экраны
 ├ app_router.dart     # навигация
 └ main.dart           # entry point
🚀 Возможности
🔐 Авторизация
Login через Firebase
Сохранение состояния входа
🏫 Классы
Добавление классов
Просмотр списка классов
👨‍🎓 Студенты
Добавление студентов
Удаление студентов
Увеличение активности
Хранение данных в Hive
📊 Аналитика
Отображение активности студентов
▶️ Как запустить проект
1. Установить зависимости
flutter pub get
2. Запустить приложение
flutter run
🔥 Firebase настройка (обязательно)

Перед запуском:

Добавь Firebase проект
Подключи:
google-services.json (Android)
GoogleService-Info.plist (iOS)
Включи Firebase Auth
💾 Hive настройка

Локальная база данных автоматически инициализируется:

await Hive.initFlutter();
await Hive.openBox('studentsBox');



🧩 Основные экраны
/login — экран входа
/home — главный дашборд
/classes — список классов
/students/:id — студенты класса
/charts — аналитика
👨‍💻 Автор

Проект разработан в рамках обучения Flutter + Firebase + Clean Architecture.

📌 Примечание

Этот проект демонстрирует:

работу с state management (BLoC)
локальную БД (Hive)
навигацию (GoRouter)
  runApp(MyApp());
}
