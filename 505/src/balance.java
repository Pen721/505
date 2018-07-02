public class balance {
	public static boolean isBalanced(String input){
		Stack<Character> q = new AStack<Character>(input.length());
		int i=0;
		while(i<input.length()){
			int a = i;
			if(input.charAt(i) == '(' || input.charAt(i) == '[' || input.charAt(i) == '{' || input.charAt(i) == '<') {
				q.push(input.charAt(i));
				i++;
			}
			else if(q.length()!=0){
				if(input.charAt(i) == '}' && q.topValue() == '{') {
					q.pop();
					i++;
				}else if(input.charAt(i) == ')' && q.topValue() == '(') {
					q.pop();
					i++;
				}else if(input.charAt(i) == ']' && q.topValue() == '[') {
					q.pop();
					i++;
				}else if(input.charAt(i) == '>' && q.topValue() == '<') {
					q.pop();
					i++;
				}
			}

			if(a == i) {
				break;
			}
			
		}
		if(i<= input.length()-1 || q.length() > 0) {
			return false;
		}
		else {
			return true;
		}
	}
}
