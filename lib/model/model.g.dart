// GENERATED CODE - DO NOT MODIFY BY HAND

part of model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<News> _$newsSerializer = new _$NewsSerializer();
Serializer<StatsCounter> _$statsCounterSerializer =
    new _$StatsCounterSerializer();
Serializer<Hospital> _$hospitalSerializer = new _$HospitalSerializer();

class _$NewsSerializer implements StructuredSerializer<News> {
  @override
  final Iterable<Type> types = const [News, _$News];
  @override
  final String wireName = 'News';

  @override
  Iterable<Object> serialize(Serializers serializers, News object,
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
    if (object.countryCodes != null) {
      result
        ..add('countryCodes')
        ..add(serializers.serialize(object.countryCodes,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  News deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewsBuilder();

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
        case 'countryCodes':
          result.countryCodes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$StatsCounterSerializer implements StructuredSerializer<StatsCounter> {
  @override
  final Iterable<Type> types = const [StatsCounter, _$StatsCounter];
  @override
  final String wireName = 'StatsCounter';

  @override
  Iterable<Object> serialize(Serializers serializers, StatsCounter object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'num_confirm',
      serializers.serialize(object.numConfirm,
          specifiedType: const FullType(int)),
      'num_dead',
      serializers.serialize(object.numDead, specifiedType: const FullType(int)),
      'num_heal',
      serializers.serialize(object.numHeal, specifiedType: const FullType(int)),
    ];
    if (object.country != null) {
      result
        ..add('country')
        ..add(serializers.serialize(object.country,
            specifiedType: const FullType(int)));
    }
    if (object.numSuspect != null) {
      result
        ..add('num_suspect')
        ..add(serializers.serialize(object.numSuspect,
            specifiedType: const FullType(int)));
    }
    if (object.postedDate != null) {
      result
        ..add('posted_date')
        ..add(serializers.serialize(object.postedDate,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  StatsCounter deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StatsCounterBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'country':
          result.country = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_confirm':
          result.numConfirm = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_suspect':
          result.numSuspect = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_dead':
          result.numDead = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_heal':
          result.numHeal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'posted_date':
          result.postedDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$HospitalSerializer implements StructuredSerializer<Hospital> {
  @override
  final Iterable<Type> types = const [Hospital, _$Hospital];
  @override
  final String wireName = 'Hospital';

  @override
  Iterable<Object> serialize(Serializers serializers, Hospital object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'city',
      serializers.serialize(object.city, specifiedType: const FullType(String)),
      'state',
      serializers.serialize(object.state,
          specifiedType: const FullType(String)),
      'country',
      serializers.serialize(object.country,
          specifiedType: const FullType(String)),
      'telNo',
      serializers.serialize(object.telNo,
          specifiedType: const FullType(String)),
    ];
    if (object.lat != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(object.lat,
            specifiedType: const FullType(double)));
    }
    if (object.long != null) {
      result
        ..add('long')
        ..add(serializers.serialize(object.long,
            specifiedType: const FullType(double)));
    }
    if (object.addedBy != null) {
      result
        ..add('addedBy')
        ..add(serializers.serialize(object.addedBy,
            specifiedType: const FullType(String)));
    }
    if (object.source != null) {
      result
        ..add('source')
        ..add(serializers.serialize(object.source,
            specifiedType: const FullType(String)));
    }
    if (object.officialAdvisory != null) {
      result
        ..add('officialAdvisory')
        ..add(serializers.serialize(object.officialAdvisory,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Hospital deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HospitalBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country':
          result.country = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'telNo':
          result.telNo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'long':
          result.long = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'addedBy':
          result.addedBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'source':
          result.source = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'officialAdvisory':
          result.officialAdvisory = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$News extends News {
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
  @override
  final String countryCodes;

  factory _$News([void Function(NewsBuilder) updates]) =>
      (new NewsBuilder()..update(updates)).build();

  _$News._(
      {this.nid,
      this.title,
      this.description,
      this.author,
      this.url,
      this.content,
      this.urlToImage,
      this.publishedAt,
      this.addedOn,
      this.countryCodes})
      : super._() {
    if (nid == null) {
      throw new BuiltValueNullFieldError('News', 'nid');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('News', 'title');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('News', 'url');
    }
  }

  @override
  News rebuild(void Function(NewsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsBuilder toBuilder() => new NewsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is News &&
        nid == other.nid &&
        title == other.title &&
        description == other.description &&
        author == other.author &&
        url == other.url &&
        content == other.content &&
        urlToImage == other.urlToImage &&
        publishedAt == other.publishedAt &&
        addedOn == other.addedOn &&
        countryCodes == other.countryCodes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
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
            addedOn.hashCode),
        countryCodes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('News')
          ..add('nid', nid)
          ..add('title', title)
          ..add('description', description)
          ..add('author', author)
          ..add('url', url)
          ..add('content', content)
          ..add('urlToImage', urlToImage)
          ..add('publishedAt', publishedAt)
          ..add('addedOn', addedOn)
          ..add('countryCodes', countryCodes))
        .toString();
  }
}

class NewsBuilder implements Builder<News, NewsBuilder> {
  _$News _$v;

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

  String _countryCodes;
  String get countryCodes => _$this._countryCodes;
  set countryCodes(String countryCodes) => _$this._countryCodes = countryCodes;

  NewsBuilder();

  NewsBuilder get _$this {
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
      _countryCodes = _$v.countryCodes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(News other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$News;
  }

  @override
  void update(void Function(NewsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$News build() {
    final _$result = _$v ??
        new _$News._(
            nid: nid,
            title: title,
            description: description,
            author: author,
            url: url,
            content: content,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            addedOn: addedOn,
            countryCodes: countryCodes);
    replace(_$result);
    return _$result;
  }
}

class _$StatsCounter extends StatsCounter {
  @override
  final int country;
  @override
  final int numConfirm;
  @override
  final int numSuspect;
  @override
  final int numDead;
  @override
  final int numHeal;
  @override
  final String postedDate;

  factory _$StatsCounter([void Function(StatsCounterBuilder) updates]) =>
      (new StatsCounterBuilder()..update(updates)).build();

  _$StatsCounter._(
      {this.country,
      this.numConfirm,
      this.numSuspect,
      this.numDead,
      this.numHeal,
      this.postedDate})
      : super._() {
    if (numConfirm == null) {
      throw new BuiltValueNullFieldError('StatsCounter', 'numConfirm');
    }
    if (numDead == null) {
      throw new BuiltValueNullFieldError('StatsCounter', 'numDead');
    }
    if (numHeal == null) {
      throw new BuiltValueNullFieldError('StatsCounter', 'numHeal');
    }
  }

  @override
  StatsCounter rebuild(void Function(StatsCounterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatsCounterBuilder toBuilder() => new StatsCounterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatsCounter &&
        country == other.country &&
        numConfirm == other.numConfirm &&
        numSuspect == other.numSuspect &&
        numDead == other.numDead &&
        numHeal == other.numHeal &&
        postedDate == other.postedDate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, country.hashCode), numConfirm.hashCode),
                    numSuspect.hashCode),
                numDead.hashCode),
            numHeal.hashCode),
        postedDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StatsCounter')
          ..add('country', country)
          ..add('numConfirm', numConfirm)
          ..add('numSuspect', numSuspect)
          ..add('numDead', numDead)
          ..add('numHeal', numHeal)
          ..add('postedDate', postedDate))
        .toString();
  }
}

class StatsCounterBuilder
    implements Builder<StatsCounter, StatsCounterBuilder> {
  _$StatsCounter _$v;

  int _country;
  int get country => _$this._country;
  set country(int country) => _$this._country = country;

  int _numConfirm;
  int get numConfirm => _$this._numConfirm;
  set numConfirm(int numConfirm) => _$this._numConfirm = numConfirm;

  int _numSuspect;
  int get numSuspect => _$this._numSuspect;
  set numSuspect(int numSuspect) => _$this._numSuspect = numSuspect;

  int _numDead;
  int get numDead => _$this._numDead;
  set numDead(int numDead) => _$this._numDead = numDead;

  int _numHeal;
  int get numHeal => _$this._numHeal;
  set numHeal(int numHeal) => _$this._numHeal = numHeal;

  String _postedDate;
  String get postedDate => _$this._postedDate;
  set postedDate(String postedDate) => _$this._postedDate = postedDate;

  StatsCounterBuilder();

  StatsCounterBuilder get _$this {
    if (_$v != null) {
      _country = _$v.country;
      _numConfirm = _$v.numConfirm;
      _numSuspect = _$v.numSuspect;
      _numDead = _$v.numDead;
      _numHeal = _$v.numHeal;
      _postedDate = _$v.postedDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatsCounter other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StatsCounter;
  }

  @override
  void update(void Function(StatsCounterBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StatsCounter build() {
    final _$result = _$v ??
        new _$StatsCounter._(
            country: country,
            numConfirm: numConfirm,
            numSuspect: numSuspect,
            numDead: numDead,
            numHeal: numHeal,
            postedDate: postedDate);
    replace(_$result);
    return _$result;
  }
}

class _$Hospital extends Hospital {
  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String address;
  @override
  final String city;
  @override
  final String state;
  @override
  final String country;
  @override
  final String telNo;
  @override
  final double lat;
  @override
  final double long;
  @override
  final String addedBy;
  @override
  final String source;
  @override
  final String officialAdvisory;

  factory _$Hospital([void Function(HospitalBuilder) updates]) =>
      (new HospitalBuilder()..update(updates)).build();

  _$Hospital._(
      {this.id,
      this.name,
      this.description,
      this.address,
      this.city,
      this.state,
      this.country,
      this.telNo,
      this.lat,
      this.long,
      this.addedBy,
      this.source,
      this.officialAdvisory})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Hospital', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Hospital', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Hospital', 'description');
    }
    if (address == null) {
      throw new BuiltValueNullFieldError('Hospital', 'address');
    }
    if (city == null) {
      throw new BuiltValueNullFieldError('Hospital', 'city');
    }
    if (state == null) {
      throw new BuiltValueNullFieldError('Hospital', 'state');
    }
    if (country == null) {
      throw new BuiltValueNullFieldError('Hospital', 'country');
    }
    if (telNo == null) {
      throw new BuiltValueNullFieldError('Hospital', 'telNo');
    }
  }

  @override
  Hospital rebuild(void Function(HospitalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HospitalBuilder toBuilder() => new HospitalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hospital &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        address == other.address &&
        city == other.city &&
        state == other.state &&
        country == other.country &&
        telNo == other.telNo &&
        lat == other.lat &&
        long == other.long &&
        addedBy == other.addedBy &&
        source == other.source &&
        officialAdvisory == other.officialAdvisory;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, id.hashCode),
                                                    name.hashCode),
                                                description.hashCode),
                                            address.hashCode),
                                        city.hashCode),
                                    state.hashCode),
                                country.hashCode),
                            telNo.hashCode),
                        lat.hashCode),
                    long.hashCode),
                addedBy.hashCode),
            source.hashCode),
        officialAdvisory.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Hospital')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('address', address)
          ..add('city', city)
          ..add('state', state)
          ..add('country', country)
          ..add('telNo', telNo)
          ..add('lat', lat)
          ..add('long', long)
          ..add('addedBy', addedBy)
          ..add('source', source)
          ..add('officialAdvisory', officialAdvisory))
        .toString();
  }
}

class HospitalBuilder implements Builder<Hospital, HospitalBuilder> {
  _$Hospital _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _state;
  String get state => _$this._state;
  set state(String state) => _$this._state = state;

  String _country;
  String get country => _$this._country;
  set country(String country) => _$this._country = country;

  String _telNo;
  String get telNo => _$this._telNo;
  set telNo(String telNo) => _$this._telNo = telNo;

  double _lat;
  double get lat => _$this._lat;
  set lat(double lat) => _$this._lat = lat;

  double _long;
  double get long => _$this._long;
  set long(double long) => _$this._long = long;

  String _addedBy;
  String get addedBy => _$this._addedBy;
  set addedBy(String addedBy) => _$this._addedBy = addedBy;

  String _source;
  String get source => _$this._source;
  set source(String source) => _$this._source = source;

  String _officialAdvisory;
  String get officialAdvisory => _$this._officialAdvisory;
  set officialAdvisory(String officialAdvisory) =>
      _$this._officialAdvisory = officialAdvisory;

  HospitalBuilder();

  HospitalBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _description = _$v.description;
      _address = _$v.address;
      _city = _$v.city;
      _state = _$v.state;
      _country = _$v.country;
      _telNo = _$v.telNo;
      _lat = _$v.lat;
      _long = _$v.long;
      _addedBy = _$v.addedBy;
      _source = _$v.source;
      _officialAdvisory = _$v.officialAdvisory;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hospital other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Hospital;
  }

  @override
  void update(void Function(HospitalBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Hospital build() {
    final _$result = _$v ??
        new _$Hospital._(
            id: id,
            name: name,
            description: description,
            address: address,
            city: city,
            state: state,
            country: country,
            telNo: telNo,
            lat: lat,
            long: long,
            addedBy: addedBy,
            source: source,
            officialAdvisory: officialAdvisory);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
