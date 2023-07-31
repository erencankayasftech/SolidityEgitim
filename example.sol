// SPDX-License-Identifier: MIT


/*
Name: NFT adı,

MetaData kısmında 2 tane hesap ekliyoruz. 1.hesap sender, 2.hesap receiver

Value alanına yazdığımız setPrice fonk çağırarak price parametresinin değerine eşitliyoruz.

Calldata alanında transacta tıklayarak hesaplarımızı payable yapıyoruz.

payNFT fonk tıklayarak 1.hesaptan 2.hesaba ether geçişini yapıyoruz.


*/


pragma solidity ^0.8.0;

contract Main {

     string  Name;

    function addName(string memory _name)public{

        Name = _name;
    }

    
    function getName()public view returns(string memory _names){

        return Name;
    }
//Metadata
     struct Balance{
        address Adress;
        
    }

    Balance [] public balanceList;
    uint totalStudent = 0;
    mapping  (uint => Balance) _balance;

    function addMetaData(address _adress) public { 

        Balance memory balance;
        balance.Adress = _adress;        
        balanceList.push(balance);
    }

  function getMetaDataInfo(uint id)public view returns(address){

    return balanceList[id].Adress;
}

    //Price
    uint public amount;

    mapping(address => uint ) balances;

    function setPrice() payable external {
        
        balances[msg.sender] = msg.value;        
    }

    function showPrice() external  view returns(uint)  {
        return balances[msg.sender];
    }
    modifier checkName(){
        require(bytes(Name).length == 0,"Name is required.");
        _;
    }
    modifier metaData(){
        require(balanceList.length == 0,"MetaData accounts is required.");
        _;
    }
    function payNFT() external checkName metaData{
      
        address payable to = payable(balanceList[1].Adress);  
        to.transfer(balances[msg.sender]);
        balances[to] += (balances[msg.sender] * 6) / 10;
        balances[msg.sender] -= (balances[msg.sender] *4)/10;
    }

   
    
    receive() external payable {
        
    }

    fallback() external payable {
        
    }
  function review()public view returns(string memory , address , uint ){
      string memory _name = getName();
      address to = msg.sender;
      uint price = balances[msg.sender];
      return  (_name,to,price);
    }
}






