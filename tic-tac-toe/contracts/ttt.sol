pragma solidity ^0.4.8;

contract Tictactoe {
    address player0;
    address player1;
    
    struct Player {
        
    }
    mapping( uint => address) player_address;
    address startPlayer;
    uint[3][3] board;
    uint whose_turn = 0;
    uint player_count;
    
    function register_player() public returns(uint) {
        
        require(player_count < 2, "Number of players exceed the max. count of players allowed");
        player_count = player_count + 1;
        if (player_count == 1) {
            player0 = msg.sender;
            player_address[0] = player0;
            return 0;
            // starting player
        }
        player1 = msg.sender;
        player_address[1] = player1;
        return 1;
        // non starting player
    }
    
    function play_move() public returns(bool) {
        require(player_count == 2, "Game hasn't started");
        require(player_address[whose_turn] == msg.sender);
        
        
        
        whose_turn = (whose_turn + 1) % 2;
        
        
    }
}