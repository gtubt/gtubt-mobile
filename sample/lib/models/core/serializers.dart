library serializers;

import 'package:GTUBT/models/event.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/models/user.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  User,
  Post,
  Event
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
