# Habit Tracker 📅✨

A Flutter application for tracking daily habits, visualizing progress, and staying consistent. This app uses a **heatmap calendar** inspired by GitHub's commit history to represent daily habit completion visually. 🚀

---

## ✨ Features
- **Add Daily Habits**: Customize and add habits based on your personal needs.
- **Heatmap Calendar**: Track your habit completion progress using a heatmap, where the intensity of the heatmap grows based on the number of completed habits.
- **Monthly Calendar View**: View your progress over an entire month with the built-in monthly calendar provided by the heatmap calendar package.
- **Persistent Storage**: Your progress is saved locally using **Hive Database**, ensuring your data is retained across app sessions.
- **User-Friendly UI**: Simple and intuitive design to make habit tracking effortless.

---

## 📸 Screenshots
<p align="center">
  <img src="https://github.com/user-attachments/assets/7e7ea009-2d21-4bf6-808f-6547d459dad2" width="300">
  <img src="https://github.com/user-attachments/assets/27632848-1910-40d9-bf0f-9ef77400eca8" width="300">
  <img src="https://github.com/user-attachments/assets/760b20c5-9cf7-4831-8a91-c30bbf3b6816" width="300">
  <img src="https://github.com/user-attachments/assets/bac0770e-fd10-454f-a21a-0f50310568dd" width="300">
</p>

---

## 🛠️ Technologies Used
- **Flutter**: The framework used for building this cross-platform application.
- **flutter_heatmap_calendar**: Package for displaying the heatmap calendar.
- **Hive Database**: Lightweight and blazing fast key-value database for Flutter.

---

## 🚀 How It Works
1. **Add a Habit**: Define daily habits you want to track.
2. **Track Progress**: Complete habits daily to earn "heat spots" on the calendar.
3. **Heatmap Visualization**: See your consistency grow as you complete more habits each day.
4. **Persistent Progress**: All data is stored using Hive, so you never lose your progress.

---

## 🏗️ Installation
To run this project on your local machine, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/habit-tracker.git

2. Navigate to the project directory:
   ```bash
   cd habit-tracker
   
3. Install dependencies:
   ```bash
   flutter pub get
   
4. Run the app:
   ```bash
   flutter run

## 📚 Packages Used

1. **flutter_heatmap_calendar** : For the heatmap visualization.
2. **hive** : Local database for storing progress.
3. **hive_flutter** : Hive adapter for Flutter integration.

## 🌟 Future Enhancements

- **Custom Notifications** : Remind users to complete habits.
- **Analytics Dashboard** : Show weekly/monthly habit completion statistics.
- **Theme Support** : Add light and dark themes.
- **Cloud Sync** : Sync progress across devices using cloud storage.

## 🤝 Contributing
Contributions are always welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.
