import 'package:flutter/material.dart';
import 'package:live_football_stats/core/utils/common_method.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClientService {
  WebSocketClientService();
  WebSocketChannel? channel;
  Stream<dynamic> get stream => channel!.stream;
  void connect({
    required String url,
    Map<String, dynamic>? headers,
  }) {
    if (channel != null && channel!.closeCode == null) {
      debugPrint('Already connected');
      return;
    }
    String newURL =
        "https://api.soccerdataapi.com:443/livescores?auth_token=370dcc1f3289b2729a02b84b444a637392705730";
    String wssUrl = CommonMethods.convertHttpToWS(newURL);
    debugPrint('Connecting to the server with url ${wssUrl}...');
    final uri = Uri.parse(wssUrl);
    print(uri);
    channel = WebSocketChannel.connect(
      uri,
    );
  }

  void disconnect() {
    if (channel == null || channel!.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    channel?.sink.close();
  }

  void reconnect({required String url, Map<String, dynamic>? headers}) {
    disconnect();
    connect(url: url, headers: headers);
  }
}
