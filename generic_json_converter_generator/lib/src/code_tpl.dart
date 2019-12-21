const CODE_TPL = '''
abstract class _\${{className}}Mixin<T extends Object> {
  T fromJson(Object json) {
    switch (T) {
{{fromJsonCase}}      default:
        return json as T;
    }
  }

  toJson(T value) {
    switch (T) {
{{toJsonCase}}      default:
        return value;
    }
  }
}

''';
