// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
 //0x2ecF1Bb487D82E05048B19a71feF49D9500e05b4 - deploy
 //0x561bC36Eb5787565fE6c1F099D62A01163eA9171 - contrato
contract Vendedor {

    string public nmVendedor;
    uint256 public vrFatorBonus;

    constructor(string memory nomeVendedor, uint256 valorFatorBonus) {
        nmVendedor = nomeVendedor;
        vrFatorBonus = valorFatorBonus;
    }

    function retornarValorBonus(uint256 vrVenda) public 
        view
        returns(uint256 vrComissao) {
            vrComissao = vrFatorBonus * vrVenda;
            return vrComissao;
    }
}