import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/faculty_detail_screen.dart';
import '../screens/emergency_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/map_screen.dart';
import '../screens/search_screen.dart';
import '../screens/campus_floor_map_screen.dart';
import '../screens/amenities_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case AppRoutes.facultyDetail:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => FacultyDetailScreen(
              deptId: args['deptId'] as String,
              deptData: args['data'] as Map<String, dynamic>?,
            ),
          );
        }
        return _errorRoute("Missing department arguments");

      case AppRoutes.emergencyDesk:
        return MaterialPageRoute(builder: (_) => const EmergencyScreen());

      case AppRoutes.bookmarks:
        return MaterialPageRoute(builder: (_) => const BookmarksScreen());

      case AppRoutes.mapRoute:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => MapScreen(
              destinationName: args['name'] as String?,
              destinationBlock: args['block'] as String?,
              floor: args['floor'] as int?,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const MapScreen());

      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case AppRoutes.floorMap:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => CampusFloorMapScreen(
              initialBlock: args['blockNumber'] as int? ?? 1,
              initialFloor: args['floor'] as int? ?? 0,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const CampusFloorMapScreen());

      case AppRoutes.amenities:
        return MaterialPageRoute(builder: (_) => const AmenitiesScreen());

      default:
        return _errorRoute("Route not found: ${settings.name}");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Navigation Error")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}