<div align="center">

**Languages:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

Save values to cache:

```dart
void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  cache.set('key', '1o23fjadijs');
}
```

Save and retrieve values from cache:

```dart
void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  cache.set('key', '1o23fjadijs');

  print(cache['name']);

  print(cache['key']);
}
```

Save values and specify a lifetime for them:

```dart
void main(List<String> args) {
  var cache = Cache(checkPeriod: const Duration(seconds: 1));

  cache.set('name', 'Alex',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(seconds: 3)));

  cache.set('key', '1o23fjadijs',
      expirationSetting:
          ExpirationSetting(expiration: const Duration(seconds: 3)));

  print(cache['name']);

  print(cache['key']);

  Future.delayed(const Duration(seconds: 4), () {
    print(cache['name']);

    print(cache['key']);

    cache.dispose();
  });
}
```

Записать значения и удалить их все:

```dart
void main(List<String> args) {
  var cache = Cache(deleteOnExpire: false);

  cache.set('name', 'Alex');

  print(cache['name']);

  cache.clear();

  print(cache['name']);
}
```
