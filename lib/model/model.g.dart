// GENERATED CODE - DO NOT MODIFY BY HAND

part of model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Article> _$articleSerializer = new _$ArticleSerializer();

class _$ArticleSerializer implements StructuredSerializer<Article> {
  @override
  final Iterable<Type> types = const [Article, _$Article];
  @override
  final String wireName = 'Article';

  @override
  Iterable<Object> serialize(Serializers serializers, Article object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'nid',
      serializers.serialize(object.nid, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.author != null) {
      result
        ..add('author')
        ..add(serializers.serialize(object.author,
            specifiedType: const FullType(String)));
    }
    if (object.content != null) {
      result
        ..add('content')
        ..add(serializers.serialize(object.content,
            specifiedType: const FullType(String)));
    }
    if (object.urlToImage != null) {
      result
        ..add('urlToImage')
        ..add(serializers.serialize(object.urlToImage,
            specifiedType: const FullType(String)));
    }
    if (object.publishedAt != null) {
      result
        ..add('publishedAt')
        ..add(serializers.serialize(object.publishedAt,
            specifiedType: const FullType(String)));
    }
    if (object.addedOn != null) {
      result
        ..add('addedOn')
        ..add(serializers.serialize(object.addedOn,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Article deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ArticleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'nid':
          result.nid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'urlToImage':
          result.urlToImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'publishedAt':
          result.publishedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'addedOn':
          result.addedOn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Article extends Article {
  @override
  final int nid;
  @override
  final String title;
  @override
  final String description;
  @override
  final String author;
  @override
  final String url;
  @override
  final String content;
  @override
  final String urlToImage;
  @override
  final String publishedAt;
  @override
  final String addedOn;

  factory _$Article([void Function(ArticleBuilder) updates]) =>
      (new ArticleBuilder()..update(updates)).build();

  _$Article._(
      {this.nid,
      this.title,
      this.description,
      this.author,
      this.url,
      this.content,
      this.urlToImage,
      this.publishedAt,
      this.addedOn})
      : super._() {
    if (nid == null) {
      throw new BuiltValueNullFieldError('Article', 'nid');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Article', 'title');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('Article', 'url');
    }
  }

  @override
  Article rebuild(void Function(ArticleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArticleBuilder toBuilder() => new ArticleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Article &&
        nid == other.nid &&
        title == other.title &&
        description == other.description &&
        author == other.author &&
        url == other.url &&
        content == other.content &&
        urlToImage == other.urlToImage &&
        publishedAt == other.publishedAt &&
        addedOn == other.addedOn;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, nid.hashCode), title.hashCode),
                                description.hashCode),
                            author.hashCode),
                        url.hashCode),
                    content.hashCode),
                urlToImage.hashCode),
            publishedAt.hashCode),
        addedOn.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Article')
          ..add('nid', nid)
          ..add('title', title)
          ..add('description', description)
          ..add('author', author)
          ..add('url', url)
          ..add('content', content)
          ..add('urlToImage', urlToImage)
          ..add('publishedAt', publishedAt)
          ..add('addedOn', addedOn))
        .toString();
  }
}

class ArticleBuilder implements Builder<Article, ArticleBuilder> {
  _$Article _$v;

  int _nid;
  int get nid => _$this._nid;
  set nid(int nid) => _$this._nid = nid;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  String _urlToImage;
  String get urlToImage => _$this._urlToImage;
  set urlToImage(String urlToImage) => _$this._urlToImage = urlToImage;

  String _publishedAt;
  String get publishedAt => _$this._publishedAt;
  set publishedAt(String publishedAt) => _$this._publishedAt = publishedAt;

  String _addedOn;
  String get addedOn => _$this._addedOn;
  set addedOn(String addedOn) => _$this._addedOn = addedOn;

  ArticleBuilder();

  ArticleBuilder get _$this {
    if (_$v != null) {
      _nid = _$v.nid;
      _title = _$v.title;
      _description = _$v.description;
      _author = _$v.author;
      _url = _$v.url;
      _content = _$v.content;
      _urlToImage = _$v.urlToImage;
      _publishedAt = _$v.publishedAt;
      _addedOn = _$v.addedOn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Article other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Article;
  }

  @override
  void update(void Function(ArticleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Article build() {
    final _$result = _$v ??
        new _$Article._(
            nid: nid,
            title: title,
            description: description,
            author: author,
            url: url,
            content: content,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            addedOn: addedOn);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
