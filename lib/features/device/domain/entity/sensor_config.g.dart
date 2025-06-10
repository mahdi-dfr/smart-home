// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSensorConfigCollection on Isar {
  IsarCollection<SensorConfig> get sensorConfigs => this.collection();
}

const SensorConfigSchema = CollectionSchema(
  name: r'SensorConfig',
  id: 9051987648447573578,
  properties: {
    r'configRange': PropertySchema(
      id: 0,
      name: r'configRange',
      type: IsarType.long,
    ),
    r'configType': PropertySchema(
      id: 1,
      name: r'configType',
      type: IsarType.string,
    ),
    r'keyName': PropertySchema(
      id: 2,
      name: r'keyName',
      type: IsarType.string,
    ),
    r'maxOrMin': PropertySchema(
      id: 3,
      name: r'maxOrMin',
      type: IsarType.string,
    ),
    r'sensorName': PropertySchema(
      id: 4,
      name: r'sensorName',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.bool,
    )
  },
  estimateSize: _sensorConfigEstimateSize,
  serialize: _sensorConfigSerialize,
  deserialize: _sensorConfigDeserialize,
  deserializeProp: _sensorConfigDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sensorConfigGetId,
  getLinks: _sensorConfigGetLinks,
  attach: _sensorConfigAttach,
  version: '3.1.0+1',
);

int _sensorConfigEstimateSize(
  SensorConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.configType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.keyName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.maxOrMin;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sensorName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _sensorConfigSerialize(
  SensorConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.configRange);
  writer.writeString(offsets[1], object.configType);
  writer.writeString(offsets[2], object.keyName);
  writer.writeString(offsets[3], object.maxOrMin);
  writer.writeString(offsets[4], object.sensorName);
  writer.writeBool(offsets[5], object.status);
}

SensorConfig _sensorConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SensorConfig(
    reader.readStringOrNull(offsets[1]),
    reader.readLongOrNull(offsets[0]),
    reader.readStringOrNull(offsets[2]),
    reader.readBoolOrNull(offsets[5]),
    reader.readStringOrNull(offsets[4]),
    reader.readStringOrNull(offsets[3]),
  );
  object.isarId = id;
  return object;
}

P _sensorConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sensorConfigGetId(SensorConfig object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _sensorConfigGetLinks(SensorConfig object) {
  return [];
}

void _sensorConfigAttach(
    IsarCollection<dynamic> col, Id id, SensorConfig object) {
  object.isarId = id;
}

extension SensorConfigQueryWhereSort
    on QueryBuilder<SensorConfig, SensorConfig, QWhere> {
  QueryBuilder<SensorConfig, SensorConfig, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SensorConfigQueryWhere
    on QueryBuilder<SensorConfig, SensorConfig, QWhereClause> {
  QueryBuilder<SensorConfig, SensorConfig, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SensorConfigQueryFilter
    on QueryBuilder<SensorConfig, SensorConfig, QFilterCondition> {
  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configRangeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'configRange',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configRangeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'configRange',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configRangeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'configRange',
        value: value,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configRangeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'configRange',
        value: value,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configRangeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'configRange',
        value: value,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configRangeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'configRange',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'configType',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'configType',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'configType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'configType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'configType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'configType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'configType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'configType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'configType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'configType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'configType',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      configTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'configType',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'keyName',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'keyName',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyName',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      keyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keyName',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxOrMin',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxOrMin',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxOrMin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxOrMin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxOrMin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxOrMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maxOrMin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maxOrMin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maxOrMin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maxOrMin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxOrMin',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      maxOrMinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maxOrMin',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sensorName',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sensorName',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sensorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sensorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sensorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sensorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sensorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sensorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sensorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sensorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sensorName',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      sensorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sensorName',
        value: '',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterFilterCondition> statusEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }
}

extension SensorConfigQueryObject
    on QueryBuilder<SensorConfig, SensorConfig, QFilterCondition> {}

extension SensorConfigQueryLinks
    on QueryBuilder<SensorConfig, SensorConfig, QFilterCondition> {}

extension SensorConfigQuerySortBy
    on QueryBuilder<SensorConfig, SensorConfig, QSortBy> {
  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByConfigRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configRange', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy>
      sortByConfigRangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configRange', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByConfigType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configType', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy>
      sortByConfigTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configType', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByKeyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByKeyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByMaxOrMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOrMin', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByMaxOrMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOrMin', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortBySensorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensorName', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy>
      sortBySensorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensorName', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension SensorConfigQuerySortThenBy
    on QueryBuilder<SensorConfig, SensorConfig, QSortThenBy> {
  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByConfigRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configRange', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy>
      thenByConfigRangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configRange', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByConfigType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configType', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy>
      thenByConfigTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configType', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByKeyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByKeyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByMaxOrMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOrMin', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByMaxOrMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOrMin', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenBySensorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensorName', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy>
      thenBySensorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensorName', Sort.desc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension SensorConfigQueryWhereDistinct
    on QueryBuilder<SensorConfig, SensorConfig, QDistinct> {
  QueryBuilder<SensorConfig, SensorConfig, QDistinct> distinctByConfigRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'configRange');
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QDistinct> distinctByConfigType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'configType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QDistinct> distinctByKeyName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'keyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QDistinct> distinctByMaxOrMin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxOrMin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QDistinct> distinctBySensorName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sensorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SensorConfig, SensorConfig, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension SensorConfigQueryProperty
    on QueryBuilder<SensorConfig, SensorConfig, QQueryProperty> {
  QueryBuilder<SensorConfig, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<SensorConfig, int?, QQueryOperations> configRangeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'configRange');
    });
  }

  QueryBuilder<SensorConfig, String?, QQueryOperations> configTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'configType');
    });
  }

  QueryBuilder<SensorConfig, String?, QQueryOperations> keyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'keyName');
    });
  }

  QueryBuilder<SensorConfig, String?, QQueryOperations> maxOrMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxOrMin');
    });
  }

  QueryBuilder<SensorConfig, String?, QQueryOperations> sensorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sensorName');
    });
  }

  QueryBuilder<SensorConfig, bool?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
