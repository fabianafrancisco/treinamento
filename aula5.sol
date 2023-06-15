// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Ownable {
    address public owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public onlyOwner returns (bool) {
        owner = _owner;
        return true;
    }
} 


/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */

contract Aluguel is Ownable {
    ContratoAluguel public contratoAluguel;

     struct ContratoAluguel {
        string nmLocador;
        string nmLocatario;
        uint256[] vrAluguel;
    }

    mapping(bytes32 => string) public ownerMessages;

    modifier validarCampos(string memory _nmLocador, string memory _nmLocatario){
        require(keccak256(bytes(_nmLocador)) != keccak256(bytes("")), "Nome do locator obrigatorio");
        require(keccak256(bytes(_nmLocatario)) != keccak256(bytes("")), "Nome do locatario obrigatorio");
        _;
    }

    //O nome das partes, locador e locatário, e o valor inicial de cada aluguel deve 
    //ser informado no momento da publicação do contrato.        
    constructor(string memory _nmLocador, string memory _nmLocatario, 
        uint256 _vrAluguel, uint qtdeMeses) {
        contratoAluguel.nmLocador = _nmLocador;
        contratoAluguel.nmLocatario = _nmLocatario;
        for(uint i; i < qtdeMeses; i++){
            contratoAluguel.vrAluguel.push(_vrAluguel);
        }
    }

    //funcao que recebe o numero do mes e retorna o valor do aluguel daquele mes
    function retornarValorAluguelMes(uint256 nuMes) public 
    view
    returns(uint256) {
        require(nuMes == 0, "Mes invalido");
        return contratoAluguel.vrAluguel[nuMes - 1];
    }

    //funcao que retorna o nome do locador e do locatario
    function retornarLocadorLocatario() public 
    view
    returns(string memory nomeLocador, string memory nomeLocatario) {
        nomeLocador = contratoAluguel.nmLocador;
        nomeLocatario = contratoAluguel.nmLocatario;
        return (nomeLocador, nomeLocatario);
    }

    function retornarLocadorLocatarioHash(string calldata _nmLocador, string calldata _nmLocatario) 
    public 
    returns(bytes32, bytes32 ) {
        ownerMessages[keccak256(bytes(_nmLocador))] = _nmLocador;
        ownerMessages[keccak256(bytes(_nmLocatario))] = _nmLocatario;
        return (keccak256(bytes(_nmLocador)), keccak256(bytes(_nmLocatario))) ;
    
    }

    //funcao que altera o nome do locador se você passar o tipoPessoa 1 e 
    //altera o nome do locatario se voce passar o tipoPessoa 2
    function alterarLocadorLocatario(uint256 tpPessoa, string memory _nmLocador, 
        string memory _nmLocatario) public { 
        require(tpPessoa == 1 || tpPessoa == 2, "Tipo de pessoa invalido");
        if(tpPessoa == 1) {
            require(keccak256(bytes(_nmLocador)) != keccak256(bytes("")), "Nome do locator obrigatorio");
            contratoAluguel.nmLocador = _nmLocador;
        } else {
            require(keccak256(bytes(_nmLocatario)) != keccak256(bytes("")), "Nome do locatario obrigatorio");
            contratoAluguel.nmLocatario = _nmLocatario;
        }
    }

    //- funcao que reajusta os valores dos alugueis após de um determinado mes. 
    //Exemplo: soma 100 aos alugueis depois do mes 15
    function aumentarAluguel(uint256 mesAumento, uint256 vrAumento) public  {
        require(mesAumento == 0, "Mes invalido");
        require(vrAumento == 0, "Valor invalido");
        uint256 valor;
        valor = contratoAluguel.vrAluguel[0] + vrAumento;
        for(uint i; i < contratoAluguel.vrAluguel.length; i++){
            if(i >= mesAumento) {
                contratoAluguel.vrAluguel[i] = valor;
            }
        }       
    }
}

 //0x32d00d76641Df72d579fd9A1D657A14b375e347A