import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension BoolExtension on DateTime? {
  String get toStringDateFormat {
    if (this == null) return '-';
    return DateFormat('dd/MM/yyyy').format(this!);
  }

  String get toStringLocalDateFormat {
    final localDate = this?.toLocal();
    if (localDate == null) return '-';
    return DateFormat('dd/MM/yyyy').format(localDate);
  }

  String getMonthName(BuildContext context) {
    final langCode = context.locale.languageCode;
    if (this == null) return '-';
    final a = DateFormat('MMMM', langCode).format(this!);
    return a.tr();
  }

  String getMonthNameLocalDate(BuildContext context) {
    final langCode = context.locale.languageCode;
    final localDate = this?.toLocal();
    if (localDate == null) return '-';
    final a = DateFormat('MMMM', langCode).format(localDate);
    return a.tr();
  }

  String getDayName(BuildContext context) {
    final langCode = context.locale.languageCode;
    if (this == null) return '-';
    final a = DateFormat('EEEE', langCode).format(this!);
    return a.tr();
  }

  String getDayNamLocalTime(BuildContext context) {
    final langCode = context.locale.languageCode;
    final localDate = this?.toLocal();
    if (localDate == null) return '-';
    final a = DateFormat('EEEE', langCode).format(localDate);
    return a.tr();
  }

  String getDateString(BuildContext context) {
    final langCode = context.locale.languageCode;
    if (this == null) return '-';
    final a = DateFormat('EEE, d/M/y', langCode).format(this!).tr();
    return a;
  }

  String getLocalDateString(BuildContext context) {
    final langCode = context.locale.languageCode;
    final localDate = this?.toLocal();
    if (localDate == null) return '-';
    final a = DateFormat('EEE, d/M/y', langCode).format(localDate).tr();
    return a;
  }

  String toHourMinuteString() {
    final localDate = this?.toLocal();
    final hour = localDate?.hour;
    final minute = localDate?.minute;
    final second = localDate?.second;
    return "$hour:$minute:$second";
  }
}
