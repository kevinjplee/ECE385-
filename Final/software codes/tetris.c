#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
//#include <dos.h>
#include <unistd.h>
#include <time.h>
#include <conio.h>

struct tiles{
    char data[4][4];
    int x; //center point x 
    int y; //center point y
};

struct tiles totaltiles[7]={    //why is this line giving error?
    {{"    ",
      "1111",
      "    ",
      "    "},
    1,1},
    {{"2   " ,
      "222 " ,
      "    " ,
      "    "},
    1,1},
    {{"3   ",
      "333 ",
      "    ",
      "    "},
    1,1},
    {{"44  ",
      "44  ",
      "    ",
      "    "},
    1,1},
    {{" 55 ",
      "55  ",
      "    ",
      "    "},
    1,1},
    {{" 6  ",
      "666 ",
      "    ",
      "    "},
    1,1},
    {{"77  ",
      " 77 ",
      "    ",
      "    "},
    1,1}
};

struct Game{
    char gameboard[22][10];
    bool gameover;
    bool gamestart;
    int score;

};


struct PiecesController{
    struct tiles cur_tile;
    int cur_tile_x,cur_tile_y;  //global x for the center of the piece, and global y
    char cur_type;          //0 -> O type,1 -> I type, 2->JLSTZ type
    int rotation_index[2];  //[0] is current index, [1] is the next index
    bool cur_fixed;      //true when cur_tile is fixed on game board and do not move
};

//sum of print functions
void copy_to_table(struct PiecesController* piecesController, char table[22][10]){      //copy the tile to a temp table
    for (int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            if(piecesController->cur_tile.data[i][j]!=' '){
                int x=j-1+piecesController->cur_tile_x;
                int y=i-1+piecesController->cur_tile_y;
                table[y][x]=piecesController->cur_tile.data[i][j];
            }
        }
    }
}
void print_board(struct Game* game, struct PiecesController* piecescontroller){
    char table[22][10];
    for (int i=0;i<22;i++){
        for(int j=0;j<10;j++){
            table[i][j]=game->gameboard[i][j];
        }
    }
    copy_to_table(piecescontroller,table);
    for(int i = 0; i<22; i++){
        for(int j = 0; j < 10; j++){
            printf("%c", (table[i][j]));
        }
        printf("\n");
    }
    printf("-----------------\n");
}
void print_piece(char data[4][4]){
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            printf("%c", (data[i][j]));
        }
        printf("\n");
    }
    printf("-----------------\n");
}

//actual game functions
void line_clear(struct Game* game){
    bool line_full;
    int count=0;
    for(int i=21;i>1;i--){
        line_full=true;
        for(int j=0;j<10;j++){
            if(game->gameboard[i][j]==' '){
                line_full=false;
                break;
            }
        }
        if(line_full){
            //if(clear_startrow==22)   clear_startrow=i;
            for(int a=i;a>2;a--){
                for(int b=0;b<10;b++){
                    game->gameboard[a][b]=game->gameboard[a-1][b];
                }
            }
            for(int b=0;b<10;b++){
                    game->gameboard[2][b]=' ';
            }
            i++;    //because we drops all tile down by 1 when 1 line is cleared
            count++;
        }
    }
    game->score += 1 << count;  //score will be added by 2^count where count is the number of lines cleared
}


void new_tile(struct PiecesController* piecescontroller){ //generates new_tile after landtest
    int random = (rand()%7);
    piecescontroller->cur_tile = totaltiles[rand()%7];
    piecescontroller->cur_tile_x = rand()%7+1;                          //randomized spawn x coordinate
    //piecescontroller->cur_tile_x = piecescontroller->cur_tile.x;      //fixed spwan x coordinate
    piecescontroller->cur_tile_y = piecescontroller->cur_tile.y;
    if(random == 3){
        piecescontroller->cur_type = 0;
    } else if (random == 0){
        piecescontroller->cur_type = 1;
    } else{
        piecescontroller->cur_type = 2;
    }
    piecescontroller->rotation_index[0] = 0;   //the default spawn direction is index 0
    piecescontroller->rotation_index[1] = 0; 
}

bool landtest(struct PiecesController piecescontroller, struct Game game){
    for(int i = 0; i<4; i++){
        for(int j =0; j <4; j++){
            if(piecescontroller.cur_tile.data[i][j] != ' '){
                if(game.gameboard[piecescontroller.cur_tile_y+i][piecescontroller.cur_tile_x+j-1] != ' '){ //check the block that is one below
                    return true;  // if it has to land on the game board, then return true;
                }
            }
        }
    }
    return false;
}

void land(struct PiecesController* piecescontroller, struct Game* game){
    for(int i = 0; i<4; i++){
        for(int j = 0; j <4; j++){
            if(piecescontroller->cur_tile.data[i][j] != ' '){
            game -> gameboard[(piecescontroller->cur_tile_y) + i -1][(piecescontroller->cur_tile_x)+j -1] = (piecescontroller -> cur_tile.data[i][j]);
            }
        }
    }
    line_clear(game);
    new_tile(piecescontroller);    //I changed &piecescontroller to piecescontroller
}

bool leftwalltest(struct PiecesController piecescontroller, struct Game game){
    for(int i = 0; i<4; i++){
        for(int j =0; j <4; j++){
            if(piecescontroller.cur_tile.data[i][j] != ' '){
                if(piecescontroller.cur_tile_x+j-2 < 0){ //check if the value of the tile next to current tile is a wall.
                    return true;  // if it has to land on the game board, then return true;
                }
            }
        }
    }
    return false;
}

bool rightwalltest(struct PiecesController piecescontroller, struct Game game){
    for(int i = 0; i<4; i++){
        for(int j =0; j <4; j++){
            if(piecescontroller.cur_tile.data[i][j] != ' '){
                if(piecescontroller.cur_tile_x+j > 9){ //check if the value of the tile next to current tile is a wall.
                    return true;  // if it has to land on the game board, then return true;
                }
            }
        }
    }
    return false;
}


void fall(struct PiecesController* piecescontroller, struct Game* game){
    if(landtest(*piecescontroller, *game) == false){
            piecescontroller -> cur_tile_y++;
        }
}


int Offset_table_I[4][5][2];    //4 rotation index, 5 offset test, 2 values for data vector(x,y)
int Offset_table_JLSTZ[4][5][2];

void Offset_table_I_init(int x, int y, bool clockwise, char name){
    if(name == 'I'){
        Offset_table_I[0][0][0]=0;
        Offset_table_I[0][0][1]=0;
        Offset_table_I[0][1][0]=-1;
        Offset_table_I[0][1][1]=0;
        Offset_table_I[0][2][0]=2;
        Offset_table_I[0][2][1]=0;
        Offset_table_I[0][3][0]=-1;
        Offset_table_I[0][3][1]=0;
        Offset_table_I[0][4][0]=2;
        Offset_table_I[0][4][1]=0;

        Offset_table_I[1][0][0]=-1;
        Offset_table_I[1][0][1]=0;
        Offset_table_I[1][1][0]=0;
        Offset_table_I[1][1][1]=0;
        Offset_table_I[1][2][0]=0;
        Offset_table_I[1][2][1]=0;
        Offset_table_I[1][3][0]=0;
        Offset_table_I[1][3][1]=-1;
        Offset_table_I[1][4][0]=0;
        Offset_table_I[1][4][1]=2;

        Offset_table_I[2][0][0]=-1;
        Offset_table_I[2][0][1]=-1;
        Offset_table_I[2][1][0]=1;
        Offset_table_I[2][1][1]=-1;
        Offset_table_I[2][2][0]=-2;
        Offset_table_I[2][2][1]=-1;
        Offset_table_I[2][3][0]=1;
        Offset_table_I[2][3][1]=0;
        Offset_table_I[2][4][0]=-2;
        Offset_table_I[2][4][1]=0;

        Offset_table_I[3][0][0]=0;
        Offset_table_I[3][0][1]=-1;
        Offset_table_I[3][1][0]=0;
        Offset_table_I[3][1][1]=-1;
        Offset_table_I[3][2][0]=0;
        Offset_table_I[3][2][1]=-1;
        Offset_table_I[3][3][0]=0;
        Offset_table_I[3][3][1]=1;
        Offset_table_I[3][4][0]=0;
        Offset_table_I[3][4][1]=-2;
    }
    else{
        Offset_table_JLSTZ[0][0][0]=0;
        Offset_table_JLSTZ[0][0][1]=0;
        Offset_table_JLSTZ[0][1][0]=0;
        Offset_table_JLSTZ[0][1][1]=0;
        Offset_table_JLSTZ[0][2][0]=0;
        Offset_table_JLSTZ[0][2][1]=0;
        Offset_table_JLSTZ[0][3][0]=0;
        Offset_table_JLSTZ[0][3][1]=0;
        Offset_table_JLSTZ[0][4][0]=0;
        Offset_table_JLSTZ[0][4][1]=0;

        Offset_table_JLSTZ[1][0][0]=0;
        Offset_table_JLSTZ[1][0][1]=0;
        Offset_table_JLSTZ[1][1][0]=1;
        Offset_table_JLSTZ[1][1][1]=0;
        Offset_table_JLSTZ[1][2][0]=1;
        Offset_table_JLSTZ[1][2][1]=1;
        Offset_table_JLSTZ[1][3][0]=0;
        Offset_table_JLSTZ[1][3][1]=-2;
        Offset_table_JLSTZ[1][4][0]=1;
        Offset_table_JLSTZ[1][4][1]=-2;

        Offset_table_JLSTZ[2][0][0]=0;
        Offset_table_JLSTZ[2][0][1]=0;
        Offset_table_JLSTZ[2][1][0]=0;
        Offset_table_JLSTZ[2][1][1]=0;
        Offset_table_JLSTZ[2][2][0]=0;
        Offset_table_JLSTZ[2][2][1]=0;
        Offset_table_JLSTZ[2][3][0]=0;
        Offset_table_JLSTZ[2][3][1]=0;
        Offset_table_JLSTZ[2][4][0]=0;
        Offset_table_JLSTZ[2][4][1]=0;

        Offset_table_JLSTZ[3][0][0]=0;
        Offset_table_JLSTZ[3][0][1]=0;
        Offset_table_JLSTZ[3][1][0]=-1;
        Offset_table_JLSTZ[3][1][1]=0;
        Offset_table_JLSTZ[3][2][0]=-1;
        Offset_table_JLSTZ[3][2][1]=1;
        Offset_table_JLSTZ[3][3][0]=0;
        Offset_table_JLSTZ[3][3][1]=-2;
        Offset_table_JLSTZ[3][4][0]=-1;
        Offset_table_JLSTZ[3][4][1]=-2;
    }
}


int* matrix_mul(int x,int y, bool direction){
    int* output = (int*)malloc(2*sizeof(int));
    int matrix[2][2];
    if(direction){
        matrix[0][0]= 0;
        matrix[0][1] =-1;
        matrix[1][0] = 1;
        matrix[1][1]= 0;
    }   
    else{
         matrix[0][0]= 0;
        matrix[0][1] =1;
        matrix[1][0] = -1;
        matrix[1][1]= 0;
    }
    output[0]=matrix[0][0]*x+matrix[0][1]*y;
    output[1]=matrix[1][0]*x+matrix[1][1]*y;
    return output;
}
bool offset(struct Game* my_game, char new_data[4][4], struct PiecesController* my_pieces){
    bool havetile[5];
    int o;  //the index of the offset trials we are checking
    int offset_x, offset_y;
    for(o=0;o<5;o++){
        havetile[o]=false;
        if(my_pieces->cur_type==0) return false;
        else if(my_pieces->cur_type==1){
            offset_x=Offset_table_I[my_pieces->rotation_index[1]][o][0]-Offset_table_I[my_pieces->rotation_index[0]][o][0];
            offset_y=Offset_table_I[my_pieces->rotation_index[1]][o][1]-Offset_table_I[my_pieces->rotation_index[0]][o][1];
        }
        else{
            offset_x=Offset_table_JLSTZ[my_pieces->rotation_index[1]][o][0]-Offset_table_I[my_pieces->rotation_index[0]][o][0];
            offset_y=Offset_table_JLSTZ[my_pieces->rotation_index[1]][o][1]-Offset_table_I[my_pieces->rotation_index[0]][o][1];
        }
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                if(new_data[i][j] != ' '){
                    int x=(j-1)+my_pieces->cur_tile_x+offset_x;
                    int y=(i-1)+my_pieces->cur_tile_y+offset_y;
                    if( (y<0) | (y>9) | (x<0) | (x>21) | (my_game->gameboard[y][x]!=' ') )    havetile[o]=true;
                }
                if(havetile[o])    break; 
            }
            if(havetile[o])    break; 
        }
    }
    //choosing the actual offset
    for(o=0;o<5;o++){
        if(!havetile[o]){
            offset_x=Offset_table_I[my_pieces->rotation_index[1]][o][0]-Offset_table_I[my_pieces->rotation_index[0]][o][0];
            offset_y=Offset_table_I[my_pieces->rotation_index[1]][o][1]-Offset_table_I[my_pieces->rotation_index[0]][o][1];
            break;
        }
        if(o==4)    return false;           //cannot rotate
    }
    my_pieces->cur_tile_x = my_pieces->cur_tile_x + offset_x;
    my_pieces->cur_tile_y = my_pieces->cur_tile_y + offset_y;
    return true;
}

void rotate(struct Game* my_game, struct PiecesController* my_pieces, bool clockwise){
    //int x_old=my_pieces->cur_tile_x;
    //int y_old=my_pieces->cur_tile_y;
    int x_center=my_pieces->cur_tile.x;
    int y_center=my_pieces->cur_tile.y;
    char new_data[4][4];
    char type;              //the type of piece such as "1" "2" ....
    bool type_checked=false;
    //inititalize new_data
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            new_data[i][j]=' ';
        }
    }
    //update rotation index
    if(clockwise)    my_pieces->rotation_index[1]=my_pieces->rotation_index[0]+1;    //update the next rotation index
    else    my_pieces->rotation_index[1]=my_pieces->rotation_index[0]-1;
    if(my_pieces->rotation_index[1]==-1) my_pieces->rotation_index[1]=3;
    if(my_pieces->rotation_index[1]==4)  my_pieces->rotation_index[1]=0;
    //rotate each tiles and stored it in new_data
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            if(my_pieces->cur_tile.data[i][j]!=' '){
                int relative_x = j - x_center;
                int relative_y = i - y_center;
                if(!type_checked) {
                    type=my_pieces->cur_tile.data[i][j];
                    type_checked=true;
                }  
                int* new_tile = matrix_mul(relative_x,relative_y,clockwise);
                new_data[new_tile[1]+y_center][new_tile[0]+x_center] = type;
            }
        }
    }
    //check if rotate works in different offset, if true , copy new_data to my_pieces
    if(offset(my_game,new_data,my_pieces)){
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                my_pieces->cur_tile.data[i][j]=new_data[i][j];
            }
        }
        my_pieces->rotation_index[0]=my_pieces->rotation_index[1];    //update rotation index when rotate is done
    }
    //if not, reset rotation index
    else{
        my_pieces->rotation_index[1]=my_pieces->rotation_index[0];
    }
}

void move(struct PiecesController* piecescontroller, struct Game* game){
    //if(/*keycode == left*/){
    if(rand()%2){
        if(leftwalltest(*piecescontroller, *game) == false){
            piecescontroller -> cur_tile_x--;
        }
    } else if(rand()%2){ // right
        if(rightwalltest(*piecescontroller, *game) == false){
            piecescontroller ->cur_tile_x++;
        }
    } else if(rand()%2){ //down
        fall(piecescontroller, game);
    }else if(rand()%2){ //X
        rotate(game,piecescontroller, true);
    }
    else if(rand()%2){ //Z
        rotate(game,piecescontroller, false);
    }
}

void game_start(struct Game* game, struct PiecesController* piecesController){
    game->gamestart=true;
    new_tile(piecesController);
}
bool game_over(struct Game* game){
    for (int j=0;j<10;j++){
        if(game->gameboard[1][j]!=' ')  {
            game->gameover=true;
            return true;
        }
    }
    return false;
}

void clearScreen()
{
	system("cls");
}

void printboard(struct Game* game, struct PiecesController* piecescontroller){
    for(int i = 0; i<20; i++){
        for(int j = 0; j < 10; j++){
            if( j -(piecescontroller -> cur_tile_x) + 1  > -1 && j -(piecescontroller -> cur_tile_x) + 1  < 4){
                printf("%c", piecescontroller-> cur_tile.data[piecescontroller ->cur_tile_y - i +1][piecescontroller -> cur_tile_x -j +1 ]);
            } else
            printf("%c", (game->gameboard[i][j]));
        }
        printf("\n");
    }
	clearScreen();
}



void run(){
    struct Game game;
    game.gameover = false;
    //game.gamestart = false;
    game.score = 0;
    for(int i = 0; i <22;i++){
        for(int j = 0; j< 10; j++){
            game.gameboard[i][j] = ' ';
        }
    }
    struct PiecesController piecescontroller;
    new_tile(&piecescontroller);        //it actually is not random, there is specific order for types: 2->6->3....
    
	/*
    //test1 - test in general - pass
    print_board(&game,&piecescontroller);
    for(int i=0;i<200;i++){
        fall(&piecescontroller,&game);
        move(&piecescontroller,&game);
        rotate(&game,&piecescontroller,true);
        if(landtest(piecescontroller,game))     land(&piecescontroller,&game);
        if(i%20==0) print_board(&game,&piecescontroller);
    }
    print_board(&game,&piecescontroller);
    */

    /*test2 - test one piece rotation - pass
    printf("type: %d\n",piecescontroller.cur_type);
    print_piece(piecescontroller.cur_tile.data);
    for(int i=0;i<1;i++){
        //fall(&piecescontroller,game);
        //print_piece(piecescontroller.cur_tile.data);
        rotate(&game,&piecescontroller,true);
    }
    print_piece(piecescontroller.cur_tile.data);
    */

    /*test3 - test line clearing -> pass (if wanna test this, change the spwan location of a new piece)
    print_board(&game,&piecescontroller);
    for(int j=3;j<10;j++){
        game.gameboard[21][j]='1';
    }
    for(int i=0;i<20;i++){
        fall(&piecescontroller,&game);
        //move(&piecescontroller,&game);
        //rotate(&game,&piecescontroller,true);
        if(landtest(piecescontroller,game))     land(&piecescontroller,&game);
        if(i%5==0) print_board(&game,&piecescontroller);
    }
    print_board(&game,&piecescontroller);
    */
	
	int count = 0;
    
    while(!game_over(&game)){
        //if(!game.gamestart)     game_start(&game,&piecescontroller);
		count++;
		if (count % 50 == 0) {
			clearScreen();
			print_board(&game, &piecescontroller);
		}
		if (count % 350 == 0) {
			fall(&piecescontroller, &game);
		}
        move(&piecescontroller,&game);   //multiple move so that it checks keyboard constantly
        
        if(landtest(piecescontroller,game))     land(&piecescontroller,&game);
        usleep(100);
    }
   
}

int main(){
    run();
    return 0;
}