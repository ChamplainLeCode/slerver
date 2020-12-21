library slerver;

/// Type for route action
typedef ArgumentCallback<T, M> = Future<T> Function(M);

/// Route subscriber.
class SlerverRoute {

  /// Map of routes
  static Map<String, dynamic> routes = {};

  /// function use to subcribe routes
  void on(String path, dynamic callback) => routes[path] = callback;

  /// Return action for specific path
  getAction(String path) => routes[path];
}
