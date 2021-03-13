import de.bezier.guido.*;
public final static int NUM_ROWS = 13;
public final static int NUM_COLS = 13;
public final static int numBombs = 50;
public int tiles = 0;
//public final static int numBombs = 69;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    bombs = new ArrayList();
        for(int r=0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
}}
    
    
    setBombs();
}
public void setBombs()
{
    for(int i = 0; i < numBombs;)
    {
        int x = ((int)(Math.random()*NUM_ROWS));
        int y = ((int)(Math.random()*NUM_COLS));
        if(!bombs.contains(buttons[x][y])){
        bombs.add(buttons[x][y]);
        i++;}
        //System.out.println(x + ", " + y);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}

public boolean isWon()
{
  if (tiles == NUM_ROWS * NUM_COLS - numBombs) {return true;}
  else if (tiles != NUM_ROWS * NUM_COLS - numBombs) {return false;}
  else if (tiles != NUM_ROWS * NUM_COLS - numBombs)
  {
    for (int i = 0; i < bombs.size(); i++){
      if (!bombs.get(i).isMarked()){
        return false;}}}
   return false;
}
System.out.println("isWon());
public void displayLosingMessage()
{
    text("defeat", 200, 200);
}
public void displayWinningMessage()
{
    //your code here
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
      if (mouseButton == LEFT && marked == false)
      {
        clicked = true;
        tiles++;
      }
      if (mouseButton == RIGHT && clicked == false)
      {
        marked = !marked;
      } 
      else if (bombs.contains( this ) && marked == false)
        displayLosingMessage();
      else if (countBombs(r, c) > 0)
        setLabel(str(countBombs(r, c)));
      else
        for (int i = -1; i <= 1; i++)
          for (int j = -1; j <= 1; j++)
            if ( (isValid(r+i, c+j)) && (!buttons[r+i][c+j].isClicked()) )
              buttons[r+i][c+j].mousePressed();
  }
    public void draw () 
    {    
        if (marked)
            fill(0,0,255);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<NUM_ROWS && c<NUM_COLS && r >= 0 && c >= 0)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int i= -1; i<2; i++)
        {
            for(int j=-1;j<2; j++)
            {
                if(isValid(r+i,c+j)==true)
                {
                    if(bombs.contains(buttons[r+i][c+j]))
                    {
                        numBombs++;
                    }
                }
            }
        }
        return numBombs;
    }
}
