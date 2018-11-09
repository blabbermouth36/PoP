pragma solidity ^0.4.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "./Midterm.sol";
import "github.com/Arachnid/solidity-stringutils/strings.sol";

// file name has to end with '_test.sol'
contract test_1 {
    
    using strings for *;
    
    Midterm midterm;
    function beforeAll () {
      // here should instanciate tested contract
      midterm = new Midterm();
    }
    
    function checkOwnership () public {
      // this function is not constant, use 'Assert' to test the contract
        midterm.addAsset("car", "ankit");
        string memory element = "car".toSlice().concat("ankit".toSlice());
        bytes32 hash = keccak256(element);
        Assert.equal(hash, midterm.getOwner("car"), "error message");
    }
    
   
}

contract test_2 {
   
    function beforeAll () {
      // here should instanciate tested contract
    }
    
    function check1 () public {
      // this function is not constant, use 'Assert' to test the contract
      Assert.equal(uint(2), uint(1), "error message");
      Assert.equal(uint(2), uint(2), "error message");
    }
    
    function check2 () public constant returns (bool) {
      // this function is constant, use the return value (true or false) to test the contract
      return true;
    }
}
