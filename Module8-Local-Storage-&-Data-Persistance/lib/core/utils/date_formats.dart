import 'package:intl/intl.dart';

/// Utility class for consistent date formatting throughout the app
class DateFormats {
  // Private constructor to prevent instantiation
  DateFormats._();

  /// Format for displaying task creation date (e.g., "Jan 15, 2024")
  static final DateFormat _taskDate = DateFormat('MMM d, yyyy');

  /// Format for displaying task creation time (e.g., "2:30 PM")
  static final DateFormat _taskTime = DateFormat('h:mm a');

  /// Format for displaying full date and time (e.g., "Jan 15, 2024 at 2:30 PM")
  static final DateFormat _fullDateTime = DateFormat('MMM d, yyyy \'at\' h:mm a');

  /// Format for relative time (e.g., "2 hours ago", "3 days ago")
  static final DateFormat _relativeTime = DateFormat('MMM d');

  /// Format task creation date
  static String formatTaskDate(DateTime date) {
    return _taskDate.format(date);
  }

  /// Format task creation time
  static String formatTaskTime(DateTime date) {
    return _taskTime.format(date);
  }

  /// Format full date and time
  static String formatFullDateTime(DateTime date) {
    return _fullDateTime.format(date);
  }

  /// Get relative time string (e.g., "2 hours ago", "3 days ago")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return _relativeTime.format(date);
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } else {
      return 'Just now';
    }
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if a date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Get a user-friendly date string
  static String getFriendlyDate(DateTime date) {
    if (isToday(date)) {
      return 'Today at ${formatTaskTime(date)}';
    } else if (isYesterday(date)) {
      return 'Yesterday at ${formatTaskTime(date)}';
    } else {
      return formatFullDateTime(date);
    }
  }
}
