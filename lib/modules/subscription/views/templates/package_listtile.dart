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
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$price€',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '$durationString',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
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
    this.pressed,
  }) : super(key: key);

  final Widget thumbnail;
  final String name;
  final String description;
  final String price;
  final String durationTime;
  final String durationString;
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
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
              ElevatedButton(
                onPressed: pressed,
                style: ElevatedButton.styleFrom(primary: Colors.green),
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
