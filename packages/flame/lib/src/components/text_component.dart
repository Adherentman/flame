import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/src/text/text_renderer.dart';
import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';

class TextComponent<T extends TextRenderer> extends PositionComponent {
  String _text;
  T _textRenderer;

  String get text => _text;

  set text(String text) {
    if (_text != text) {
      _text = text;
      updateBounds();
    }
  }

  T get textRenderer => _textRenderer;

  set textRenderer(T textRenderer) {
    _textRenderer = textRenderer;
    updateBounds();
  }

  TextComponent({
    String? text,
    T? textRenderer,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    Iterable<Component>? children,
    int? priority,
  })  : _text = text ?? '',
        _textRenderer = textRenderer ?? TextRenderer.createDefault<T>(),
        super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          children: children,
          priority: priority,
        ) {
    updateBounds();
  }

  @internal
  void updateBounds() {
    final expectedSize = textRenderer.measureText(_text);
    size.setValues(expectedSize.x, expectedSize.y);
  }

  @override
  void render(Canvas canvas) {
    _textRenderer.render(canvas, text, Vector2.zero());
  }
}
