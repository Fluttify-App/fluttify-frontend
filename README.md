# Fluttify
## Collaborative Spotify Playlists Reimagined
<p align="center">
  <img width=250 src="https://user-images.githubusercontent.com/43783342/125453734-8b3d4b49-2268-4dfc-bbec-386ee496cf4a.png">
</p>

Fluttify is a modern Flutter application that enhances the Spotify experience by adding powerful social and automation features. It enables users to create dynamic, auto-updating playlists that automatically collect and blend favorite music from all contributors - creating a unique shared music experience where friends can discover and enjoy each other's musical tastes through continuously evolving playlists.

## ✨ Key Features

### 🎵 Smart Playlist Management
- **Auto-Refreshing Playlists**: Playlists automatically update every day to include contributors' favorite tracks
- **Time-Based Selection**: Configure how many tracks to include from different time ranges:
  - Short-term favorites (last 4 weeks)
  - Medium-term favorites (last 6 months)
  - Long-term favorites (all time)
- **Genre Filtering**: Maintain playlist themes by specifying desired music genres

### 👥 Social Features
- **Collaborative Creation**: Share playlists with friends and let them join as contributors
- **Community Discovery**: Explore and engage with playlists from the broader Fluttify community
- **Social Interaction**: Like and share playlists with other users

### 🎨 User Experience
- **Dark/Light Themes**: Full support for both dark and light modes
- **Localization**: Available in English and German
- **Dynamic Sharing**: Easy playlist sharing through dynamic deep links

## 🛠 Technical Implementation

### Frontend (This Repository)
- **Framework**: Built with Flutter for cross-platform support
- **State Management**: Uses Provider pattern for efficient state handling
- **Navigation**: Implements Stacked framework for routing and view management
- **Design Patterns**:
  - MVVM architecture for clean separation of concerns
  - Service-based dependency injection
  - Reactive programming patterns

### Backend Integration
- **API**: RESTful API integration with Node.js backend
- **Authentication**: Secure Spotify OAuth implementation
- **Real-time Updates**: Automated playlist synchronization service
- **Backend Repository**: [Fluttify Backend](https://github.com/Fluttify-App/fluttify-backend)

### External APIs
- [Spotify Web API](https://developer.spotify.com/) for music integration
- Dynamic linking for seamless playlist sharing

## 🚀 Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Configure your Spotify Developer credentials
4. Run the app:
   ```bash
   flutter run
   ```

## 📱 Screenshots

[Coming soon]

## 👨‍💻 Development Team
- [Sascha Villing](https://gitlab.in.htwg-konstanz.de/sa981vil)
- [Sascha Ivan](https://gitlab.in.htwg-konstanz.de/sa391iva)

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
