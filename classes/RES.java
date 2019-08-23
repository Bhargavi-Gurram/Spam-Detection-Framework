package CT;
import databaseconnection.*;
import org.apache.commons.lang.StringUtils;
import java.sql.*;
import java.util.Vector;

public class  RES
{

public static String main( String review) {
String res="Non Spam";
int d1=0;
int d2=0;
try{
	String[] compare={"you", "your", "yours" ,"your's", "yourself" , "yourselves" };		
	review=review.toLowerCase();
	for(String com: compare)
       d1 =d1+StringUtils.countMatches(review, com);
	
	   
	   d2 =StringUtils.countMatches(review, "!");
	

if(d2>0&& d1>0)
	res="Spam";
else
	res="Non Spam";


}
	catch(Exception e){}
	return res;
}







public static double score( String review) {
double res=0;
int d1=0;
int d2=0;
try{
	String[] compare={"you", "your", "yours" ,"your's", "yourself" , "yourselves" };		
	review=review.toLowerCase();
	for(String com: compare)
       d1 =d1+StringUtils.countMatches(review, com);
	
	   
	   d2 =StringUtils.countMatches(review, "!");
	

if(d2>0&& d1>0)
	res=1;
else if(d2>0||d1>0)
	res=0.5;
else
	res=0;


}
	catch(Exception e){}
	return res;
}



	public static void main(String[] args) 
	{
	}

}



