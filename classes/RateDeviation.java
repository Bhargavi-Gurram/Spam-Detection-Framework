package CT;
import databaseconnection.*;
import java.sql.*;
import java.util.Vector;

public class  RateDeviation
{

static Connection con1=null;
static Statement st1=null;


public static String main(double rating, String row, String email, String product, String tab) {
String res="Non Spam";
try{
con1 = databasecon.getconnection();
st1 = con1.createStatement();
String sql=null;;
sql="select  avg(rating) from "+tab+" where  prodid='"+product+"' and sno!='"+row+"' ";
System.out.println(sql);
ResultSet rs=null;
rs=st1.executeQuery(sql);
int records=0;
double d1=0.0;
double d2=0.0;
Vector<String> v=new Vector<String>();
if(rs.next())
{
	d2=rating-rs.getDouble(1);
	System.out.println(d2);
	d2=d2/4;
	d2=1-d2;
}
if(d2>0.5)
	res="Non Spam";
else
	res="Spam";


}
	catch(Exception e){
		System.out.println(e);
		e.printStackTrace();

	}
	finally{
		try{
		con1.close();
		st1.close();
//		rs.close();
		}
		catch(Exception e){
		System.out.println(e);
		}
	}
	return res;
}






public static double score(double rating, String row, String email, String product, String tab) {
double res=0.0;
try{
con1 = databasecon.getconnection();
st1 = con1.createStatement();
String sql=null;;
sql="select  avg(rating) from "+tab+" where prodid='"+product+"' and sno!='"+row+"' ";
System.out.println(sql);
ResultSet rs=null;
rs=st1.executeQuery(sql);
int records=0;
double d1=0.0;
double d2=0.0;
Vector<String> v=new Vector<String>();
if(rs.next())
{
	d2=rating-rs.getDouble(1);
	System.out.println(d2);
	d2=d2/4;
	d2=1-d2;
}

res=d2;

}
	catch(Exception e){
		System.out.println(e);
		e.printStackTrace();

	}
	finally{
		try{
		con1.close();
		st1.close();
//		rs.close();
		}
		catch(Exception e){
		System.out.println(e);
		}
	}
	return res;
}



	public static void main(String[] args) 
	{
	}

}



