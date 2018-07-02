
public class q1 {
	
	static public void requeueAndDelete(Queue<String> q1, int n) {
		Queue<String> q3 = new AQueue<String>(q1.length()-1);
		int l = q1.length();
		int i =0;
		while(i<l) {
			if(i != n) {
				q3.enqueue(q1.dequeue());
				i++;
		}else {
			q1.dequeue();
			i++;
		}
		}
	while(q3.length() >0) {
	q1.enqueue(q3.dequeue());
	}
	}
	
	public static void main(String[] args) {
		Queue<String> q2 = new AQueue<String>(5);
		q2.enqueue("A");
		q2.enqueue("B");
		q2.enqueue("C");
		q2.enqueue("D");
		q2.enqueue("E");
		//for(int i =0;i<5;i++) {
		//System.out.println(q2.dequeue());
		//}
		requeueAndDelete(q2, 3);
		
	}
}
