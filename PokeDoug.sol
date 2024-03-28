// SPDK-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract PokeDoug is ERC721{

    struct PokemonDoug{
        string name;
        uint level;
        string img;
    }
    PokemonDoug[] public pokemons;
    address public gameOwner;

    constructor () ERC721 ("PokeDoug", "PKD"){
        gameOwner = msg.sender;
    }

    
    modifier onlyOwnerOf(uint _monsterId) {

        require(ownerOf(_monsterId) == msg.sender,"only the owner can battle with this Pokemon.");
        _;
    }

    function battle(uint _attackingPokemon, uint _defendingPokemon) public onlyOwnerOf(_attackingPokemon){
        PokemonDoug storage attacker = pokemons[_attackingPokemon];
        PokemonDoug storage defender = pokemons[_defendingPokemon];

         if (attacker.level >= defender.level) {
            attacker.level += 2;
            defender.level += 1;
        }else{
            attacker.level += 1;
            defender.level += 2;
        }
    }
       function createNewPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Only the owner can create new Pokemons.");
        uint id = pokemons.length;
        pokemons.push(PokemonDoug(_name, 1,_img));
        _safeMint(_to, id);
    }

}
