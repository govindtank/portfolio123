import 'package:shared_preferences/shared_preferences.dart';

/// Service for tracking visitor count using local storage
/// This provides a simple visitor counter without any third-party dependencies
class VisitorCounterService {
  static const String _visitorCountKey = 'visitor_count';
  static const String _lastVisitKey = 'last_visit_date';
  static const String _visitorIdKey = 'visitor_id';
  
  int? _cachedCount;
  
  /// Get the current visitor count
  Future<int> getVisitorCount() async {
    final prefs = await SharedPreferences.getInstance();
    _cachedCount = prefs.getInt(_visitorCountKey) ?? 0;
    return _cachedCount!;
  }
  
  /// Increment the visitor count
  /// This should be called when a user visits the portfolio
  /// Uses a simple logic: increment once per day per device
  Future<int> incrementVisitorCount() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get current date string (YYYY-MM-DD)
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastVisit = prefs.getString(_lastVisitKey);
    
    // Get current count
    int count = prefs.getInt(_visitorCountKey) ?? 0;
    
    // Only increment if it's a new day or first visit
    if (lastVisit == null || lastVisit != today) {
      count++;
      await prefs.setInt(_visitorCountKey, count);
      await prefs.setString(_lastVisitKey, today);
    }
    
    _cachedCount = count;
    return count;
  }
  
  /// Force increment (for testing or manual counter management)
  Future<int> forceIncrement() async {
    final prefs = await SharedPreferences.getInstance();
    int count = (prefs.getInt(_visitorCountKey) ?? 0) + 1;
    await prefs.setInt(_visitorCountKey, count);
    _cachedCount = count;
    return count;
  }
  
  /// Reset the visitor count
  Future<void> resetCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_visitorCountKey);
    await prefs.remove(_lastVisitKey);
    await prefs.remove(_visitorIdKey);
    _cachedCount = 0;
  }
  
  /// Get cached count without fetching from storage
  int? getCachedCount() {
    return _cachedCount;
  }
}
