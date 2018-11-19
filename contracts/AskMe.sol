pragma solidity ^0.4.18;

import "./Ownable.sol";
import "./SafeMath.sol";

contract AskMe is Ownable {
    //libs
    using SafeMath for uint;
    //events
    event DidSendQuestionEvent(uint id, address sender, string reciver, string question, string configs, uint payout);
    event DidAswerQuestionEvent(uint id, string sender, address reciver, string answer, string configs);
    //
    address private manager;
    uint private questionsCount;
    uint private fee = 0.0 ether;
    uint private minimumProfit = 0.0 ether;

    constructor() public {
        manager = msg.sender;
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
    function askQuestion(string reciver, string question, string configs) public payable {
        require(msg.value > fee);
        questionsCount += 1;
        emit DidSendQuestionEvent(questionsCount, msg.sender, reciver, question, configs, msg.value);
    }

    function answerQuestion(uint id, string sender, address user, string text, string config) public onlyManager {
        emit DidAswerQuestionEvent(id, sender, user, text, config);
    }
    
}