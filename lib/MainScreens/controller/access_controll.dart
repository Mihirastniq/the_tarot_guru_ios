import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessControl {
  late SharedPreferences _prefs;

  AccessControl() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> isAccessAllowed(String tarotType) async {
    bool accessAllowed = false;
    String? createdAt = _prefs.getString('created_at');

    bool freeByAdmin = _prefs.getInt('free_by_admin') == 1;
    int? warning = _prefs.getInt('warning');

    bool oshoZenAllowed = _prefs.getInt('osho_zen_subscription') == 1;
    bool riderWaiteAllowed = _prefs.getInt('rider_waite_subscription') == 1;

    if (createdAt != null) {
      DateTime registrationDate = DateTime.parse(createdAt);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(registrationDate);

      if (tarotType == 'osho' && oshoZenAllowed) {
        if (freeByAdmin) {
          if (warning == 1) {
            return false; // Access granted, but show warning popup
          } else {
            return true; // Access granted
          }
        } else {
          return true; // Access granted
        }
      } else if (tarotType == 'rider' && riderWaiteAllowed) {
        if (freeByAdmin) {
          if (warning == 1) {
            return false; // Access granted, but show warning popup
          } else {
            return true; // Access granted
          }
        } else {
          return true; // Access granted
        }
      } else if (difference.inHours <= 48) {
        return false; // Limited access, but show popup
      }
    }
    return accessAllowed;
  }

  Future<bool> isAccessBlockedByAdminWithWarning() async {
    bool freeByAdmin = _prefs.getInt('free_by_admin') == 1;
    int? warning = _prefs.getInt('warning');

    return freeByAdmin && warning == 1;
  }

  Future<bool> isInTrialPeriod() async {
    String? createdAt = _prefs.getString('created_at');
    if (createdAt != null) {
      DateTime registrationDate = DateTime.parse(createdAt);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(registrationDate);
      return difference.inHours <= 48;
    }
    return false;
  }
}