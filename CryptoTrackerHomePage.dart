import 'package:flutter/material.dart';

class CryptoTrackerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crypto Tracker', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Top Gainers'),
                SizedBox(height: 16.0),
                _buildHorizontalListView(topGainersData),

                SizedBox(height: 32.0),
                _buildSectionTitle('Trending Coins'),
                SizedBox(height: 16.0),
                _buildHorizontalListView(trendingCoinsData),

                SizedBox(height: 32.0),
                _buildSectionTitle('All Coins'),
                SizedBox(height: 16.0),
                _buildAllCoinsListView(allCoinsData),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHorizontalListView(List<Map<String, String>> dataList) {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];
          return _buildCryptoCard(data['name']!, data['price']!, data['change']!);
        },
      ),
    );
  }

  Widget _buildAllCoinsListView(List<Map<String, String>> dataList) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final data = dataList[index];
        return _buildAllCoinsItem(data['name']!, data['price']!, data['change']!);
      },
    );
  }

  Widget _buildCryptoCard(String name, String price, String change) {
    return Container(
      width: 120.0,
      margin: EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            price,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            change,
            style: TextStyle(
              color: change.startsWith('+') ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllCoinsItem(String name, String price, String change) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(name[0], style: TextStyle(color: Colors.white)),
        ),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Text('$price', style: TextStyle(color: Colors.white)),
        trailing: Text(
          '$change%',
          style: TextStyle(
            color: change.startsWith('+') ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Sample Data
List<Map<String, String>> topGainersData = [
  {'name': 'BTC', 'price': '₹50,63,291', 'change': '+2.77%'},
  {'name': 'ETH', 'price': '₹3,63,291', 'change': '+1.34%'},
  {'name': 'ADA', 'price': '₹120', 'change': '+3.45%'},
];

List<Map<String, String>> trendingCoinsData = [
  {'name': 'DOGE', 'price': '₹19.12', 'change': '-0.23%'},
  {'name': 'XRP', 'price': '₹75.23', 'change': '+0.56%'},
  {'name': 'LTC', 'price': '₹5,000', 'change': '+4.12%'},
];

List<Map<String, String>> allCoinsData = [
  {'name': 'BTC', 'price': '₹50,63,291', 'change': '+2.77%'},
  {'name': 'ETH', 'price': '₹3,63,291', 'change': '+1.34%'},
  {'name': 'ADA', 'price': '₹120', 'change': '+3.45%'},
  {'name': 'DOGE', 'price': '₹19.12', 'change': '-0.23%'},
  {'name': 'XRP', 'price': '₹75.23', 'change': '+0.56%'},
  {'name': 'LTC', 'price': '₹5,000', 'change': '+4.12%'},
];
