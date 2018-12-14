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
    //
    address private manager;
    uint private questionsCount;
    uint private fee = 0.0 ether;
    uint private minimumProfit = 0.0 ether;
    mapping(uint => uint) private payouts;
    constructor() public {
        // manager = msg.sender;
        manager = 0x115bCe73559ffcbd5A6374C988B8502C90E17273;
    }

    modifier onlyManager() {
        require(msg.sender == manager);
        _;
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
        questionsCount += 1;
        payouts[questionsCount] = msg.value.sub(fee);
        emit DidSendQuestionEvent(questionsCount, msg.sender, reciver, question, configs, payouts[questionsCount]);
        return questionsCount;
    }

    function answerQuestion(uint id, string sender, address user, address payoutAddress, string text, string config) public onlyManager {
        uint payout = payouts[id];
        payouts[id] = 0;
        payoutAddress.transfer(payout);
        emit DidAswerQuestionEvent(id, sender, user, payoutAddress, text, config);
    }
    function rejectQuestion(uint id, string sender, address user) public onlyManager {
        uint payout = payouts[id];
        payouts[id] = 0;
        user.transfer(payout);
        emit DidRejectQuestionEvent(id, sender, user);
    }
    // function cancelQuestion()
}