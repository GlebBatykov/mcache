library cache;

import 'dart:async';

part 'cached_value.dart';

///
class Cache {
  final Map<String, CachedValue> _values = {};

  ///
  List<String> get keys => _values.keys.toList();

  Timer? _expirationTimer;

  bool _isDisposed = false;

  ///
  bool get isDisposed => _isDisposed;

  Cache(
      {bool deleteOnExpire = true,
      Duration checkPeriod = const Duration(seconds: 600)}) {
    if (deleteOnExpire) {
      _expirationTimer = Timer.periodic(checkPeriod, (timer) {
        _checkExpiration();
      });
    }
  }

  void _checkExpiration() {
    _values.removeWhere(
        (key, value) => value.expiration != null && value.isExpire());
  }

  ///
  void set(String key, dynamic value, {Duration? expiration}) {
    _values[key] = (CachedValue(value, expiration, DateTime.now()));
  }

  ///
  void delete(String key) {
    _values.remove(key);
  }

  ///
  void changeExpiration(String key, Duration expiration) {
    var value = _values[key];

    if (value != null) {
      value.expiration = expiration;
    }
  }

  ///
  bool has(String key) {
    return _values.containsKey(key);
  }

  ///
  void clear() {
    _values.clear();
  }

  ///
  void dispose() {
    if (!_isDisposed) {
      _expirationTimer?.cancel();

      _expirationTimer = null;

      _values.clear();

      _isDisposed = true;
    }
  }

  ///
  dynamic get(String key) {
    var value = _values[key];

    if (value != null) {
      if (value.expiration != null && value.isExpire()) {
        delete(key);

        return null;
      } else {
        return value.value;
      }
    } else {
      return null;
    }
  }

  dynamic operator [](String key) {
    return get(key);
  }
}
