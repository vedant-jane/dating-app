# 💖 Flutter Dating App - Clean Architecture & BLoC

A production-quality Flutter dating mobile application built with **Clean Architecture**, **BLoC** state management, and real-time integration with the [randomuser.me](https://randomuser.me/api/?results=20) API.

---

## 📱 Features Overview

### 1. Discovery & Swipable Cards (Home)
- **Dynamic API Integration**: Fetches profiles in real-time from `https://randomuser.me/api/?results=20` (Name, Age, DOB, Profile Photos, Location, Online Status).
- **Interactive Gestures & Physics**:
  - Smooth card swiping with rotation physics.
  - **LIKE** angled green stamp on right swipe.
  - **NOPE** angled red stamp on left swipe.
  - **Undo / Rewind** button to bring back previously swiped profiles.
- **Card UI & Badges**:
  - Match stats: `• 74% Match`, `🛡️ 98% Trust`, `⚡ ~5m Reply`.
  - Online active indicator (green pulsating dot).
  - Verified user badge.
  - Distance, occupation, and relationship goals.
  - Floating 🌹 Rose badge action button with glow effect.
- **State Handling**:
  - Full **Loading State** with skeleton loader.
  - **Error State** with retry button.
  - **Pull to Refresh** (`RefreshIndicator`) for dynamic API reload.
  - **All Caught Up** state when cards are exhausted.

### 2. Comprehensive Profile Details (Scrollable)
- Top stats: `92% Match`, `98% Trust`, `~5m Replies`.
- **About**: Bio card with quick-compliment 🌹 Rose button.
- **The Basics**: Age & DOB, Height, Location, Love language, Religion, Orientation, Zodiac traits, Mother tongue, Communication style.
- **Video Intro**: Video preview player card with duration badge (`0:28`).
- **Prompts**: Stylized question cards (e.g., *"The way to win me over is..."*, *"My simple pleasures..."*, *"We'll get along if..."*).
- **Career & Ambition**: Education, Work status, Work style, Ambition level.
- **Her Big Dream**: Sustainable fashion story card.
- **Photo Gallery**: High-res secondary and tertiary lifestyle photos.
- **Interests & Hobbies**: Pill tag collection (Travel, Coffee, Trekking, Books, Yoga, Indie music, Cooking, Photography).
- **Lifestyle**: Diet, Drinking, Smoking, Fitness, Travel, Pets, Sleep.
- **Dating Goal**: High-contrast romantic gradient card (*"Long-term, marriage-open"*).

### 3. Compliment Bottom Sheet Modal
- Header showing target section (*"Prompt"*, *"About"*).
- Engagement stats: `💬 3 comments`, `🌹 2 roses`, `🪙 5,258 balance`.
- Text field with `0/140` character count.
- **"💡 Try"** quick-action button opening the Compliment Ideas screen.
- Gift selector: `🌹 Rose` and `🎁 Select Gift`.
- Outlined `Like` button + Gradient `Send Compliment` button.
- Sending triggers immediate toast feedback and auto-navigates into direct chat.

### 4. Compliment Ideas Screen
- Categories: **Sweet**, **Playful**, **Admiring**, **Flirty**, **Funny**.
- Selectable cards with dynamic pink border and checkmark circle.
- Sticky bottom **"Use this compliment"** button that populates back to the sheet.

### 5. Chat / Direct Message Conversation Screen
- Top Bar: Avatar, Online status, **PLATINUM** user badge, voice/video call icons.
- **Relationship Progress**: Level 5 header with milestone status.
- Quick tabs: `🎁 Gifts 12`, `💬 Compliments`, `📅 Date Invites`.
- **Meeting Venue Card**: Live venue card (`📍 Blue Tokai`), *"Add to calendar"*, and *"Get directions"*.
- Chat bubbles: Sent compliment reaction bubble, `🌹 Rose • 10 coins • SENT` gift bubble, and interactive real-time text messaging with automated reply simulation.

### 6. Messages / Inbox Screen (Chat Tab)
- Search bar: *"Search matches or messages"*.
- **New Matches**: Horizontal avatar carousel with gradient story rings and unread counters.
- Filter chips: `All`, `Unread`, `Online`, `Nearby`, `Date Invites`.
- Conversation list: Displays match percentage, typing status, unread counters, gift indicators, and milestone progression (`"16/25 for Premium Rose"`).

### 7. Notifications Screen
- Filter chips: `All 55`, `Likes & roses`, `Matches`, `Gifts`, `Date Requests`.
- Today's notifications feed:
  - Dev sent you a Rose (`"View profile"`).
  - Arjun complimented your About (`"View profile"`).
  - Match with Aanya (`"Send a message"`).
  - Elena sent a message (`"Open chat"`).
  - Kabir approved your date request (`"Open chat"`).

### 8. Date Now Screen
- Day filters: `Today`, `Tomorrow`, `Weekend`.
- Live event cards: `• Live - Olive Bar, Mahalaxmi` (3.4 km away), `Pasta & Honest Chats`, tags for dinner, time, match percentage, and cost sharing (`"I'll pay"`).
- User footer with avatar, pronouns, and profile link.
- Action buttons: `Skip` and `Request Date`.

---

## 🏛️ Architecture & Folder Structure

Built following practical **Clean Architecture** principles and **BLoC (Business Logic Component)**:

```
lib/
├── core/
│   ├── constants/
│   │   ├── api_constants.dart          # API endpoints
│   │   └── app_colors.dart             # App color palette & gradients
│   └── theme/
│       └── app_theme.dart              # Plus Jakarta Sans text theme & UI tokens
├── data/
│   ├── datasources/
│   │   └── user_remote_datasource.dart # HTTP client & RandomUser API integration
│   ├── models/
│   │   └── user_model.dart             # JSON serialization & profile mapper
│   └── repositories/
│       └── user_repository_impl.dart  # Data repository implementation
├── domain/
│   ├── entities/
│   │   └── user_profile.dart           # User and Prompt entities
│   └── repositories/
│       └── user_repository.dart       # Abstract repository interface
├── presentation/
│   ├── bloc/
│   │   ├── home_bloc.dart              # Card stack logic, undo, swiping
│   │   ├── home_event.dart             # BLoC events
│   │   └── home_state.dart             # Loading, loaded, error states
│   ├── pages/
│   │   ├── main_navigation_page.dart   # Bottom navigation scaffold
│   │   ├── home/
│   │   │   ├── home_screen.dart        # Discovery screen & card coordinator
│   │   │   ├── compliment_ideas_page.dart # Curated pickup lines & compliments (Try)
│   │   │   └── widgets/
│   │   │       └── profile_detail_content.dart # Modular profile details view
│   │   ├── chat/
│   │   │   ├── messages_screen.dart    # Inbox & match stories
│   │   │   └── chat_conversation_page.dart # 1-on-1 chat with venue & gift cards
│   │   ├── date_now/
│   │   │   └── date_now_screen.dart    # Date Now live venue cards
│   │   └── notifications/
│   │       └── notifications_screen.dart # Notification updates list
│   └── widgets/
│       ├── custom_bottom_nav_bar.dart  # Custom 5-tab bottom navigation bar
│       ├── swipable_hero_card.dart     # Swipable card with gesture physics
│       ├── like_nope_stamps.dart       # LIKE and NOPE stamp overlays
│       └── compliment_sheet.dart       # Compliment bottom sheet modal
└── main.dart                           # App entry point & dependency wiring
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.11.4` / `3.41.6`
- Dart SDK `^3.11.4`

### Installation & Run
```bash
# 1. Clone repository
git clone <repo-url>
cd dating_app

# 2. Install dependencies
flutter pub get

# 3. Run unit & widget tests
flutter test

# 4. Run application
flutter run

# 5. Build APK
flutter build apk --release
```
The generated APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`
