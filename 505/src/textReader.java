import java.io.*;
import java.util.Scanner;
import java.util.StringTokenizer;

public class textReader {
	public static void main(String[] args) throws IOException {
		
				BufferedReader f = new BufferedReader(new FileReader("input.txt")); //Or InputStreamReader
				PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter("usaco.out")));

				//buffered reader reads into files, 
				
				String s = f.readLine();
				String s2 = f.readLine();
				StringTokenizer st = new StringTokenizer(s);
				int a = Integer.parseInt(st.nextToken());
				int b = Integer.parseInt(st.nextToken());
				
				System.out.println(s +" " +  s2);

				out.close();
				System.exit(0);
			}
		

	}

