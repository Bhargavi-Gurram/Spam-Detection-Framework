package CT;
import databaseconnection.*;
import java.sql.*;

public class  Burstiness
{
	static Connection con1=null;
	static Statement st1=null;

	public static String main(String email, String product, String tab) {

		String res="Non Spam";
		String sql=null;
		try{
			con1 = databasecon.getconnection();
			st1 = con1.createStatement();
			sql="select max(date_), min(date_), count(*) from "+tab+"  where userid='"+email+"' and prodid='"+product+"' ";
			ResultSet rs = null;
			rs=st1.executeQuery(sql);
			String last=null; 
			String first=null; 
			int records=0;
			double d1=0.0;

			if(rs.next())
				{
					last=rs.getString(1);
					first=rs.getString(2);
					records=rs.getInt(3);
				}

			if(records>1)
				{
					d1=(double)Math.abs(CT.DataDiff.numberOfDays(last,first));
					
					d1=d1/28;
					d1=1-d1;
					if(d1>0.5)
						res="Spam";
					else 
						res="Non Spam";
				}

			else{
				res="Non Spam";
			    }

		}

		catch(Exception e)
			{}
				
		
		finally{
			try{
				con1.close();
				st1.close();
 				//rs.close();
			   }
			catch(Exception e){
				System.out.println(e);
			}
	}
	return res;
}


public static double score(String email, String product, String tab) {
		double d1=0.0;
		try{
			con1 = databasecon.getconnection();
			st1 = con1.createStatement();
			String sql=null;
			sql="select max(date_), min(date_), count(*) from "+tab+"  where userid='"+email+"' and prodid='"+product+"' ";
		
			ResultSet rs=null;
			rs=st1.executeQuery(sql);
			String last=null; String first=null; int records=0;
			if(rs.next())
				{

					last=rs.getString(1);
					first=rs.getString(2);
					records=rs.getInt(3);
				}


			d1=(double)Math.abs(CT.DataDiff.numberOfDays(last,first));

			if(records>1)
				{
					d1=d1/28;
					d1=1-d1;
					
				}

			else
				{
					d1=0;
				}

	}
		catch(Exception e){}
	
 		finally{}
			

	return d1;

}	

public static void main(String inn[])
{}	

}



