import 'visitor_storage_io.dart' if (dart.library.html) 'visitor_storage_web.dart' as storage;

/// Service for tracking visitor count using local storage
/// This provides a simple visitor counter without any third-party dependencies
class VisitorCounterService {
  static const String _visitorCountKey = 'visitor_count';
  static const String _lastVisitKey = 'last_visit_date';
  static const String _visitorIdKey = 'visitor_id';
  
  int? _cachedCount;
  
  /// Get the current visitor count
  Future<int> getVisitorCount() async {
    final value = await storage.getInt(_visitorCountKey);
    _cachedCount = value ?? 0;
    return _cachedCount!;
  }
  
  /// Increment the visitor count
  /// This should be called when a user visits the portfolio
  /// Uses a simple logic: increment once per day per device
  Future<int> incrementVisitorCount() async {
    // Get current date string (YYYY-MM-DD)
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastVisit = await storage.getString(_lastVisitKey);

    // Get current count
    int count = (await storage.getInt(_visitorCountKey)) ?? 0;

    // Only increment if it's a new day or first visit
    if (lastVisit == null || lastVisit != today) {
      count++;
      await storage.setInt(_visitorCountKey, count);
      await storage.setString(_lastVisitKey, today);
    }

    _cachedCount = count;
    return count;
  }
  
  /// Force increment (for testing or manual counter management)
  Future<int> forceIncrement() async {
    int count = ((await storage.getInt(_visitorCountKey)) ?? 0) + 1;
    await storage.setInt(_visitorCountKey, count);
    _cachedCount = count;
    return count;
  }
  
  /// Reset the visitor count
  Future<void> resetCount() async {
    await storage.remove(_visitorCountKey);
    await storage.remove(_lastVisitKey);
    await storage.remove(_visitorIdKey);
    _cachedCount = 0;
  }
  
  /// Get cached count without fetching from storage
  int? getCachedCount() {
    return _cachedCount;
  }
}
