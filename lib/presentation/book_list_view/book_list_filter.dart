import 'package:flutter/material.dart';

import '../shared/text_widget.dart';

class BookListFilter extends StatefulWidget {
  const BookListFilter({required this.switchFavorite, required this.onTimeCallback});

  final bool switchFavorite;
  final Function onTimeCallback;

  @override
  State<BookListFilter> createState() => _BookListFilterState();
}

class _BookListFilterState extends State<BookListFilter> {
  late bool switchFavorite;


  @override
  void initState() {
    super.initState();
    switchFavorite = widget.switchFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      height: 100,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          BaseTitle('Filters'),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LabelText('Show only favorites'),
              Switch(
                value: switchFavorite,
                onChanged: (it) {
                  setState(() {
                    switchFavorite = it;
                    widget.onTimeCallback(it);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
