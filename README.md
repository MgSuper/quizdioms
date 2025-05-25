# 📘 Quizdioms - Flutter Learning App

Quizdioms is a mobile application built with Flutter that allows users to:

- Practice quizzes
- Learn idioms and phrases
- Track their learning performance

## 🔧 Tech Stack

- Flutter
- Firebase Auth & Firestore
- Riverpod & Hooks
- GoRouter
- Freezed & JSON Serializable
- FlipCard UI
- Clean Architecture

## 📦 Features

### ✅ Admin Panel

- Add/edit/delete quizzes
- Add idiom groups (3 idioms per group)
- Add quotes and phrases (coming soon)

### ✅ User Panel

- Take quizzes with scores
- Swipe through idioms in flip-card UI
- Track learned idioms (stored in Firestore)
- Bottom navigation for idioms, phrases, performance, and profile

## 📂 Project Structure

```bash
lib/
├── presentation/
│   ├── admin/
│   ├── user/
│   ├── routes/
│   ├── widgets/
├── data/
├── domain/
├── services/
├── main.dart
```
