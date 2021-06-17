import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ordertracking/model/item_model.dart';
import 'package:ordertracking/service/service.dart';
import 'package:ordertracking/theme/border_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Item>> _futureItem;
  @override
  void initState() {
    super.initState();
    _futureItem = OrderTracking().getItem();
    // print("Started");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
      ),
      body: RefreshIndicator(
        // color: Colors.red,
        backgroundColor: Colors.white,
        strokeWidth: 1,
        onRefresh: () async {
          _futureItem = OrderTracking().getItem();
          setState(() {});
        },
        child: FutureBuilder<List<Item>>(
          future: _futureItem,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext contex, int index) {
                  final item = items[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: getTagColor(item.tags.toString()),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 1),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            "${item.name}",
                          ),
                          Text(item.tags),
                          Text(item.qty.toString()),
                          Text(item.description),
                          Text(item.placeToDeliver.toString()),
                          Text(DateFormat("dd.MM ")
                              .format(item.time.toLocal())
                              .toString()),
                          Text(DateFormat("hh:mm a")
                              .format(item.time.toLocal())
                              .toString()),
                          Text(item.phone),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Container(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
