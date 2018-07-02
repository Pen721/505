
public class merge {
	static <E extends Comparable<? super E>>
	void mergesort(E[] arr, E[] temp, int s, int e) {
		int mid = (s+e)/2;
		if(s == e) return;
		else mergesort(arr, temp, s, mid);
		
		mergesort(arr, temp, mid+1, e);
		
		for(int i=s;i<mid;i++) temp[i] = arr[i];
		for(int j=s;j<e-mid;j++) temp[e-j+1] = arr[j+mid];
		
		for(i=s)
	}
}
