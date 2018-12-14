
# AskMe

## Description:

## Rinkeby Address:
### 0x82081931c62080b04462b0ba89ba43500cc0f2fa

## Main Net Address:

## API:
### askQuestion
- fn: askQuestion(string reciver, string question, string configs) public payable
- params:
  - reciver : string
  - question : string
  - configs : string(optional)
  
### answerQuestion
- fn: answerQuestion(uint id, string sender, address user, address payoutAddress, string text, string config) public onlyManager
- params:
  - id : uint
  - sender : string
  - user : address
  - payoutAddress : address - who should get money for answer
  - text : string
  - config : string(optional)
  
### rejectQuestion
- fn: rejectQuestion(uint id, string sender, address user) public onlyManager
- params:
  - id : uint
  - sender : string
  - user : address
- remarks: if user rejected question, all profit automatically moves to the questioner(user)

## Events
### DidSendQuestionEvent(uint id, address sender, string reciver, string question, string configs, uint payout);
### DidAswerQuestionEvent(uint id, string sender, address reciver, address payoutAddress, string answer, string configs);
### DidRejectQuestionEvent(uint id, string sender, address user);