
public class BSTPractice {
	
	
	public static void main(String[] args) {
		ArrayList<BST> tree = ArrayList<new BST<Integer, String>()>();
		tree.insert(5, "A");
		tree.insert(2, "B");
		tree.insert(1, "C");
		tree.insert(4, "D");
		tree.insert(10, "E");
		tree.insert(15, "F");
		tree.insert(17, "G");
		tree.insert(18, "H");
		tree.BFS();
		tree.pruneLeaves(tree.root);
		tree.BFS();
		System.out.println(tree.root.element());
	   
	}
}
