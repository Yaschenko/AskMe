
# AskMe

## Description:

## Rinkeby Address:
### 0xd5de5a14fa28c527d9054105813a9eba71a1a3b9
- fee: 1% 
- manager address: 0x115bCe73559ffcbd5A6374C988B8502C90E17273
### 0xad9acc7a65153d7f757fcc482f3c5d2fe4b405b3 - deprecated
### 0x82081931c62080b04462b0ba89ba43500cc0f2fa - deprecated

## Main Net Address:

## API:
### askQuestion
- fn: askQuestion(address reciver, string question, string configs) public payable
- params:
  - reciver : address
  - question : string
  - configs : string(optional)
  
### answerQuestion
- fn: answerQuestion(uint id, string text, string config) public onlyManager
- params:
  - id : uint
  - text : string
  - config : string(optional)

### freeAnswerQuestion
- fn: freeAnswerQuestion(uint id, string text, string config) public onlyManager
- params:
  - id : uint
  - text : string
  - config : string(optional)
  
### rejectQuestion
- fn: rejectQuestion(uint id) public onlyManager
- params:
  - id : uint
  - sender : string
  - user : address
- remarks: if user rejected question, all profit automatically moves to the questioner(user)

### donateQuestion
- fn: function donateQuestion(uint id) public payable 
- params:
  - id : uint


## Events
### event DidSendQuestionEvent(uint id, address sender, address reciver, string question, string configs, uint payout);
### event DidAswerQuestionEvent(uint id, address reciver, address sender, uint payout, string answer, string configs);
### event DidFreeAswerQuestionEvent(uint id, address reciver, address sender, uint payout, string answer, string configs);
### event DidRejectQuestionEvent(uint id, address reciver, address sender);
### event DonatedQuestion(uint id, address user, uint amount);