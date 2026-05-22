import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color background = Color(0xFFF8FAFC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF0F172A);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E42);
  static const Color border = Color(0xFFE5E7EB);
  static const Color text = Color(0xFF1E293B);
  static const Color subtitle = Color(0xFF64748B);
  static const Color disabled = Color(0xFFCBD5E1);

  // Dashboard card palettes
  static const Color dashboardBlueCard = Color(0xFFE6F1FB);
  static const Color dashboardBlueIcon = Color(0xFFB5D4F4);
  static const Color dashboardBlueContent = Color(0xFF0C447C);
  static const Color dashboardGreenCard = Color(0xFFEAF3DE);
  static const Color dashboardGreenIcon = Color(0xFFC0DD97);
  static const Color dashboardGreenContent = Color(0xFF27500A);
  static const Color dashboardAmberCard = Color(0xFFFAEEDA);
  static const Color dashboardAmberIcon = Color(0xFFFAC775);
  static const Color dashboardAmberContent = Color(0xFF633806);
  static const Color dashboardPurpleCard = Color(0xFFEEEDFE);
  static const Color dashboardPurpleIcon = Color(0xFFCECBF6);
  static const Color dashboardPurpleContent = Color(0xFF3C3489);

  // Company avatar palettes
  static const Color companyAvatar1Bg = Color(0xFFE6F1FB);
  static const Color companyAvatar1Text = Color(0xFF0C447C);
  static const Color companyAvatar2Bg = Color(0xFFEEEDFE);
  static const Color companyAvatar2Text = Color(0xFF3C3489);
  static const Color companyAvatar3Bg = Color(0xFFEAF3DE);
  static const Color companyAvatar3Text = Color(0xFF27500A);
  static const Color companyAvatar4Bg = Color(0xFFFAEEDA);
  static const Color companyAvatar4Text = Color(0xFF633806);
  static const Color companyAvatar5Bg = Color(0xFFFBEAF0);
  static const Color companyAvatar5Text = Color(0xFF72243E);

  // Company status badge palettes
  static const Color companyStatusActiveBg = Color(0xFFEAF3DE);
  static const Color companyStatusActiveText = Color(0xFF27500A);
  static const Color companyStatusPendingBg = Color(0xFFFAEEDA);
  static const Color companyStatusPendingText = Color(0xFF633806);
  static const Color companyStatusInactiveBg = Color(0xFFF1EFE8);
  static const Color companyStatusInactiveText = Color(0xFF5F5E5A);
  static const Color companyStatusDefaultBg = Color(0xFFEEEDFE);
  static const Color companyStatusDefaultText = Color(0xFF3C3489);

  // Custom UI colors
  static const Color screenBackground = Color(0xFFF5F6FA);
  static const Color darkNavy = Color(0xFF1A1A2E);
  static const Color labelMuted = Color(0xFFB0B1C1);
  static const Color emptyStateIcon = Color(0xFF534AB7);
  static const Color emptyStateBg = Color(0xFFEEEDFE);
  static const Color addressIconBg = Color(0xFFFFF3E0);

  // Company avatar palettes
  static const List<StatusColor> avatarPalettes = [
    StatusColor(companyAvatar1Bg, companyAvatar1Text),
    StatusColor(companyAvatar2Bg, companyAvatar2Text),
    StatusColor(companyAvatar3Bg, companyAvatar3Text),
    StatusColor(companyAvatar4Bg, companyAvatar4Text),
    StatusColor(companyAvatar5Bg, companyAvatar5Text),
  ];

  static StatusColor avatarColorFor(String name) {
    final index = name.isNotEmpty ? name.codeUnitAt(0) % avatarPalettes.length : 0;
    return avatarPalettes[index];
  }

  static StatusColor statusColorFor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const StatusColor(companyStatusActiveBg, companyStatusActiveText);
      case 'pending':
        return const StatusColor(companyStatusPendingBg, companyStatusPendingText);
      case 'inactive':
        return const StatusColor(companyStatusInactiveBg, companyStatusInactiveText);
      default:
        return const StatusColor(companyStatusDefaultBg, companyStatusDefaultText);
    }
  }
}

class StatusColor {
  final Color bg;
  final Color text;
  const StatusColor(this.bg, this.text);
}

