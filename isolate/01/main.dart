//在父Isolate中调用
import 'dart:isolate';

void main() {
  start();
}

late Isolate isolate;

start() async {
  ReceivePort receivePort = ReceivePort();
  //创建子Isolate对象
  isolate = await Isolate.spawn(getMsg, receivePort.sendPort);
  //监听子Isolate的返回数据
  receivePort.listen((data) {
    print('data：$data');
    receivePort.close();
    //关闭Isolate对象
    isolate.kill(priority: Isolate.immediate);
  });
}

//子Isolate对象的入口函数，可以在该函数中做耗时操作
getMsg(sendPort) => sendPort.send("hello");
