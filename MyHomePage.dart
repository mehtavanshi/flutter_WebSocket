//Code of Websockets
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String websocketUrl = 'ws://prereg.ex.api.ampiy.com/prices';
  late WebSocketChannel _webSocketChannel;
  List<Map<String, dynamic>> _coinDataList = [];

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    _webSocketChannel = WebSocketChannel.connect(Uri.parse(websocketUrl));
    _webSocketChannel.stream.listen((data) {
      _handleData(data);
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket connection closed');
    });
    _sendSubscriptionMessage();
  }

  void _sendSubscriptionMessage() {
    final message = jsonEncode({
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1,
    });
    _webSocketChannel.sink.add(message);
  }

  void _handleData(dynamic data) {
    final decodedData = jsonDecode(data);
    print('Received data: $decodedData'); // Debug print
    if (decodedData['stream'] == 'all@fpTckr') {
      setState(() {
        _coinDataList = List<Map<String, dynamic>>.from(decodedData['data']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crypto Tracker', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: _coinDataList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _coinDataList.length,
          itemBuilder: (context, index) {
            final data = _coinDataList[index];
            return ListTile(
              leading: _buildCryptoIcon(data['s']),
              title: Text(
                data['s'],
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '₹${data['c']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      '${data['p']}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: data['p'].contains('-') ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildCryptoIcon(String symbol) {
    Color color = _getColor(symbol);
    String firstCharacter = symbol[0];
    return CircleAvatar(
      backgroundColor: color,
      child: Text(
        firstCharacter,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Color _getColor(String symbol) {
    switch (symbol) {
      case 'BTCINR':
        return Colors.green;
      case 'ETHINR':
        return Colors.blue;
      default:
        return Colors.amberAccent;
    }
  }

  @override
  void dispose() {
    _webSocketChannel.sink.close();
    super.dispose();
  }
}
