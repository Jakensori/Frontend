import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SmartContranct(title: 'Counter'),
    );
  }
}

class SmartContranct extends StatefulWidget {
  const SmartContranct({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SmartContranct> createState() => _SmartContranct();
}

class _SmartContranct extends State<SmartContranct> {
  //연결하려는 네트워크
  static const apiUrl =
      "https://sepolia.infura.io/v3/f49cf96589a248ddb26c8cdcc0a4e7a5";
  final Web3Client _client = Web3Client(apiUrl, Client());

  //지갑키
  static const privateKey = '0x8C219DfD7eAEDC50fC5A1fA5EeD20c2F51C195F3';
  final EthPrivateKey _credentials = EthPrivateKey.fromHex(privateKey);

  //스마트 컨트랙트의 주소 값
  static final EthereumAddress contractAddr =
      EthereumAddress.fromHex('0x2CAeC7ac505a4ECAaD6Dbb3706662612813F27b9');
  DeployedContract? _contract;

  // 스마트 컨트랙트 내의 함수 정의
  ContractFunction? _initializeFunction;
  ContractFunction? _incrementFunction;
  ContractFunction? _decrementFunction;
  ContractFunction? _getFunction;

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // ABI 파일 가져오기
    readAbi().then((String value) {
      // ABI를 이용해서 함수 정의
      _contract = DeployedContract(
          ContractAbi.fromJson(value, 'Counter'), contractAddr);
      _initializeFunction = _contract?.function('initialize');
      _incrementFunction = _contract?.function('increment');
      _decrementFunction = _contract?.function('decrement');
      _getFunction = _contract?.function('get');
      // 값 현재값 가져오기
      _getCounter();
    });
  }

  Future<String> readAbi() async {
    return await rootBundle.loadString('abi.json');
  }

  Future<void> _getCounter() async {
    await _client.call(
        contract: _contract!,
        function: _getFunction!,
        params: []).then((List result) {
      setState(() {
        _counter = result.first.toInt();
      });
    });
  }

  Future<void> _decrementCounter() async {
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract!,
        function: _decrementFunction!,
        parameters: [BigInt.from(1)],
      ),
      chainId: 3,
    );
  }

  Future<void> _incrementCounter() async {
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract!,
        function: _incrementFunction!,
        parameters: [BigInt.from(1)],
      ),
      chainId: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // 값을 내리는 함수
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementCounter, // null disables the button
                  ),
                  // Expanded expands its child to fill the available space.
                  Text(
                    '$_counter',
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                  // 값을 추가하는 함수
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementCounter,
                  ),
                ],
              ),
              // 현재 값을 확인하는 버튼
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: _getCounter,
              )
            ],
          ),
        ));
  }
}
