import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generic_json_converter_annotation/generic_json_converter_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'code_tpl.dart';

class GenericJsonConverterGenerator
    extends GeneratorForAnnotation<GenericJsonConverter> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotationReader, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
          "${element.displayName} is not a class");
    }

    String source;
    List<ElementAnnotation> annotations = element.metadata;
    for (ElementAnnotation annotation in annotations) {
      if (annotation.constantValue?.type?.displayName ==
          "GenericJsonConverter") {
        source = annotation.toSource();
        break;
      }
    }
    assert(source != null);
    const String start = "@GenericJsonConverter([";
    if (!source.startsWith(start)) {
      throw InvalidGenerationSourceError("classes can't be null or empty");
    }
    List<String> classes =
        source.substring(start.length, source.length - 2).split(", ");
    if (classes[0].isEmpty) {
      throw InvalidGenerationSourceError("classes can't be null or empty");
    }
    StringBuffer fromJsonCaseCode = StringBuffer();
    StringBuffer toJsonCaseCode = StringBuffer();

    for (String className in classes) {
      fromJsonCaseCode.writeln("      case $className:");
      fromJsonCaseCode.writeln(
          "        return $className.fromJson(json as Map<String, dynamic>) as T;");
      toJsonCaseCode.writeln("      case $className:");
      toJsonCaseCode.writeln("        return (value as $className).toJson();");
    }

    return CODE_TPL
        .replaceFirst("{{fromJsonCase}}", fromJsonCaseCode.toString())
        .replaceFirst("{{toJsonCase}}", toJsonCaseCode.toString())
        .replaceFirst("{{className}}", element.displayName);
  }
}
