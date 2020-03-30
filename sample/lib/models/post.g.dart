// GENERATED CODE - DO NOT MODIFY BY HAND

part of post;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PostType _$announcement = const PostType._('announcement');
const PostType _$news = const PostType._('news');

PostType _$valueOf(String name) {
  switch (name) {
    case 'announcement':
      return _$announcement;
    case 'news':
      return _$news;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PostType> _$values = new BuiltSet<PostType>(const <PostType>[
  _$announcement,
  _$news,
]);

Serializer<Post> _$postSerializer = new _$PostSerializer();
Serializer<PostType> _$postTypeSerializer = new _$PostTypeSerializer();

class _$PostSerializer implements StructuredSerializer<Post> {
  @override
  final Iterable<Type> types = const [Post, _$Post];
  @override
  final String wireName = 'Post';

  @override
  Iterable<Object> serialize(Serializers serializers, Post object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'coverImageUrl',
      serializers.serialize(object.coverImageUrl,
          specifiedType: const FullType(String)),
      'summary',
      serializers.serialize(object.summary,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(PostType)),
      'startDate',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(String)),
      'endDate',
      serializers.serialize(object.endDate,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Post deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PostBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'coverImageUrl':
          result.coverImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'summary':
          result.summary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(PostType)) as PostType;
          break;
        case 'startDate':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PostTypeSerializer implements PrimitiveSerializer<PostType> {
  @override
  final Iterable<Type> types = const <Type>[PostType];
  @override
  final String wireName = 'PostType';

  @override
  Object serialize(Serializers serializers, PostType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  PostType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PostType.valueOf(serialized as String);
}

class _$Post extends Post {
  @override
  final String title;
  @override
  final String body;
  @override
  final String coverImageUrl;
  @override
  final String summary;
  @override
  final PostType type;
  @override
  final String startDate;
  @override
  final String endDate;

  factory _$Post([void Function(PostBuilder) updates]) =>
      (new PostBuilder()..update(updates)).build();

  _$Post._(
      {this.title,
      this.body,
      this.coverImageUrl,
      this.summary,
      this.type,
      this.startDate,
      this.endDate})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('Post', 'title');
    }
    if (body == null) {
      throw new BuiltValueNullFieldError('Post', 'body');
    }
    if (coverImageUrl == null) {
      throw new BuiltValueNullFieldError('Post', 'coverImageUrl');
    }
    if (summary == null) {
      throw new BuiltValueNullFieldError('Post', 'summary');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('Post', 'type');
    }
    if (startDate == null) {
      throw new BuiltValueNullFieldError('Post', 'startDate');
    }
    if (endDate == null) {
      throw new BuiltValueNullFieldError('Post', 'endDate');
    }
  }

  @override
  Post rebuild(void Function(PostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostBuilder toBuilder() => new PostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post &&
        title == other.title &&
        body == other.body &&
        coverImageUrl == other.coverImageUrl &&
        summary == other.summary &&
        type == other.type &&
        startDate == other.startDate &&
        endDate == other.endDate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, title.hashCode), body.hashCode),
                        coverImageUrl.hashCode),
                    summary.hashCode),
                type.hashCode),
            startDate.hashCode),
        endDate.hashCode));
  }
}

class PostBuilder implements Builder<Post, PostBuilder> {
  _$Post _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  String _coverImageUrl;
  String get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  String _summary;
  String get summary => _$this._summary;
  set summary(String summary) => _$this._summary = summary;

  PostType _type;
  PostType get type => _$this._type;
  set type(PostType type) => _$this._type = type;

  String _startDate;
  String get startDate => _$this._startDate;
  set startDate(String startDate) => _$this._startDate = startDate;

  String _endDate;
  String get endDate => _$this._endDate;
  set endDate(String endDate) => _$this._endDate = endDate;

  PostBuilder();

  PostBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _body = _$v.body;
      _coverImageUrl = _$v.coverImageUrl;
      _summary = _$v.summary;
      _type = _$v.type;
      _startDate = _$v.startDate;
      _endDate = _$v.endDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Post other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Post;
  }

  @override
  void update(void Function(PostBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Post build() {
    final _$result = _$v ??
        new _$Post._(
            title: title,
            body: body,
            coverImageUrl: coverImageUrl,
            summary: summary,
            type: type,
            startDate: startDate,
            endDate: endDate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
