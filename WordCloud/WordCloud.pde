class Word {
  float weight;
  String word;
  
  PVector pos;
  
  float counter = 0;
  
  int fontSize;
  
  color col;
  
  Word(String word, float weight, PVector pos, int fontSize) {
    this.weight = weight;
    this.word = word;
    this.pos = pos;
    this.fontSize = fontSize;
    
    col = color(random(150,255), random(50,255), random(50,255));
  }
  
  void changePos(PVector pos) {
    this.pos = pos;
  }
  
  boolean intersects(Word other) {
    
    PVector dif = other.getPos().copy();
    dif.sub(getPos());
    
    textSize(fontSize * weight);
    
    float w = textWidth(word)/2;
    float h = textAscent()/2 + textDescent()/2;
    
    textSize(other.fontSize * other.weight);
    
    w += textWidth(other.word)/2;
    h += textAscent()/2 + textDescent()/2;
    
    

    return !(abs(dif.x) > w || abs(dif.y) > h);    
    
  }
  
  PVector getPos() {
    PVector ret = pos.copy();
    
    ret.add(new PVector(cos(counter)*counter,sin(counter)*counter));
    
    return ret;
  }
  
  void write() {
    textSize(fontSize * weight);
    fill(col);
    text(word, getPos().x, getPos().y);
  }
}
ArrayList<Word> words = new ArrayList<Word>();

int fontSize = 45;

PFont font;

void setup() {
  size(600,600);
  background(0);
  font = createFont("andalemo", fontSize);
  textAlign(CENTER,CENTER);
  
  String[] lines = loadStrings("love.txt");

  for (int i = 0 ; i < lines.length; i++) {
    words.add(new Word(lines[i].split(":")[0],Float.parseFloat(lines[i].split(":")[1]),new PVector(width/2,height/2), fontSize));;
  }
 
  for(int i = 0; i < words.size(); i++) {
    boolean p;
    do {
      p = false;
      words.get(i).counter += PI/random(1,10);
      for (int j = 0; j < i; j++) {
          if (words.get(i).intersects(words.get(j)))  {
            p = true;
            break;
          }
      }
      
    } while (p);
  }
  
  for (Word w : words) {
    w.write();
  }
}