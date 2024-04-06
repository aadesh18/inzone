import 'package:flutter/material.dart';

///
/// A `TypeSelector` widget to usage for select one in yours available [options].
///
/// The type parameter `T` serves the same purpose as that of the
/// [TypeSelector] class' type parameter.
/// The [TypeSelector] requests a `callback Function(T)` named as
/// [onValueChanged] which will be triggered after the [value] changed.
///
/// If the [options] list is absent, an assertion error will be throw.
/// ```dart
/// assert(options != null);
/// ```
/// If the [onValueChanged] function is absent, an assertion error will be throw.
/// ```dart
/// assert(onValueChanged != null);
/// ```
///
class DaysSelector<T> extends StatelessWidget {
  /// The available [options] for `TypeSelector`.
  ///
  /// The [options] list ` must not be null`.
  /// The [options] list ` must contain at least 2 elements`.
  ///
  /// Example of usage:
  /// ```dart
  /// TypeSelector<bool>(
  ///   options: [true, false],
  ///   // other properties
  /// );
  /// ```
  final List<T> options;

  /// Defines value of `TypeSelector` is a single or [multiple] objects.
  /// The default value is:
  /// ```dart
  /// false
  /// ```
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   multiple: [true, false],
  ///   // other properties
  /// );
  /// ```
  final bool multiple;

  /// The [value] for this `TypeSelector`.
  ///
  /// Example of usage:
  /// ```dart
  /// String? myValue;
  /// TypeSelector(
  ///   value: myValue, // Your custom value
  ///   // other properties
  /// );
  /// ```
  final T? value;

  /// The callback function reference that is called after
  /// the `TypeSelector` value changes.
  /// Triggered when the [value] is changed.
  ///
  /// The [onValueChanged] function ` must not be null if multiple attribute is [false]`.
  ///
  /// Example of usage:
  /// ```dart
  /// void myOnChangeMethod(T value) {
  ///     print(value); // Do something
  /// }
  ///
  /// TypeSelector(onValueChanged: myOnChangeMethod);
  /// ```
  final ValueChanged<T?>? onValueChanged;

  /// The [values] for this `TypeSelector` (when multiple attribute is [true]).
  ///
  /// Example of usage:
  /// ```dart
  /// List<String>? myValues;
  /// TypeSelector(
  ///   values: myValues, // Your custom list of values
  ///   multiple: true,
  ///   // other properties
  /// );
  /// ```
  late List<T>? values;

  /// The callback function reference that is called after
  /// the `TypeSelector` values changes.
  /// Triggered when the [values] is changed.
  ///
  /// The [onValueChanged] function ` must not be null if multiple attribute is [true]`.
  ///
  /// Example of usage:
  /// ```dart
  /// void myOnChangeMethod(List<T> values) {
  ///     values.forEach((value) => print(value)); // Do something
  /// }
  ///
  /// TypeSelector(
  ///   onValuesChanged: myOnChangeMethod,
  ///   multiple: true,
  /// );
  /// ```
  final ValueChanged<List<T>>? onValuesChanged;

  /// The [maxQuantityValues] for this `TypeSelector` (when multiple attribute is [true]).
  ///
  /// The [maxQuantityValues] value ` must be greater or equal to 1`.
  ///
  /// The default value is:
  /// ```dart
  /// values.length // if multiple is [true]
  /// ```
  ///
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   maxQuantityValues: 3, // the value must be 1 or more
  ///   multiple: true,
  ///   // other properties
  /// );
  /// ```
  final int? maxQuantityValues;

  /// The `Callback function` called when [values.length == maxQuantityValues].
  ///
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   onMaxQuantityValues: (max) {
  ///       print('Max quantity reached: $max');
  ///   },
  ///   multiple: true,
  ///   // other properties
  /// );
  /// ```
  final void Function(int maxQuantityValues)? onMaxQuantityValues;

  /// The [transitionDuration] of the `TypeSelector` animation on value changed.
  /// The default value is:
  /// ```dart
  /// Duration(milliseconds: 250);
  /// ```
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   transitionDuration: Duration(milliseconds: 250),
  ///   // other properties
  /// );
  /// ```
  final Duration transitionDuration;

  /// The padding for the `TypeSelector`.
  /// The default value is:
  /// ```dart
  /// EdgeInsets.all(8.0);
  /// ```
  /// /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
  ///   // other properties
  /// );
  /// ```
  final EdgeInsets contentPadding;

  /// The overflow mode when the label is overflowing the [optionWidth].
  /// The default value is:
  /// ```dart
  /// TextOverflow.clip
  /// ```
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   valueLabelOverflow: TextOverflow.ellipsis,
  ///   // other properties
  /// );
  /// ```
  final TextOverflow valueLabelOverflow;

  /// If this value is set to [true], on tap in the current selected option the
  /// [value] is set to [null].
  ///
  /// The default value is `false`.
  ///
  /// ![Toggle option:](https://github.com/luizjacomn/flutter_util_widgets/raw/master/sample/select_one_button/toggle_option_on_tap.png)
  final bool toggleOptionOnTap;

  /// The separator width for [options].
  ///
  /// The default value is `2.0`.
  ///
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   separatorWidth: 5.0,
  ///   // other properties
  /// );
  /// ```
  final double separatorWidth;

  /// The height for `TypeSelector`.
  ///
  /// The default value is `50.0`.
  ///
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   height: 35.0,
  ///   // other properties
  /// );
  /// ```
  final double height;

  /// The width for the each option (from [options]).
  ///
  /// The default value is:
  /// ```dart
  /// constraints.maxWidth / 3.5; // constraints is a instance of BoxConstraints
  /// ```
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   separatorWidth: 5.0,
  ///   // other properties
  /// );
  /// ```
  final double? optionWidth;

  /// This function defines a label for every option (from [options]).
  /// The default value is [value].
  /// Example of usage:
  /// ```dart
  /// TypeSelector<String>(
  ///   setValueLabel: (String value) {
  ///       value.substring(0, 1); // for each option, the value label will be the first letter
  ///   },
  ///   // other properties
  /// );
  /// ```
  final String Function(T value)? setValueLabel;

  /// The `style` for the `value label`.
  /// The default value is:
  /// ```dart
  /// TextStyle(color: Colors.white)
  /// ```
  final TextStyle? valueLabelStyle;

  /// The active [Color] of the `TypeSelector`.
  /// Is displayed when an option is `selected`.
  /// The default value is:
  /// ```dart
  /// Theme.of(context).accentColor;
  /// ```
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   activeColor: Colors.amber,
  ///   // other properties
  /// );
  /// ```
  final Color? activeColor;

  /// The disabled [Color] of the `TypeSelector`.
  /// Is displayed when an option is `not selected`.
  /// The default value is:
  /// ```dart
  /// Theme.of(context).disabledColor;
  /// ```
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   disabledColor: Colors.grey,
  ///   // other properties
  /// );
  /// ```
  final Color? disabledColor;

  /// This is a inner variable to control the shape of `TypeSelector`.
  /// The default value is `8.0` and provides a rounded corner shape.
  /// A constructor called [rect] provides a rect corner shape.
  final double _borderRadius;

  /// The default comparation for obtain selected value uses the `==` operator.
  /// But when working with objects, this method don't will work properly.
  /// Using this function, it's possible set how the comparation supose to be.
  /// Example of usage:
  /// ```dart
  /// TypeSelector(
  ///   comparingBy: (obj) => obj.id,
  ///   // other properties
  /// );
  /// ```
  final dynamic Function(T value)? comparingBy;
  final bool allCurved;

  /// The default [TypeSelector] constructor that render a [rounded corner] `TypeSelector`.
  /// * options: `It's required`;
  /// * multiple: Default is `false`;
  /// * value: `It's required if [multiple] flag is false`;
  /// * onValueChanged: `It's required if [multiple] flag is false`;
  /// * values: `It's required if [multiple] flag is true`;
  /// * onValuesChanged: `It's required if [multiple] flag is true`;
  /// * onMaxQuantityValues: `It's optional`;
  /// * transitionDuration: Default is `Duration(milliseconds: 250)`;
  /// * contentPadding: Default is `EdgeInsets.all(8.0)`;
  /// * valueLabelOverflow: Default is `TextOverflow.clip`;
  /// * toggleOptionOnTap: Default is `false`;
  /// * separatorWidth: Default is `2.0`;
  /// * height: Default is `50.0`;
  /// * optionWidth: Default is `constraints.maxWidth / 3.5`;
  /// * setValueLabel: Default is [value];
  /// * valueLabelStyle: Default is `TextStyle(color: Colors.white)`;
  /// * activeColor: Default is `Theme.of(context).accentColor`;
  /// * comparingBy: Default is `==`;
  DaysSelector(
      {super.key, required this.options,
      this.multiple = false,
      value,
      onValueChanged,
      values,
      onValuesChanged,
      maxQuantityValues,
      onMaxQuantityValues,
      this.transitionDuration = const Duration(milliseconds: 250),
      this.contentPadding = const EdgeInsets.all(8.0),
      this.valueLabelOverflow = TextOverflow.clip,
      this.toggleOptionOnTap = false,
      this.separatorWidth = 2.0,
      this.height = 50.0,
      this.optionWidth,
      this.setValueLabel,
      this.valueLabelStyle,
      this.activeColor,
      this.disabledColor,
      this.comparingBy,
      this.allCurved = false})
      : value = multiple ? null : value,
        onValueChanged = multiple ? null : onValueChanged,
        values = multiple ? values ?? [] : null,
        onValuesChanged = multiple ? onValuesChanged : null,
        maxQuantityValues =
            multiple ? maxQuantityValues ?? options.length : null,
        onMaxQuantityValues = multiple ? onMaxQuantityValues : null,

        /// Set shape to a [rounded corner].
        _borderRadius = 8.0,

        /// Assert [options] list contains at least 2 elements.
        assert(options.length >= 2,
            "The 'options' list must contain at least 2 elements");

  /// The default [TypeSelector] constructor that render a [rect corner] `TypeSelector`.
  /// * options: `It's required`;
  /// * multiple: Default is `false`;
  /// * value: `It's required if [multiple] flag is false`;
  /// * onValueChanged: `It's required if [multiple] flag is false`;
  /// * values: `It's required if [multiple] flag is true`;
  /// * onValuesChanged: `It's required if [multiple] flag is true`;
  /// * onMaxQuantityValues: `It's optional`;
  /// * transitionDuration: Default is `Duration(milliseconds: 250)`;
  /// * contentPadding: Default is `EdgeInsets.all(8.0)`;
  /// * valueLabelOverflow: Default is `TextOverflow.clip`;
  /// * toggleOptionOnTap: Default is `false`;
  /// * separatorWidth: Default is `2.0`;
  /// * height: Default is `50.0`;
  /// * optionWidth: Default is `constraints.maxWidth / 3.5`;
  /// * setValueLabel: Default is [value];
  /// * valueLabelStyle: Default is `TextStyle(color: Colors.white)`;
  /// * activeColor: Default is `Theme.of(context).accentColor`;
  /// * comparingBy: Default is `==`;
  DaysSelector.rect(
      {super.key, required this.options,
      this.multiple = false,
      value,
      onValueChanged,
      values,
      onValuesChanged,
      maxQuantityValues,
      onMaxQuantityValues,
      this.transitionDuration = const Duration(milliseconds: 250),
      this.contentPadding = const EdgeInsets.all(8.0),
      this.valueLabelOverflow = TextOverflow.clip,
      this.toggleOptionOnTap = false,
      this.separatorWidth = 2.0,
      this.height = 30.0,
      this.optionWidth,
      this.setValueLabel,
      this.valueLabelStyle,
      this.activeColor,
      this.disabledColor,
      this.comparingBy,
      this.allCurved = false})
      : value = multiple ? null : value,
        onValueChanged = multiple ? null : onValueChanged,
        values = multiple ? values ?? [] : null,
        onValuesChanged = multiple ? onValuesChanged : null,
        maxQuantityValues =
            multiple ? maxQuantityValues ?? options.length : null,
        onMaxQuantityValues = multiple ? onMaxQuantityValues : null,

        /// Set shape to a [rect corner].
        _borderRadius = 8.0,

        /// Assert [options] list contains at least 2 elements.
        assert(options.length >= 2,
            "The 'options' list must contain at least 2 elements");

  Color _getActiveColor(ctx) => this.activeColor ?? Theme.of(ctx).primaryColor;

  Color _getDisabledColor(ctx) =>
      this.disabledColor ?? Theme.of(ctx).disabledColor;

  BorderRadius? _getBorderRadius(index) {
    if (allCurved) {
      return BorderRadius.all(Radius.circular(_borderRadius));
    } else {
      if (index == 0) {
        return BorderRadius.only(
          topLeft: Radius.circular(_borderRadius),
          bottomLeft: Radius.circular(_borderRadius),
        );
      } else if (index == options.length - 1) {
        return BorderRadius.only(
          topRight: Radius.circular(_borderRadius),
          bottomRight: Radius.circular(_borderRadius),
        );
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            separatorBuilder: (_, __) => separatorWidth == 0.0
                ? Container()
                : SizedBox(
                    height: constraints.maxHeight,
                    width: separatorWidth,
                  ),
            itemBuilder: (context, index) =>
                _buildOption(context, constraints, index),
          );
        },
      ),
    );
  }

  bool equality(value, itemValue) {
    try {
      if (comparingBy == null) {
        if (multiple) {
          return values!.contains(itemValue);
        }
        return value == itemValue;
      }

      if (multiple) {
        return values!.any(comparingBy!(itemValue));
      }

      return comparingBy!(value) == comparingBy!(itemValue);
    } catch (e) {
      return false;
    }
  }

  Widget _buildOption(
      BuildContext context, BoxConstraints constraints, int index) {
    final itemValue = options[index];

    return InkWell(
      onTap: () {
        if (equality(value, itemValue) && (multiple || toggleOptionOnTap)) {
          if (multiple) {
            values!.remove(itemValue);
            onValuesChanged!(values!);
          } else {
            onValueChanged!(null);
          }
        } else {
          if (multiple) {
            if (maxQuantityValues! > values!.length) {
              values!.add(itemValue);
              onValuesChanged!(values!);
            } else {
              onMaxQuantityValues!(maxQuantityValues!);
            }
          } else {
            onValueChanged!(itemValue);
          }
        }
      },
      child: AnimatedContainer(
        duration: this.transitionDuration,
        width: this.optionWidth ?? constraints.maxWidth / 3.5,
        height: 20,
        padding: this.contentPadding,
        decoration: BoxDecoration(
          color: equality(value, itemValue)
              ? _getActiveColor(context)
              : _getDisabledColor(context),
          borderRadius: _getBorderRadius(index),
        ),
        child: Center(
          child: Text(
            setValueLabel == null
                ? itemValue.toString()
                : setValueLabel!(itemValue),
            textAlign: TextAlign.center,
            overflow: valueLabelOverflow,
            style: this.valueLabelStyle ?? const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
