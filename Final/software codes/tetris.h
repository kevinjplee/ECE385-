struct tiles;

tiles totaltiles[7];

struct Game;

struct PiecesController;
void new_tile(PiecesController piecescontroller);
bool landtest(PiecesController piecescontroller, Game game);
bool leftwalltest(PiecesController piecescontroller, Game game);
bool rightwalltest(PiecesController piecescontroller, Game game);
void fall(PiecesController piecescontroller, Game game)

int Offset_table_I[4][5][2];
int Offset_table_JLSTZ[4][5][2];
void Offset_table_I_init(int x, int y, bool clockwise, char name);

int* matrix_mul(int x,int y, bool direction);

bool offset(struct Game my_game, char* new_data, struct PiecesController my_pieces);

void rotate(struct Game my_game, struct PiecesController my_pieces);