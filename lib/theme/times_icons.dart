import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'times_color.dart';

/// Constans for custom icons.
class TimesIcons {
  static const Icon fullHeart = Icon(
    Icons.favorite,
    color: TimesColor.orange,
    size: 24,
  );
  static const Icon emptyHeart =
      Icon(Icons.favorite_border, color: TimesColor.orange, size: 24);
}
