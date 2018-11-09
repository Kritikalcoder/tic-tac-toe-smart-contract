pragma solidity ^0.4.8;

contract Tictactoe {
    address player0;
    address player1;
    
    mapping( uint => address) player_address;
    address startPlayer;
    uint[3][3] board;
    uint whose_turn = 0;
    uint player_count;
    uint winner;
    
    function register_player() public returns(uint) {
        
        require(player_count < 2, "Number of players exceed the max. count of players allowed");
        if(player_count == 1){
            require(player_address[0] != msg.sender, "You're already registered");
        }
    
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
    
    function play_move(uint x, uint y) public payable returns(bool) {
        require(player_count == 2, "Game hasn't started");
        require(player_address[whose_turn] == msg.sender, "It's not your turn");
        require(x < 3 && x >=0, "Wrong location");
        require(y < 3 && y >=0, "Wrong location");
        require(board[x][y] == 0, "Move already made in location");
        require(winner == 0, "Game over");
        
        board[x][y] = whose_turn + 1;
        winner = check_board_for_winner();
        whose_turn = (whose_turn + 1) % 2;
        
        return true;
    }
    
    function check_board_for_winner() public view returns(uint) {
        uint i;
        if (board[0][0] == board[1][1] && board[1][1] == board[2][2])
            return board[0][0];
        
        if (board[0][2] == board[1][1] && board[1][1] == board[2][0])
            return board[0][2];
        
        for (i=0;i<3;i++) {
            if (board[i][0] == board[i][1] && board[i][1] == board[i][2])
                return board[i][0];
            if (board[0][i] == board[1][i] && board[1][i] == board[2][i])
                return board[0][i];
        }
        
        return 0;
    }
    
    function get_winner() public view returns(uint) {
        require(winner != 0, "Game is not over yet" );
        return winner - 1;
    }
    
    function get_board() public view returns(uint[3][3]) {
        return board;
    }
    
    function get_id() public view returns(uint) {
        require(player0 == msg.sender || player1 == msg.sender, "Not a participant");
        
        if (player0 == msg.sender)
            return 0;
        
        return 1;
    }
    
    function get_turn() public view returns(uint) {
        return whose_turn;
    }
}