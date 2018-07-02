import java.io.IOException;
import java.util.ArrayList;

public class arrayList {
	void printAll(ArrayList<String> s) {
		for(int i=0;i<s.size();i++){
			System.out.println(s.get(i));
		}
	}
	
	public ArrayList<Integer> noDupes(int[] numbers){
		ArrayList<Integer> answer= new ArrayList<Integer>(0);
		for(int i=0;i<numbers.length;i++) {
			answer.add(numbers[i]);
			final int number = 1;
		}
		for(int i=0;i<answer.size();i++) {
			for(int x=0;x<answer.size();x++) {
				if(answer.get(i) == answer.get(x)) {
					answer.remove(x);
				}
			}
			
		}
		return answer;
	}
	
	
	public static void main(String[] args) throws IOException{
		ArrayList<String> counts = new ArrayList<String>();
		counts.add("bun");
		
	
		int index = 1;
		int value = 1;
		for(int i=0;i<31;i++) {
			index = index*2;
			System.out.println(index);
		}
		
		int[] adresses = new int[index-1];
		for(int i=0;i<index;i++) {
			adresses[i] = i;
		}
		System.out.println(adresses[index-1]);
	//2."cornbread"
	//2b. 2
	
	
	
	
	}
}
class extend extends arrayList {
	int xxx = 0;
	
}
