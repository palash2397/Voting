pragma solidity ^0.8.7;

contract voting {
    struct votes{
        address candidate;
        mapping(address=>bool) voters;
        uint voteCount;
        bool active;
    }
    address[] candidates;
    mapping(address => votes) Candidates;
    
    function registerCandidate () public returns(bytes32) {
       require(Candidates[msg.sender].candidate == address(0), "Already Registered");
       candidates.push(msg.sender);
       Candidates[msg.sender].candidate = msg.sender;
       Candidates[msg.sender].voteCount = 0;
       Candidates[msg.sender].active = true;
       return "Register Successful";
        
    }
    
    function castVote (address _candidate) public {
       require(Candidates[_candidate].active = true, "Candidate Not Registered");
       require(msg.sender != _candidate, "Self Cast in not allowed");
       Candidates[_candidate].voters[msg.sender] = true;
       Candidates[_candidate].voteCount += 1;
    }
     
    function winner() view public returns (address){
        address winnerCandidate;
        uint maxVotes = 0;
        for(uint i = 0; i< candidates.length; i++){
            if ( maxVotes <  Candidates[candidates[i]].voteCount){
                maxVotes =  Candidates[candidates[i]].voteCount;
                winnerCandidate = candidates[i];
            }
        }
        return winnerCandidate;
    }
    function removeVote() public {
        for(uint i = 0; i< candidates.length; i++){
            if(Candidates[candidates[i]].voters[msg.sender] = true){
                Candidates[candidates[i]].voters[msg.sender] = false;
                Candidates[candidates[i]].voteCount -= 1;
            }
        }
    }

}