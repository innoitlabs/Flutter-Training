/// Breakpoint constants for responsive design
class Breakpoints {
  // Small screens (phones)
  static const double small = 600;
  
  // Medium screens (tablets)
  static const double medium = 1024;
  
  // Large screens (desktops)
  static const double large = 1440;
  
  /// Returns true if the width is considered compact (mobile-like)
  static bool isCompact(double width) => width < small;
  
  /// Returns true if the width is considered medium (tablet-like)
  static bool isMedium(double width) => width >= small && width < medium;
  
  /// Returns true if the width is considered large (desktop-like)
  static bool isLarge(double width) => width >= medium;
  
  /// Returns the appropriate content max width based on screen size
  static double getContentMaxWidth(double width) {
    if (isCompact(width)) {
      return width - 32; // Full width minus padding
    } else if (isMedium(width)) {
      return 800; // Fixed medium width
    } else {
      return 1200; // Fixed large width
    }
  }
  
  /// Returns appropriate horizontal padding based on screen size
  static double getHorizontalPadding(double width) {
    if (isCompact(width)) {
      return 16;
    } else if (isMedium(width)) {
      return 32;
    } else {
      return 48;
    }
  }
}
