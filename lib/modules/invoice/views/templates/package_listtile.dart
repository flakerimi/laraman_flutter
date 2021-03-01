import 'package:flutter/material.dart';

class PackageListTile extends StatelessWidget {
  PackageListTile({
    Key key,
    this.name,
    this.description,
    this.price,
    this.durationTime,
    this.durationString,
  }) : super(key: key);

  final String name;
  final String description;
  final String price;
  final String durationTime;
  final String durationString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$name',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$price',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$durationTime - $durationString',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PackageList extends StatelessWidget {
  PackageList({
    Key key,
    this.thumbnail,
    this.name,
    this.description,
    this.price,
    this.durationTime,
    this.durationString,
  }) : super(key: key);

  final Widget thumbnail;
  final String name;
  final String description;
  final String price;
  final String durationTime;
  final String durationString;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent.shade200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*  AspectRatio(
                aspectRatio: 1.0,
                child: thumbnail,
              ), */
              Expanded(
                child: PackageListTile(
                  name: name,
                  description: description,
                  price: price,
                  durationTime: durationTime,
                  durationString: durationString,
                ),
              ),
              RaisedButton(
                onPressed: () => {},
                color: Colors.grey.shade800,
                child: Text(
                  'Abonohu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
