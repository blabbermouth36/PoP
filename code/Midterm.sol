pragma solidity ^0.4.22;
pragma experimental ABIEncoderV2;
import "https://raw.githubusercontent.com/ethereum/dapp-bin/master/library/stringUtils.sol";
import "github.com/Arachnid/solidity-stringutils/strings.sol";

//smart contract implementing PoP protocol
contract Midterm {
    
    using strings for *; 
    
    //structure for Person
    struct Person{
        string name;
        uint256 naiInPocket;
        mapping(string => Asset) ownership;
    }
    
    //create a list of all people
    mapping(string => Person) private personsList;
    
    string[] private personNamesList;
    
    //function to add new person
    function addPerson(string _name, uint256 _amount) {
        Person memory p = Person (_name, _amount);
        personsList[_name] = p;
        personNamesList.push(_name);
    }
    
    
    function getAllPersonNames() external view returns (string[]){
        return personNamesList;
    }
    
    
    function getPerson(string _personName) view returns (string, uint256, Asset){
        Person storage p = personsList[_personName];
        return (p.name , p.naiInPocket, p.ownership[_personName]);
    }
    
    
    //structure for asssets
    struct Asset{
        string name;
        bytes32 owner;
        bytes32 givenTo;
    }
    
    //create a list of all assets
    mapping(string => Asset) assetsList;
    
    string[] private assetsNamesList;
    
    
    function getAllAssetList() external view returns (string[]) {
        return assetsNamesList;
    }
    
        
    //function to add a new asset
    function addAsset(string _assetKey, string _personKey) public {
        string memory element = _assetKey.toSlice().concat(_personKey.toSlice());
        bytes32 hash = keccak256(element);
        Asset memory asset = Asset (_assetKey, hash, "");
        assetsList[_assetKey] = asset;
        assetsNamesList.push(asset.name);
        personsList[_personKey].ownership[_personKey] = asset;
        
    }
    
    
    //function to execute sell transaction
    function sell(string assetKey, string personKeyBuyer, string personKeySeller, uint nai) returns (bool){
        Person pBuy = personsList[personKeyBuyer];
        Person pSel = personsList[personKeySeller];
        if (pBuy.naiInPocket >= nai){
            bool x = transferOwnership(assetKey, personKeyBuyer, personKeySeller);
            if (x == true){
                pBuy.naiInPocket = pBuy.naiInPocket - nai;
                pSel.naiInPocket = pSel.naiInPocket + nai;
                return true;
            }
        }
        return false;
    }
    
    
    //function to transfer ownership of the asset from seller to buyer
    function transferOwnership(string assetKey, string personKeyBuyer, string personKeySeller) private returns (bool) {
        if (verifyOwner(assetKey, personKeySeller)){
            string memory element = assetKey.toSlice().concat(personKeyBuyer.toSlice());
            bytes32 hash = keccak256(element);
            Asset asset = assetsList[assetKey];
            asset.owner = hash;
            return true;
        }
        else return false;
    }
    
    
    //function to check the authenticity of the seller or renter
    function verifyOwner(string assetKey, string personKey) private returns (bool) {
        Asset memory asset = assetsList[assetKey];
        Person p = personsList[personKey];
        string memory element = assetKey.toSlice().concat(personKey.toSlice());
        bytes32 hash = keccak256(element);
        if (asset.owner == hash){
                return true;
        }
        return false;
    }
    
     
    //function to execute rent transaction
    function rent(string assetKey, string personKeyBuyer, string personKeySeller, uint nai)public returns (bool) {
        Person pBuy = personsList[personKeyBuyer];
        Person pSel = personsList[personKeySeller];
        if (pBuy.naiInPocket >= nai){
            bool x = allowUse(assetKey, personKeyBuyer, personKeySeller);
            if (x == true){
                pBuy.naiInPocket = pBuy.naiInPocket - nai;
                pSel.naiInPocket = pSel.naiInPocket + nai;
                return true;
            }
        }
        return false;
    }
    
    
    //function to allow possesion of rented asset
    function allowUse(string assetKey, string personKeyBuyer, string personKeySeller) private  returns (bool) {
       if (verifyOwner(assetKey, personKeySeller)){
            bytes32 hash = keccak256(personKeyBuyer);
            Asset asset = assetsList[assetKey];
            asset.givenTo = hash;
            return true;
       } else return false;
    }
    
    
    //function to take back the rented asset
    function takeBack(string assetKey){
        Asset asset = assetsList[assetKey];
        asset.givenTo = "";
    }
    
    
    function getOwner (string assetKey) external returns (bytes32) {
        Asset asset = assetsList[assetKey];
        return asset.owner;
    }
    
     function getRenter (string assetKey) external returns (bytes32) {
        Asset asset = assetsList[assetKey];
        return asset.givenTo;
    }
    
    
    function stringToBytes32(string memory source) private returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
}
    
        
}
