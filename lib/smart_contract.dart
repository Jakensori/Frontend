import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:temp_project/sc_controller.dart';
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
  static const privateKey =
      '1d7d0686cfe9d41badc4d6b676de0f9ed2ada49137c9048339f13874df9f882e';
  final EthPrivateKey _credentials = EthPrivateKey.fromHex(privateKey);

  //스마트 컨트랙트의 주소 값
  static final EthereumAddress contractAddr =
      EthereumAddress.fromHex('0xB6Ebd7f29D5BbF9C3Dc6245450dAd49fEba2C25b');
  DeployedContract? _contract;

  // 스마트 컨트랙트 내의 함수 정의
  ContractFunction? _incrementFunction;
  ContractFunction? _decrementFunction;
  ContractFunction? _checkFunction;

  BigInt _check = BigInt.from(0);

  @override
  void initState() {
    super.initState();
    // ABI 파일 가져오기
    readAbi().then((String value) {
      // ABI를 이용해서 함수 정의
      _contract = DeployedContract(
          ContractAbi.fromJson(value, 'NaeggiDonation'), contractAddr);
      //print('확인: ${_contract!.address}');
      //_incrementFunction = _contract?.;
      _checkFunction = _contract?.function('check');
      // 값 현재값 가져오기
      _getCheck();
    });
  }

  Future<String> readAbi() async {
    return await rootBundle.loadString('assets/abi.json');
  }

  Future<void> _getCheck() async {
    await _client.call(
        contract: _contract!,
        function: _checkFunction!,
        params: []).then((result) {
      setState(() {
        print(result);
        _check = BigInt.from(result.first);
        print(_check);
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
        parameters: [BigInt.from(0.00079)],
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('0.002 ETH가', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 15.0),

                  Text('기부단체에 전달됩니다', style: TextStyle(fontSize: 20.0)),
                  // 값을 추가하는 함수
                  // IconButton(
                  //   icon: const Icon(Icons.add),
                  //   onPressed: _incrementCounter,
                  // ),
                  Text('$_check'),
                ],
              ),
              // 현재 값을 확인하는 버튼
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('기부금 전달', style: TextStyle(fontSize: 17.0)),
                onPressed: () {
                  //Future<double?> ether = EtherProvider().getEther(15000);
                  _incrementCounter();
                  _getCheck();
                },
              )
            ],
          ),
        ));
  }
}
