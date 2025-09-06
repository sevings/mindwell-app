// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_design.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwDesignTextAlignmentEnum _$mwDesignTextAlignmentEnum_left =
    const MwDesignTextAlignmentEnum._('left');
const MwDesignTextAlignmentEnum _$mwDesignTextAlignmentEnum_right =
    const MwDesignTextAlignmentEnum._('right');
const MwDesignTextAlignmentEnum _$mwDesignTextAlignmentEnum_center =
    const MwDesignTextAlignmentEnum._('center');
const MwDesignTextAlignmentEnum _$mwDesignTextAlignmentEnum_justify =
    const MwDesignTextAlignmentEnum._('justify');

MwDesignTextAlignmentEnum _$mwDesignTextAlignmentEnumValueOf(String name) {
  switch (name) {
    case 'left':
      return _$mwDesignTextAlignmentEnum_left;
    case 'right':
      return _$mwDesignTextAlignmentEnum_right;
    case 'center':
      return _$mwDesignTextAlignmentEnum_center;
    case 'justify':
      return _$mwDesignTextAlignmentEnum_justify;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MwDesignTextAlignmentEnum> _$mwDesignTextAlignmentEnumValues =
    BuiltSet<MwDesignTextAlignmentEnum>(const <MwDesignTextAlignmentEnum>[
  _$mwDesignTextAlignmentEnum_left,
  _$mwDesignTextAlignmentEnum_right,
  _$mwDesignTextAlignmentEnum_center,
  _$mwDesignTextAlignmentEnum_justify,
]);

Serializer<MwDesignTextAlignmentEnum> _$mwDesignTextAlignmentEnumSerializer =
    _$MwDesignTextAlignmentEnumSerializer();

class _$MwDesignTextAlignmentEnumSerializer
    implements PrimitiveSerializer<MwDesignTextAlignmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'left': 'left',
    'right': 'right',
    'center': 'center',
    'justify': 'justify',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'left': 'left',
    'right': 'right',
    'center': 'center',
    'justify': 'justify',
  };

  @override
  final Iterable<Type> types = const <Type>[MwDesignTextAlignmentEnum];
  @override
  final String wireName = 'MwDesignTextAlignmentEnum';

  @override
  Object serialize(Serializers serializers, MwDesignTextAlignmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwDesignTextAlignmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwDesignTextAlignmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwDesign extends MwDesign {
  @override
  final String? css;
  @override
  final String? backgroundColor;
  @override
  final String? textColor;
  @override
  final String? fontFamily;
  @override
  final int? fontSize;
  @override
  final MwDesignTextAlignmentEnum? textAlignment;

  factory _$MwDesign([void Function(MwDesignBuilder)? updates]) =>
      (MwDesignBuilder()..update(updates))._build();

  _$MwDesign._(
      {this.css,
      this.backgroundColor,
      this.textColor,
      this.fontFamily,
      this.fontSize,
      this.textAlignment})
      : super._();
  @override
  MwDesign rebuild(void Function(MwDesignBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwDesignBuilder toBuilder() => MwDesignBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwDesign &&
        css == other.css &&
        backgroundColor == other.backgroundColor &&
        textColor == other.textColor &&
        fontFamily == other.fontFamily &&
        fontSize == other.fontSize &&
        textAlignment == other.textAlignment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, css.hashCode);
    _$hash = $jc(_$hash, backgroundColor.hashCode);
    _$hash = $jc(_$hash, textColor.hashCode);
    _$hash = $jc(_$hash, fontFamily.hashCode);
    _$hash = $jc(_$hash, fontSize.hashCode);
    _$hash = $jc(_$hash, textAlignment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwDesign')
          ..add('css', css)
          ..add('backgroundColor', backgroundColor)
          ..add('textColor', textColor)
          ..add('fontFamily', fontFamily)
          ..add('fontSize', fontSize)
          ..add('textAlignment', textAlignment))
        .toString();
  }
}

class MwDesignBuilder implements Builder<MwDesign, MwDesignBuilder> {
  _$MwDesign? _$v;

  String? _css;
  String? get css => _$this._css;
  set css(String? css) => _$this._css = css;

  String? _backgroundColor;
  String? get backgroundColor => _$this._backgroundColor;
  set backgroundColor(String? backgroundColor) =>
      _$this._backgroundColor = backgroundColor;

  String? _textColor;
  String? get textColor => _$this._textColor;
  set textColor(String? textColor) => _$this._textColor = textColor;

  String? _fontFamily;
  String? get fontFamily => _$this._fontFamily;
  set fontFamily(String? fontFamily) => _$this._fontFamily = fontFamily;

  int? _fontSize;
  int? get fontSize => _$this._fontSize;
  set fontSize(int? fontSize) => _$this._fontSize = fontSize;

  MwDesignTextAlignmentEnum? _textAlignment;
  MwDesignTextAlignmentEnum? get textAlignment => _$this._textAlignment;
  set textAlignment(MwDesignTextAlignmentEnum? textAlignment) =>
      _$this._textAlignment = textAlignment;

  MwDesignBuilder() {
    MwDesign._defaults(this);
  }

  MwDesignBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _css = $v.css;
      _backgroundColor = $v.backgroundColor;
      _textColor = $v.textColor;
      _fontFamily = $v.fontFamily;
      _fontSize = $v.fontSize;
      _textAlignment = $v.textAlignment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwDesign other) {
    _$v = other as _$MwDesign;
  }

  @override
  void update(void Function(MwDesignBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwDesign build() => _build();

  _$MwDesign _build() {
    final _$result = _$v ??
        _$MwDesign._(
          css: css,
          backgroundColor: backgroundColor,
          textColor: textColor,
          fontFamily: fontFamily,
          fontSize: fontSize,
          textAlignment: textAlignment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
