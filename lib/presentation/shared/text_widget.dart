import 'package:flutter/material.dart';

class BaseTitle extends StatelessWidget {
  BaseTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.fade,
      maxLines: 2,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w200),
    );
  }
}

class BodyText extends StatelessWidget {
  BodyText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: null,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}