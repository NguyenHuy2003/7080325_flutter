import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebSocketLed(),
    );
  }
}

//apply this class on home: attribute at MaterialApp()
class WebSocketLed extends StatefulWidget {
  const WebSocketLed({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebSocketLed();
  }
}

class _WebSocketLed extends State<WebSocketLed> {
  late bool ledstatus; //boolean value to track LED status, if its ON or OFF
  late IOWebSocketChannel channel;
  late bool connected; //boolean value to track if WebSocket is connected

  @override
  void initState() {
    ledstatus = false; //initially leadstatus is off so its FALSE
    connected = false; //initially connection status is "NO" so its FALSE

    Future.delayed(Duration.zero, () async {
      channelconnect(); //connect to WebSocket wth NodeMCU
    });

    super.initState();
  }

  channelconnect() {
    //function to connect
    try {
      channel =
          IOWebSocketChannel.connect("ws://192.168.0.1:81"); //channel IP : Port
      channel.stream.listen(
        (message) {
          print(message);
          setState(() {
            if (message == "connected") {
              connected = true; //message is "connected" from NodeMCU
            } else if (message == "poweron:success") {
              ledstatus = true;
            } else if (message == "poweroff:success") {
              ledstatus = false;
            }
          });
        },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendcmd(String cmd) async {
    if (connected == true) {
      if (ledstatus == false && cmd != "poweron" && cmd != "poweroff") {
        print("Send the valid command");
      } else {
        channel.sink.add(cmd); //sending Command to NodeMCU
      }
    } else {
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("LED - ON/OFF NodeMCU"),
          backgroundColor: Colors.redAccent),
      body: Container(
          alignment: Alignment.topCenter, //inner widget alignment to center
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child: connected
                      ? const Text("WEBSOCKET: CONNECTED")
                      : const Text("DISCONNECTED")),
              Container(
                  child: ledstatus
                      ? const Text("LED IS: ON")
                      : const Text("LED IS: OFF")),
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: TextButton(
                      //button to start scanning
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        //on button press
                        if (ledstatus) {
                          //if ledstatus is true, then turn off the led
                          //if led is on, turn off
                          sendcmd("poweroff");
                          ledstatus = false;
                        } else {
                          //if ledstatus is false, then turn on the led
                          //if led is off, turn on
                          sendcmd("poweron");
                          ledstatus = true;
                        }
                        setState(() {});
                      },
                      child: ledstatus
                          ? const Text("TURN LED OFF")
                          : const Text("TURN LED ON")))
            ],
          )),
    );
  }
}
