pragma solidity ^0.4.18;

import "./Ownable.sol";
import "./SafeMath.sol";

contract AskMe is Ownable {
    //libs
    using SafeMath for uint;
    //events
    event DidSendQuestionEvent(uint id, address sender, string reciver, string question, string configs, uint payout);
    event DidAswerQuestionEvent(uint id, string sender, address reciver, address payoutAddress, string answer, string configs);
    event DidRejectQuestionEvent(uint id, string sender, address user);
    event DonatedQuestion(uint id, address user, uint amount);
    //
    address private manager;
    uint private questionsCount;
    uint private fee = 0.0 ether;
    uint private minimumProfit = 0.0 ether;
    // mapping(uint => uint) private payouts;
    uint[] private payouts;
    constructor() public {
        // manager = msg.sender;
        manager = 0x115bCe73559ffcbd5A6374C988B8502C90E17273;
    }

    modifier onlyManager() {
        require(msg.sender == manager);
        _;
    }


    function () public payable {
        owner.transfer(msg.value);
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }
    //managers
    function setManager(address newManager) public onlyOwner {
        require(newManager != 0x0);
        manager = newManager;
    }
    function getManager() public view returns(address) {
        return manager;
    }
    function setFee(uint newFee) public onlyOwner {
        fee = newFee;
    }
    function getFee() public view returns(uint) {
        return fee;
    }
    function getMinimumProfit() public view returns(uint) {
        return minimumProfit;
    }
    function setMinimumProfit(uint profit) public onlyOwner {
        minimumProfit = profit;
    }
    //
    function askQuestion(string reciver, string question, string configs) public payable returns(uint) {
        require(msg.value > fee.add(minimumProfit));
        owner.transfer(fee);
        uint index = payouts.push(msg.value.sub(fee));
        emit DidSendQuestionEvent(index, msg.sender, reciver, question, configs, payouts[index]);
        return index;
    }

    function answerQuestion(uint id, string sender, address user, address payoutAddress, string text, string config) public onlyManager {
        require(payouts[id] > 0);
        uint payout = payouts[id];
        payouts[id] = 0;
        payoutAddress.transfer(payout);
        emit DidAswerQuestionEvent(id, sender, user, payoutAddress, text, config);
    }
    function rejectQuestion(uint id, string sender, address user) public onlyManager {
        require(payouts[id] > 0);
        uint payout = payouts[id];
        payouts[id] = 0;
        user.transfer(payout);
        emit DidRejectQuestionEvent(id, sender, user);
    }
    function donateQuestion(uint id) public payable {
        require(msg.value > fee);
        require(payouts[id] > 0);
        owner.transfer(fee);
        uint userProfit = msg.value.sub(fee);
        payouts[id] = payouts[id].add(userProfit);
        emit DonatedQuestion(id, msg.sender, userProfit);
    }
    // function cancelQuestion()
}