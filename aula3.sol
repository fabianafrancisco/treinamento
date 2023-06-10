// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */

contract Aluguel {

    string public nmLocador;
    string public nmLocatario;
    uint256[] public vrAluguel;

    //O nome das partes, locador e locatário, e o valor inicial de cada aluguel deve 
    //ser informado no momento da publicação do contrato.        
    constructor(string memory _nmLocador, string memory _nmLocatario, 
        uint256 _vrAluguel, uint qtdeMeses) {
        nmLocador = _nmLocador;
        nmLocatario = _nmLocatario;
        for(uint i; i < qtdeMeses; i++){
            vrAluguel.push(_vrAluguel);
        }
    }

    //funcao que recebe o numero do mes e retorna o valor do aluguel daquele mes
    function retornarValorAluguelMes(uint256 nuMes) public 
    view
    returns(uint256) {
        return vrAluguel[nuMes - 1];
    }

    //funcao que retorna o nome do locador e do locatario
    function retornarLocadorLocatario() public 
    view
    returns(string memory nomeLocador, string memory nomeLocatario) {
        nomeLocador = nmLocador;
        nomeLocatario = nmLocatario;
        return (nomeLocador, nomeLocatario);

    }

    //funcao que altera o nome do locador se você passar o tipoPessoa 1 e 
    //altera o nome do locatario se voce passar o tipoPessoa 2
    function alterarLocadorLocatario(uint256 tpPessoa, string memory _nmLocador, 
        string memory _nmLocatario) public  {
        if(tpPessoa == 1){
            nmLocador = _nmLocador;
        } else if (tpPessoa == 2) {
            nmLocatario = _nmLocatario;
        }
    }

    //- funcao que reajusta os valores dos alugueis após de um determinado mes. 
    //Exemplo: soma 100 aos alugueis depois do mes 15
    function aumentarAluguel(uint256 mesAumento, uint256 vrAumento) public  {
        uint256 valor;
        valor = vrAluguel[0] + vrAumento;
        for(uint i; i < vrAluguel.length; i++){
            if(i >= mesAumento) {
                vrAluguel[i] = valor;
            }
        }       
    }
}

 //0xCC6B80F119D8E105861Bc96ba4d7b3aE525b819a