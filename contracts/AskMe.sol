pragma solidity ^0.4.18;

import "./Ownable.sol";
import "./SafeMath.sol";

contract AskMe is Ownable {
    //libs
    using SafeMath for uint;
    //events
    event DidSendQuestionEvent(uint id, address sender, address reciver, string question, string configs, uint payout);
    event DidAswerQuestionEvent(uint id, address reciver, address sender, uint payout, string answer, string configs);
    event DidFreeAswerQuestionEvent(uint id, address reciver, address sender, uint payout, string answer, string configs);
    event DidRejectQuestionEvent(uint id, address reciver, address sender);
    event DonatedQuestion(uint id, address user, uint amount);
    //
    struct QuestionObject {
        address reciver;
        address sender;
        uint payout;
    }
    address private manager;
    // uint private questionsCount;
    uint private minimumFee = 0.0 ether;
    uint private fee = 1000;//1000 == 1%
    uint private minimumProfit = 0.0 ether;
    
    QuestionObject[] private questions;
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
    function getMinimumFee() public view returns(uint) {
        return minimumFee;
    }
    function setMinimumFee(uint minFee) public onlyOwner {
        minimumFee = minFee;
    }
    //
    function calculateFee(uint value) private view returns(uint) {
        uint feeValue = value.mul(fee).div(100000);
        if (feeValue > minimumFee) {
            return feeValue;
        } else {
            return minimumFee;
        }
    }

    function askQuestion(address reciver, string question, string configs) public payable returns(uint) {
        uint feeValue = calculateFee(msg.value);
        require(msg.value >= feeValue.add(minimumProfit));
        owner.transfer(feeValue);
        uint payout = msg.value.sub(feeValue);
        QuestionObject memory questionData = QuestionObject(reciver, msg.sender, payout);
        uint index = questions.push(questionData) - 1;
        emit DidSendQuestionEvent(index, msg.sender, reciver, question, configs, payout);
        return index;
    }

    function answerQuestion(uint id, string text, string config) public onlyManager {
        QuestionObject storage questionData = questions[id];
        require(questionData.payout > 0);
        uint payout = questionData.payout;
        questionData.payout = 0;
        
        questionData.reciver.transfer(payout);
        emit DidAswerQuestionEvent(id, questionData.reciver, questionData.sender, payout, text, config);
    }

    function freeAnswerQuestion(uint id, string text, string config) public onlyManager {
        QuestionObject storage questionData = questions[id];
        require(questionData.payout > 0);
        uint payout = questionData.payout;
        questionData.payout = 0;
        
        questionData.sender.transfer(payout);
        emit DidFreeAswerQuestionEvent(id, questionData.reciver, questionData.sender, payout, text, config);
    }
    function rejectQuestion(uint id) public onlyManager {
        QuestionObject storage questionData = questions[id];
        require(questionData.payout > 0);
        uint payout = questionData.payout;
        questionData.payout = 0;
        questionData.sender.transfer(payout);
        emit DidRejectQuestionEvent(id, questionData.sender, questionData.reciver);
    }
    function donateQuestion(uint id) public payable {
        uint feeValue = calculateFee(msg.value);
        require(msg.value > feeValue);
        QuestionObject storage questionData = questions[id];
        require(questionData.payout > 0);
        owner.transfer(fee);
        uint userProfit = msg.value.sub(feeValue);
        questionData.payout = questionData.payout.add(userProfit);
        emit DonatedQuestion(id, msg.sender, userProfit);
    }
    // function cancelQuestion()
}