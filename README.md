# Ethereum-Solidity

Smart contract in Solidity, using the Ethereum blockchain.

The smart contract's purpose is to facilitate donations to different charities. When a user
wants to send some funds to a destination address, instead of sending them directly to
that address, they will use the smart contract. A part of the funds will be sent to the
charity the user specified, while the rest will go to the destination address.

This is a code of a contract that when deployed, will accept a list of charities at creation time, specified by their respective addresses.
For facilitating the transfer of funds, the code has two different variations of the same
method. The users that would want to donate, will then make their payments by sending funds to these methods.

In the first variation, the method that facilitates the payments, will accept a destination
address, as well as the index number of the charity (0 is the index for the first charity, 1 for
the second etc). The method redirects 10% of the funds to the selected charity, while transferring the rest to the destination address. The contract makes appropriate checks if the user that originated the transfer has sufficient funds and if the
charity index number that is provided is a valid one.
In the second variation, the method additionally accepts a value for the donated
amount (in wei). In addition to the checks that the previous variation performs, in this
case, also checks that the donated amount is within acceptable limits; a donation
has to be at least 1% of the total transferred amount, while it cannot exceed half of the
total transferred amount.

The contract keeps track of the total amount raised by all donations (in wei) and
towards any charity, collectively, and provides means for any interested party to access that
information. So, for example, if one donation of 2 ether has been made to charity A and
another donation of 3 ether was made to charity B, the contract reports that 5 ether
was donated in total.
The contract, also, keeps track of who is the person that made the highest donation,
identified by their address, along with the amount they donated. This information is available with a single call to one method in the contract. It is also available only to the user that deployed the contract.
When a donation has been made through the contract, an event transmitting the address
of the donor and the amount donated, is emitted.
It also provides some means to destroy the contract and render it unusable.
This functionality should be available only to the user that deployed the contract.


Notes:  
1) The contract was compiled in Remix - Ethereum IDE  
2) Addresses were created using Ganache - Truffle Suite
