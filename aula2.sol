// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
 //0x599E80D14aC9521c875753eeeAcaC3e8ecc1E195 - deploy
 //0x561bC36Eb5787565fE6c1F099D62A01163eA9171 - contrato
contract Vendedor {

    string public nmVendedor;
    uint256 public vrFatorBonus;

    function retornarValorBonus(uint256 vrVenda) public 
        view
        returns(uint256 vrComissao) {
            vrComissao = vrFatorBonus * vrVenda;
            return vrComissao;
    }
}