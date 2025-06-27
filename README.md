# theDAO_simul
This project demonstrates the reentrancy vulnerability that led to the 2016 The DAO hack 


---HOW TO RUN ON REMIX---

Initialize both contracts (EtherStore and Attack) using account[0].

Switch to a second account: account[1].

In the value input section, increase the value from 0 to 5 and change the unit from WEI to ETHER.

Open the EtherStore contract and click on deposit — this will transfer 5 ETH to the contract (plus gas).

Switch back to the first account: account[0].

In the value input, increase from 0 to 1 (ETH).

Open the Attack contract and click on attack — this will drain most of the ETH from EtherStore into the attack contract.

While still in the Attack contract, click on withdraw — this will transfer all ETH from the attack contract to the owner (account[0]).
