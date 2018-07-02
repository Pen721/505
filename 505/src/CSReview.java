
public class CSReview {
	
	static String s = "";
	public static void pnum(int n) {
		if(n > 10) {
			pnum(n /10);
		}
		s += Integer.toString(n % 10);
	}
	
	public static void main(String[] args) {
		System.out.println(!(0 == 0 && 0 == 0) || 1 ==0);
		
	}
}
