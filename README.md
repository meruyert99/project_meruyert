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
  runApp(MyApp());
}
