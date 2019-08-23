package CT;
import databaseconnection.*;
import java.sql.*;

public class  Rating
{

static Connection con1=null;
static Statement st1=null;


public static String[] main(String id) {
String[] res=new String[2];

try{
con1 = databasecon.getconnection();
st1 = con1.createStatement();
 String sql=null;;
sql="select avg(rating), count(*) from reviews where prodid='"+id+"'";
ResultSet rs=null;
rs=st1.executeQuery(sql);

if(rs.next())
{
	res[0]=rs.getString(1);
	res[1]=rs.getString(2);
}
}
	catch(Exception e){
		System.out.println(e);
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



