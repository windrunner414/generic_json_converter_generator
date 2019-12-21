# generic_json_converter_generator

```dart
import 'package:generic_json_converter_annotation/generic_json_converter_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model1.dart';
import 'model2.dart'

part 'generic_converter.g.dart';

@GenericJsonConverter(classes: [Model1, Model2])
class GenericConverter<T extends Object>
    with _$GenericConverterMixin<T>
    implements JsonConverter<T, Object> {
  const GenericConverter();
}

```

```dart
@JsonSerializable()
class serializable<T extends Object> {
    @GenericConverter()
    T data;

    serializable({this.data});

    ...fromJson...
    ...toJson...
}
```
