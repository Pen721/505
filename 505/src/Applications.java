class Fruit {
    Fruit() {
        System.out.println("Fruit constructed");
    }

}

class Banana extends Fruit {
    
}

public class Applications {

    public static void main(String[] args) {
        Banana banana = new Banana();
    }
}