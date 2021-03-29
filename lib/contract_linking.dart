import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

// State management
class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "HTTP://127.0.0.1:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "6a2aab1e0b61307fd88246b14355d256cd707169bae4bb39e7ebc2510461db9c";

  // private client for web3dart
  Web3Client _client;
  bool isLoading = true;
  // Eth related variable declarations
  String _abiCode;
  EthereumAddress _contractAddress;
  Credentials _credentials;
  DeployedContract _contract;
  ContractFunction _addFunds;
  ContractFunction _getBalance;
  ContractFunction _makePurchase;
  var balance;

  // No-args constructor
  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    // Setup connection between eth rpc node & dApp
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
        await rootBundle.loadString("build/contracts/Purchase.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  // From the blockchain to the dap
  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Purchase"), _contractAddress);

    // Extracting the functions, declared in contract.
    _addFunds = _contract.function("addFunds");
    _makePurchase = _contract.function("makePurchase");
    _getBalance = _contract.function("getBalance");
    getBalance();
  }

  // Executing actual smart contract logic
  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final result = await _client.call(
        contract: _contract,
        function: _contract.function(functionName),
        params: args);

    return result;
  }

  getBalance() async {
    // Getting the current name declared in the smart contract.
    var currentBalance = await _client
        .call(contract: _contract, function: _getBalance, params: []);
    balance = currentBalance[0];
    isLoading = false;
    notifyListeners();
    return balance;
  }

  addFunds(String add) async {
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _contract.function("addFunds"),
            parameters: [add]));
  }

  // Creating smart contract logic
  makePurchase(String sale) async {
    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _makePurchase, parameters: [sale]));
    getBalance();
  }
}
