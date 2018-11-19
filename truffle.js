var HDWalletProvider = require("truffle-hdwallet-provider");
var PrivateKeyProvider = require("truffle-privatekey-provider");
const mnemonic = process.env.MNEMONIC
const fromAddress = process.env.FROM_ADDRESS

module.exports = {
  networks: {
    local: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "5777",
      from: "0x32137f2A13eA73d5Fc45881565Fcf7Ed00c21eaf".toLowerCase(),
      gasPrice: 11000000000
    },
    development: {
      host: "localhost",
      port: 8501,
      network_id: "*", 
      gasprice: 1
    },
    rinkeby: {
      provider : () => new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/3vj9Xnohf6SSZo69i0aH"), // TODO: change with our own node addres
      from: fromAddress.toLowerCase(),
      network_id: "4",
      gas: 6712390
    },   
    rinkeby1: {
      provider : () => new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/3vj9Xnohf6SSZo69i0aH", 1), // TODO: change with our own node addres
      from: "0x2Fb2bb7ca4C2bF0203D844CA1b7705E24C2c3ec9".toLowerCase(),
      network_id: "4",
      gas: 6712390,
      gasPrice: 10000000000
    }, 
    main: {
      provider : () => new HDWalletProvider(mnemonic, "https://mainnet.infura.io/3vj9Xnohf6SSZo69i0aH"), // TODO: change with our own node addres
      from: fromAddress.toLowerCase(),
      network_id: "1",
    },
    mainp: {
      provider : () => new PrivateKeyProvider(mnemonic, "https://mainnet.infura.io/3vj9Xnohf6SSZo69i0aH"), // TODO: change with our own node addres
      from: fromAddress.toLowerCase(),
      network_id: "1",
      gasPrice: 10000000000
    }
  }
};