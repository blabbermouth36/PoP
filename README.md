# PoP
## Midterm project - create a smart contract to implement Proof-of-Permission protocol

(a) Group name:- Techies for Social Good

(b) Group members:-
      1. Aaradhya Mehta
      2. Ankit Luthra
      3. Apurva Nanajkar

(c) Code description:-
      The code creates a smart contract to implement Proof-of-Permission for one or more assets. The asset can be sold or rented. An individual can have multiple assets sole or rented different individuals. 
      The code contains two structures representing person and asset. The struct Person has name and amount as its members. The amount is the total amount left in the person's account after selling/renting the assets. The struct Asset has name, owner and givenTo as its members. Owner attribute represents the person who owns the asset which is encrypted using hash function and givenTo attribute represents the person who has rented the particular asset.
      The code contains following functions:-
      
      1. sell(asset, seller, buyer, amount) - This function will be called when a person wants to sell his asset to another person for a fixed amount. The function will check if the buyer has enough amount in his account to buy the asset. The buyer will verify the ownership of the seller by comparing the hash provided by the seller and the hash it calculated using the seller's name and the asset's name. The function will return true only if it can verify the ownership of the seller. The asset's givenTo field will be updated with the buyer's reference.
      
      2. rent(asset, renter, rentee, amount) - This function will be called when a person wants to rent his asset to another person for a fixed amount. The function will check if the rentee has enough amount in his account to rent the asset. The buyer will verify the ownership of the renter by comparing the hash provided by the renter and the hash it calculated using the renter's name. It will check the givenTo field of the asset to make sure the asset is not rented to multiple people. The function will return true only if it can verify the ownership of the renter. The asset's givenTo field will be updated with the rentee's reference.
      
(d) Installation and execution details:-
      1. Run Remix IDE on the browser.
      2. Write the smart contract in solidity.
      3. Compile and run the smart contract using JavaScript VM environment provided by the IDE.
      4. Set gas limit and gas price for the contract and deploy the contract with X amounts of ether attached.

(f) Member Contribution:-
      1. Aaradhya Mehta
      2. Ankit Luthra
      3. Apurva Nanajkar
      
(e) References:-
      1. https://solidity.readthedocs.io/en/v0.4.24/introduction-to-smart-contracts.html
      2. https://codeburst.io/build-your-first-ethereum-smart-contract-with-solidity-tutorial-94171d6b1c4b
      3. https://remix.ethereum.org/
