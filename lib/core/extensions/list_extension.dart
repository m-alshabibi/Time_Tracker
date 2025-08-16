extension ListExtension<T> on List<T> {
  List<T> distinct([Object? Function(T element)? key]) {
    if (key == null) {
      return toSet().toList();
    }
    final tmp = <Object?, T>{};
    for (final element in this) {
      final o = key.call(element);
      if (tmp.containsKey(o)) {
        continue;
      }
      tmp[o] = element;
    }
    return tmp.values.toList();
  }
}
