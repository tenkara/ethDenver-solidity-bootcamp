// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface IHelloWOrld {
    function helloworld() external view returns (string memory);
    function setText(string memory newText) external;
}
contract HelloWorld {
    string private text;
    address public owner;

    constructor(string memory myText) {
        text = myText;
        owner = msg.sender;
    }
    
    function helloworld () public view returns (string memory) {
        return text;
    }
    /// @notice This function sets the text variable
    /// @dev This is a state change
    function setText(string calldata newText) public {
        text = newText;
    }

    /// @notice This pure function does not modify any state variables in the contract
    function pureText() public pure returns (string memory) {
        return "Hello World";
    }

    /// @notice Internal function to the contract; not intended for public interaction
    /// @notice Checks that two strings are the same
    function _isPure() internal view returns (bool check_) {
        check_ = keccak256(bytes(text)) == keccak256(bytes(pureText()));
    }

    function isPure() public view returns (bool returnValue_) {
        returnValue_ = _isPure();
    }

    function _restore() internal {
        text = pureText();
    }

    /// 
    function restore() public returns (bool) {
        if(_isPure()) return false;
        _restore();
        return true;
    }

    /// @notice Transfer ownership of the contract
    /// @notice Requires current owner to make the transfer
    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    modifier onlyOwner() {
        require (msg.sender == owner, "Caller is not the owner");
        _;
    }
}