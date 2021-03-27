import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class contractLinking {
  final String _rpcUrl = "";
  final String _wsUrl = "";
  final String _privateKey = "";

  //private inits
  Web3Client _client;
  String _abiCode;
  EthereumAddress _ethAddress;
  Credentials _creds;
  DeployedContract _contract;
  ContractFunction _makePurchase;
  ContractFunction _getBalance;

  contractLinking() {
    init();
  }

  init async () {

  }

  // Load the rpc node


  // Get Deployed smart contract

  

}
