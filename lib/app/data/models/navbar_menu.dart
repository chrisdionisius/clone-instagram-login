import 'package:flutter/material.dart';

class NavbarMenu {
  int? id;
  String? name;
  String? activeIcon;
  String? inactiveIcon;
  String? path;
  Widget? widget;

  NavbarMenu(
      {this.id, this.name, this.activeIcon, this.inactiveIcon, this.path});

  NavbarMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    activeIcon = json['active_icon'];
    inactiveIcon = json['inactive_icon'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['active_icon'] = activeIcon;
    data['inactive_icon'] = inactiveIcon;
    data['path'] = path;
    return data;
  }
}
