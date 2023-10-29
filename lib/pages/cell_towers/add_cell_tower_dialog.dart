import 'package:flutter/material.dart';

class AddCellDialog extends StatelessWidget {
  const AddCellDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: ,
      content: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "mcc"),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "mnc"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "lac"),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "cid"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "lat"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "long"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "radiusInMeters"),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "networkType"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.grey,
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: 12,
              ),
              MaterialButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: const Text('Add'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
