/** Source code example for "A Practical Introduction to Data
    Structures and Algorithm Analysis, 3rd Edition (Java)" 
    by Clifford A. Shaffer
    Copyright 2008-2011 by Clifford A. Shaffer
 */
import java.util.Arrays;
import java.lang.Comparable;

/** Binary Search Tree implementation for Dictionary ADT */
class BST<Key extends Comparable<? super Key>, E>
implements Dictionary<Key, E> {
	public BSTNode<Key,E> root; // Root of the BST
	int nodecount;             // Number of nodes in the BST

	/** Constructor */
	BST() { root = null; nodecount = 0; }

	/** Reinitialize tree */
	public void clear() { root = null; nodecount = 0; }

	/** Insert a record into the tree.
      @param k Key value of the record.
      @param e The record to insert. */
	public void insert(Key k, E e) {
		root = inserthelp(root, k, e);
		nodecount++;
	}

	/** Remove a record from the tree.
      @param k Key value of record to remove.
      @return The record removed, null if there is none. */
	public E remove(Key k) {
		E temp = findhelp(root, k);   // First find it
		if (temp != null) {
			root = removehelp(root, k); // Now remove it
			nodecount--;
		}
		return temp;
	}

	/** Remove and return the root node from the dictionary.
      @return The record removed, null if tree is empty. */
	public E removeAny() {
		if (root == null) return null;
		E temp = root.element();
		root = removehelp(root, root.key());
		nodecount--;
		return temp;
	}


	public void BFS(){      
		Queue<BSTNode<Key, E>> q = new LQueue();
		q.enqueue(root);//You don't need to write the root here, it will be written in the loop
		while (q.length() > 0)
		{
			BSTNode<Key, E> n = q.dequeue();

			System.out.println(n.element()); //Only write the value when you dequeue it
			if (n.left() !=null)
			{
				q.enqueue(n.left());//enqueue the left child
			}
			if (n.right() !=null)
			{
				q.enqueue(n.right());//enque the right child
			}
		}
	}
	
	public BSTNode<Key, E> pruneLeaves(BSTNode<Key, E> rt) {
	    if (rt == null || rt.isLeaf()) {
	        return null;
	    }
	    rt.setLeft(pruneLeaves(rt.left()));
	    rt.setRight(pruneLeaves(rt.right()));
	    return rt;
	}
	
	public boolean notfull(BSTNode<Key, E> n) {
		if(n.left() !=null && n.right() !=null) {
			return false;
		}
		else {
			return true;
		}
	}
	
	public boolean isComplete() {
		if(root == null) {
			return true;
		}
		Queue<BSTNode<Key, E>> q = new LQueue();
		q.enqueue(root);
		boolean nonfull = false;
		while (q.length() > 0)
		{
			BSTNode<Key, E> n = q.dequeue();
			if (n.left() !=null)
			{
				if(nonfull) {
					return false;
				}
				q.enqueue(n.left());
			}else if(nonfull==false) {
				nonfull=true;
			}

			if (n.right() !=null)
			{
				if(nonfull) {
					return false;
				}
				q.enqueue(n.right());
			}else if(nonfull == false) {
				nonfull = true;
			}

		}
		return true;
	}


	/** @return Record with key value k, null if none exist.
      @param k The key value to find. */
	public E find(Key k) { return findhelp(root, k); }

	/** @return The number of records in the dictionary. */
	public int size() { return nodecount; }
	private E findhelp(BSTNode<Key,E> rt, Key k) {
		if (rt == null) return null;
		if (rt.key().compareTo(k) > 0)
			return findhelp(rt.left(), k);
		else if (rt.key().compareTo(k) == 0) return rt.element();
		else return findhelp(rt.right(), k);
	}
	/** @return The current subtree, modified to contain
   the new item */
	public BSTNode<Key,E> inserthelp(BSTNode<Key,E> rt,
			Key k, E e) {
		if (rt == null) return new BSTNode<Key,E>(k, e);
		if(rt.key() == k) {
			rt.dups.add(e);
		}
		if (rt.key().compareTo(k) > 0)
			rt.setLeft(inserthelp(rt.left(), k, e));
		else
			rt.setRight(inserthelp(rt.right(), k, e));
		return rt;
	}


	/** Remove a node with key value k
    @return The tree with the node removed */
	private BSTNode<Key,E> removehelp(BSTNode<Key,E> rt,Key k) {
		if (rt == null) return null;
		if (rt.key().compareTo(k) > 0)
			rt.setLeft(removehelp(rt.left(), k));
		else if (rt.key().compareTo(k) < 0)
			rt.setRight(removehelp(rt.right(), k));
		else { // Found it
			if (rt.left() == null) return rt.right();
			else if (rt.right() == null) return rt.left();
			else { // Two children
				BSTNode<Key,E> temp = getmin(rt.right());
				rt.setElement(temp.element());
				rt.setKey(temp.key());
				rt.setRight(deletemin(rt.right()));
			}
		}
		return rt;
	}
	private BSTNode<Key,E> getmin(BSTNode<Key,E> rt) {
		if (rt.left() == null) return rt;
		return getmin(rt.left());
	}
	private BSTNode<Key,E> deletemin(BSTNode<Key,E> rt) {
		if (rt.left() == null) return rt.right();
		rt.setLeft(deletemin(rt.left()));
		return rt;
	}
	private void printhelp(BSTNode<Key,E> rt) {
		if (rt == null) return;
		printhelp(rt.left());
		printVisit(rt.element());
		printhelp(rt.right());
	}

	public void printInorder(BSTNode<Key,E> rt) {
		if(rt == null)  return;
		else {
			printInorder(rt.left());
			for(int i=0;i<rt.dups.size();i++) {
				System.out.println((rt.key() + " " + rt.dups.get(i)));
			}
			printInorder(rt.right());
		}
	}
	

	public int getNumLeaves(BinNode<E> rt){

		if(rt == null)

		{

			return 0;

		}

		if(rt.isLeaf()) {
			return 1;
		}

		return getNumLeaves(rt.left()) + getNumLeaves(rt.right());

	}


/*
	public BinNode<E> PrunLeaves(BinNode<E> rt){

	if(rt == null){

	return null;

	}

	rt.setLeft(prunLeaves(rt.left()));

	rt.setRight(prunLeaves(rt.right()));

	}

	}
	*/

	//using the heap implementation
	boolean isComplete(BSTNode<Key, E> rt, int pos)
	{
		Queue<BSTNode<Key, E>> q = new AQueue<BSTNode<Key, E>>(nodecount);

		if(rt.key() == root.key()) {
			pos=0;
		}

		if (rt.key() == null) {    
			return true;
		}

		//if the index of a max heap exceeds the number of nodes, there must be a empty node in between, and thus the tree is not perfect
		if (pos>=nodecount) {
			return false;
		}


		System.out.println(pos);
		//in a max heap, the index for a right child is 2*pos+2, left child is 2*pos+1
		return (isComplete(rt.left(), 1+2 * pos) && isComplete(rt.right(), 2+2 *pos));
	}


	private StringBuffer out;

	public String toString() {
		out = new StringBuffer(100);
		printhelp(root);
		return out.toString();
	}
	private void printVisit(E it) {
		out.append(it + " ");
	}
	
	public void printRange(BSTNode<Key, E> rt, int hi, int lo) {
		if(rt == null) {
			return;
		}
		if(rt.key().compareTo(lo)<0) {
			printRange(rt.right(), hi, lo);
		}
		if(rt.key().compareTo(hi)>0) {
			printRange(rt.left(), hi, lo);
		}
		else {
			System.out.println(rt);
			printRange(rt.left());
			printRnage(rt.right());
		}
	}

}

/*
Binary Search Tree

 A complete binary tree has restricted shape obtained through starting at the root and filling the tree from left to right, all levels except d-1 is completely filled
Each level d has 2^d nodes, and a complete tree has at most 2^n+1 -1 nodes
Full tree- where each node either has 0 or 2 children

Full Binary Tree Theorem: The number of leaves in a non-empty full binary tree is one more than the number of internal nodes.

Theorem 5.2 The number of empty subtrees in a non-empty binary tree is one more than the number of nodes in the tree.


Depth First Traversals:
(a) Inorder (Left, Root, Right) : 4 2 5 1 3
Fives nodes in non-decreasing order
(b) Preorder (Root, Left, Right) : 1 2 4 5 3
Used in reating copy of the tree and getting the prefix expression
(c) Postorder (Left, Right, Root) : 4 5 2 3 1
Used in deleting the tree

void printPostorder(Node node)
    {
        if (node == null)
            return;
 
        // first recur on left subtree
        printPostorder(node.left);
 
        // then recur on right subtree
        printPostorder(node.right);
 
        // now deal with the node
        System.out.print(node.key + " ");
    }
 
    /* Given a binary tree, print its nodes in inorder*/
    void printInorder(Node node)
    {
        if (node == null)
            return;
 
        /* first recur on left child */
        printInorder(node.left);
 
        /* then print the data of node */
        System.out.print(node.key + " ");
 
        /* now recur on right child */
        printInorder(node.right);
    }
 
    /* Given a binary tree, print its nodes in preorder*/
    void printPreorder(Node node)
    {
        if (node == null)
            return;
 
        /* first print data of node */
        System.out.print(node.key + " ");
 
        /* then recur on left sutree */
        printPreorder(node.left);
 
        /* now recur on right subtree */
        printPreorder(node.right);
    }

*/