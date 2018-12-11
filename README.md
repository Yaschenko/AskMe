
# AskMe

## Description:

## Rinkeby Address:

## Main Net Address:

## API:
### askQuestion(string reciver, string question, string configs) public payable
### answerQuestion(uint id, string sender, address user, address payoutAddress, string text, string config) public onlyManager
### rejectQuestion(uint id, string sender, address user) public onlyManager

## Events
### DidSendQuestionEvent(uint id, address sender, string reciver, string question, string configs, uint payout);
### DidAswerQuestionEvent(uint id, string sender, address reciver, address payoutAddress, string answer, string configs);
### DidRejectQuestionEvent(uint id, string sender, address user);
