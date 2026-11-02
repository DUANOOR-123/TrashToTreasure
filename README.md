# Trash 2 Treasure

**Reduce Waste · Reuse · Rebuild.** One app, two roles (buy, sell, or both).
This repo is the complete **front end** (dummy data, no backend yet).

## Run it

```bash
flutter pub get      # downloads the packages (needed once after cloning)
flutter run
```

Packages are not stored in git on purpose (they are big and Flutter rebuilds
them from `pubspec.yaml` / `pubspec.lock`). `pubspec.lock` pins the exact
versions, so everyone gets the same ones.

## App flow

```
Splash -> Welcome -> Sign Up -> Choose Role -> Location -> Submit ID -> Verification
                 \-> Login ------------------------------------------\
                 \-> Continue as Guest (browse only) -----------------+--> Main app
Main app (bottom bar): Home | Map | + | Messages | Profile
   "+"  : sellers -> Seller Home, buyers -> "Enable Selling" sheet
Seller Home -> Add Listing -> Preview -> Publish -> My Listings -> (tap) Edit / Mark as Sold / Delete
Seller Home -> Incoming Requests, Customers, Transaction History, Notifications
Profile -> My Listing, My Request, My Conversations, Saved Items, Notifications, Settings
Settings -> Location Settings, Switch Role, Log Out
```

**Admin Portal:** long-press the *"Trash 2 Treasure"* title on the Welcome screen.
Demo login: `admin@trash2treasure.com` / `admin123`.

**Guests** can browse only: chat, request pickup, save, report, sell, Messages and
Profile ask them to log in. See `AppNav.requireLogin` in `lib/core/app_nav.dart`.

## Folder structure

```
lib/
  main.dart            app start + theme + flow overview
  core/                app_colors, app_theme (mint background), app_session (role / guest), app_nav
  data/                buyer_data, seller_data, shared_data  (all dummy data lives here)
  widgets/             reusable widgets
  screens/
    auth/              splash ... verification result       (onboarding & login)
    buyer/             buyer shell, home, search, map, listing details, chat, requests
    seller/            seller home, add / preview / my listings, incoming requests, customers ...
    shared/            messages, profile, settings, notifications, saved items, report
    admin/             admin login, dashboard, verification queue, ID detail, reports, users
  dev/                 screen_menu.dart: list of every screen (set kShowScreenMenu = true in main.dart)
```

## Connecting the backend later

Look for the `BACKEND LATER` comments. The main places:
`AppSession` (who is logged in), `data/*.dart` (replace dummy lists with real calls),
`LoginScreen._login`, admin login, Publish / Edit / Delete in `SellerStore`.
