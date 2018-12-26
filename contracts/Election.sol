pragma solidity ^0.5.0;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        address voterAddress;
    }

    mapping(uint => Candidate) public candidates;
    mapping(uint => Voter) public voters;

    uint public candidatesCount;
    uint public votersCount;

    address public constant adminUser = 0x73ead31f91FE56574792AbF60085A6b7a11614A0; 

    constructor() public {}

    /**
        Add candidate
    */
    function addCandidate(string memory _name) public returns(uint) {
        require(msg.sender == adminUser, "Only admin can add a candidate");
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        candidatesCount++;
        return candidatesCount;
    }

    /**
        Add a voter
    */
    function addVoter(address voterAddress) public returns(uint) {
        require(msg.sender == adminUser, "Only admin can add a voter");
        voters[votersCount] = Voter(voterAddress);
        votersCount++;
        return votersCount;
    }

    /**
        Voters vote
    */
    function voteACandidate(uint candidateId) public {
        bool isAVoter = false; 
        for(uint voterIdx = 0; voterIdx < votersCount; voterIdx++) {
            if(isAVoter) {
                voters[voterIdx-1] = voters[voterIdx];
            }
            if(msg.sender == voters[voterIdx].voterAddress) {
                isAVoter = true;
            } 
        }
        assert(isAVoter);
        candidates[candidateId].voteCount++;
        votersCount--;
    }
}
