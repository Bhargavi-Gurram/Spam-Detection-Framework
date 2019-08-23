package CT;
import databaseconnection.*;
import java.sql.*;

public class  NegativeRatio
{

static Connection con1=null;
static Statement st1=null;


public static String main(String email, String product, String tab) {
String res="Non Spam";
try{
con1 = databasecon.getconnection();
st1 = con1.createStatement();
String sql=null;
sql="select avg(rating), count(*) from "+tab+"  where userid='"+email+"' and prodid='"+product+"' ";
ResultSet rs=null;
rs=st1.executeQuery(sql);
int records=0;
double d1=0.0;
if(rs.next())
{
			d1=rs.getDouble(1);
			records=rs.getInt(2);


}

if(records>1){

if(d1>2.0)
	res="Non Spam";
else 
	res="Spam";

}

else{
	res="Non Spam";
}

}
	catch(Exception e){
		System.out.println(e);
		e.printStackTrace();

	}
	
	return res;
}



	

public static double score(String email, String product, String tab) {
double d1=0.0;
try{
con1 = databasecon.getconnection();
st1 = con1.createStatement();
String sql=null;
sql="select avg(rating), count(*) from "+tab+"  where userid='"+email+"' and prodid='"+product+"' ";
ResultSet rs=null;
rs=st1.executeQuery(sql);
int records=0;
if(rs.next())
{
			d1=rs.getDouble(1);
			records=rs.getInt(2);


}

if(records>1)

d1=d1/5;

else
	d1=0;


}
	catch(Exception e){
		
		e.printStackTrace();
	}

	return d1;
}

	

}



