import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generic_json_converter_generator.dart';

Builder genericJsonConverterBuilder(BuilderOptions options) =>
    SharedPartBuilder(
        [GenericJsonConverterGenerator()], "generic_json_converter_builder");
