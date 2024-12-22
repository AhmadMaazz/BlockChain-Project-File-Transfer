// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7 <0.9.0;

contract Upload{
    struct Access{
        address user;
        bool access;
    }

    mapping(address=>string[]) value; //to store the url
    mapping(address=>mapping(address=>bool)) ownership; //to give ownership
    mapping(address=>Access[]) accessList; //to give ownership again
    mapping(address=>mapping(address=>bool)) previousData; //to give ownership

    function add(address _user,string memory url) external {
      value[_user].push(url);
    }

    function allow(address user) external {//def
        ownership[msg.sender][user]=true; 
        if(previousData[msg.sender][user]){
            for(uint i=0;i<accessList[msg.sender].length;i++){
                if(accessList[msg.sender][i].user==user){
                    accessList[msg.sender][i].access=true; 
                }
            }
        }else{
            accessList[msg.sender].push(Access(user,true));  
            previousData[msg.sender][user]=true;  
        }
        
    }
    function disallow(address user) public{
        ownership[msg.sender][user]=false;
        for(uint i=0;i<accessList[msg.sender].length;i++){
            if(accessList[msg.sender][i].user==user){ 
                accessList[msg.sender][i].access=false;  
            }
        }
    }

    function display(address _user) external view returns(string[] memory){
        require(_user==msg.sender || ownership[_user][msg.sender],"You don't have access");
        return value[_user];
    }

    function shareAccess() public view returns(Access[] memory){
        return accessList[msg.sender];
    }

}

//0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0