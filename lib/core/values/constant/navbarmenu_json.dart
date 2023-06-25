import '../../../app/data/models/navbar_menu.dart';

List navbarmenu = [
  {
    "id": 1,
    "name": "Home",
    "active_icon": "assets/images/home_active_icon.svg",
    "inactive_icon": "assets/images/home_icon.svg",
    "path": "/home",
  },
  {
    "id": 2,
    "name": "Search",
    "active_icon": "assets/images/search_active_icon.svg",
    "inactive_icon": "assets/images/search_icon.svg",
    "path": "/search"
  },
  {
    "id": 3,
    "name": "Upload",
    "active_icon": "assets/images/upload_active_icon.svg",
    "inactive_icon": "assets/images/upload_icon.svg",
    "path": "/upload"
  },
  {
    "id": 4,
    "name": "Activity",
    "active_icon": "assets/images/love_active_icon.svg",
    "inactive_icon": "assets/images/love_icon.svg",
    "path": "/activity"
  },
  {
    "id": 5,
    "name": "Account",
    "active_icon": "assets/images/account_active_icon.svg",
    "inactive_icon": "assets/images/account_icon.svg",
    "path": "/account"
  }
];

List<NavbarMenu> navbarMenuList =
    navbarmenu.map((e) => NavbarMenu.fromJson(e)).toList();
