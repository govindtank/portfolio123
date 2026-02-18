import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Service for tracking and displaying visitor count using CountAPI
/// CountAPI is a free, simple API for counting without backend setup
class VisitorCounterService {
  static const String _namespace = 'govindtank';
  static const String _key = 'portfolio';
  static const String _baseUrl = 'https://api.countapi.xyz';
  
  static const String _cacheKey = 'visitor_count';
  static const String _lastUpdatedKey = 'visitor_count_last_updated';
  
  int? _cachedCount;
  DateTime? _lastUpdated;
  
  /// Get the current visitor count
  /// Returns cached value if available and less than 5 minutes old
  /// Otherwise fetches fresh data from CountAPI
  Future<int> getVisitorCount() async {
    // Check cache first
    final prefs = await SharedPreferences.getInstance();
    final cachedCount = prefs.getInt(_cacheKey);
    final lastUpdated = prefs.getString(_lastUpdatedKey);
    
    if (cachedCount != null && lastUpdated != null) {
      final lastUpdatedTime = DateTime.parse(lastUpdated);
      final now = DateTime.now();
      
      // Use cache if less than 5 minutes old
      if (now.difference(lastUpdatedTime).inMinutes < 5) {
        _cachedCount = cachedCount;
        _lastUpdated = lastUpdatedTime;
        return cachedCount;
      }
    }
    
    // Fetch fresh data
    return await _fetchVisitorCount();
  }
  
  /// Increment the visitor count
  /// This should be called when a user visits the portfolio
  Future<int> incrementVisitorCount() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/hit/$_namespace/$_key'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final count = data['value'] as int;
        
        // Update cache
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_cacheKey, count);
        await prefs.setString(_lastUpdatedKey, DateTime.now().toIso8601String());
        
        _cachedCount = count;
        _lastUpdated = DateTime.now();
        
        return count;
      }
    } catch (e) {
      // If API fails, return cached count or 0
      return _cachedCount ?? await _getCachedCount();
    }
    
    return _cachedCount ?? 0;
  }
  
  /// Fetch visitor count from CountAPI
  Future<int> _fetchVisitorCount() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/get/$_namespace/$_key'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final count = data['value'] as int;
        
        // Update cache
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_cacheKey, count);
        await prefs.setString(_lastUpdatedKey, DateTime.now().toIso8601String());
        
        _cachedCount = count;
        _lastUpdated = DateTime.now();
        
        return count;
      }
    } catch (e) {
      // Return cached count on error
      return await _getCachedCount();
    }
    
    return 0;
  }
  
  /// Get cached count from SharedPreferences
  Future<int> _getCachedCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_cacheKey) ?? 0;
  }
  
  /// Get the CountAPI URL for displaying in README
  static String getCounterBadgeUrl() {
    return '$_baseUrl/badge/$_namespace/$_key';
  }
  
  /// Get the CountAPI URL for incrementing
  static String getIncrementUrl() {
    return '$_baseUrl/hit/$_namespace/$_key';
  }
}