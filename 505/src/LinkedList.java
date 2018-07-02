public class LinkedList {
  private LinkedList next;  
  private final String word;
  // constructor
  public LinkedList(String word, LinkedList next) {
    this.word = word;
    this.next = next;
  }
}