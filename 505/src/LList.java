/** Linked list implementation */
class LList<E> implements List<E> {
private Link<E> head; // Pointer to list header
private Link<E> tail; // Pointer to last element
protected Link<E> curr; // Access to current element
private int cnt; // Size of list
/** Constructors */
LList(int size) { this(); } // Constructor -- Ignore size
LList() {
curr = tail = head = new Link<E>(null); // Create header
cnt = 0;
}
/** Remove all elements */
public void clear() {
head.setNext(null); // Drop access to links
curr = tail = head = new Link<E>(null); // Create header
cnt = 0;
}
/** Insert "it" at current position */
public void insert(E it) {
curr.setNext(new Link<E>(it, curr.next()));
if (tail == curr) tail = curr.next(); // New tail
cnt++;
}
/** Append "it" to list */
public void append(E it) {
tail = tail.setNext(new Link<E>(it, null));
cnt++;
}
/** Remove and return current element */
public E remove() {
if (curr.next() == null) return null; // Nothing to remove
E it = curr.next().element(); // Remember value
if (tail == curr.next()) tail = curr; // Removed last
curr.setNext(curr.next().next()); // Remove from list
cnt--; // Decrement count
return it; // Return value
}
/** Set curr at list start */
public void moveToStart()
{ curr = head; }