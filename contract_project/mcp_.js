let Mcp = require("mcp.js")
// let mcp = new Mcp();    // Use by default 127.0.0.1:8765

// If you want to modify the node IP address and port, please set the following
// Example
const options = {
    host: "18.182.45.18",
    port: 8765
}
let mcp = new Mcp(options)

// Now you can use the mcp object
// Example
// mcp.request.status().then(function (res) {
//     console.log(`status`, res);
// }).catch(function (error) {
//     console.log("accountList catch", error)
// })

const receiver = "0x673E3eBEE1a29B6Dd721f18A473056C5Cf960Adc"
mcp.request.accountBlockList(receiver, limit = 2).then(function (result) {
    console.log(result) // "Some User token"
})
//console.log('1111')

const MyContract = require('./artifacts/contracts/Election.sol/Election.json')

let myContract = new mcp.Contract(MyContract.abi, '0x5FbDB2315678afecb367f032d93F642f64180aa3')
// myContract.methods.candidatesCount.call().then(data => {
//     console.log('testCall1 data', data)
// }).catch(function (error) {
//     console.log('error', error)
// });

// console.log(myContract.methods.candidatesCount().call({ from: "0x673E3eBEE1a29B6Dd721f18A473056C5Cf960Adc" }))