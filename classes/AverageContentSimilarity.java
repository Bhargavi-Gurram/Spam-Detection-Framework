package CT;
import databaseconnection.*;
import java.sql.*;
import java.util.Vector;

public class  AverageContentSimilarity
{

static Connection con1=null;
static Statement st1=null;


public static String main(String email, String product, String tab) {
String res="Non Spam";
try{
con1 = databasecon.getconnection();
st1 = con1.createStatement();
String sql=null;;
sql="select review from "+tab+" where userid='"+email+"' and prodid='"+product+"' ";
//System.out.println(sql);
ResultSet rs=null;
rs=st1.executeQuery(sql);
int records=0;
double d1=0.0;
double d2=0.0;
Vector<String> v=new Vector<String>();
while(rs.next())
{
		v.add(rs.getString(1));
		records++;
}

if(records>1){
		int j=1;
		
		for(int i=0; j<v.size();j++){
			d2=SimilarityCheck.similarity(v.get(i),v.get(j));
			//System.out.println(d2);
			if(d2>d1){
			d1=d2;
			}
		}
if(d1>0.5){
	//System.out.println(d1);
	res="Spam";
}

}else{
	res="Non Spam";
}

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


	



public static double score(String email, String product, String tab) {
double d1=0.0;
double d2=0.0;

try{
con1 = databasecon.getconnection();
st1 = con1.createStatement();
String sql=null;;
sql="select review from "+tab+" where userid='"+email+"' and prodid='"+product+"' ";
//System.out.println(sql);
ResultSet rs=null;
rs=st1.executeQuery(sql);
int records=0;
Vector<String> v=new Vector<String>();
while(rs.next())
{
		v.add(rs.getString(1));
		records++;

}

if(records>1){
		int j=1;
		
		for(int i=0; j<v.size();j++){
			d2=SimilarityCheck.similarity(v.get(i),v.get(j));
			//System.out.println(d2);
			if(d2>d1){
			d1=d2;
			}
		}


}else{
	d1=0;	
}

}
	catch(Exception e){
		//System.out.println(e);
		//e.printStackTrace();

	}
	finally{
		try{
		con1.close();
		st1.close();
//		rs.close();
		}
		catch(Exception e){
		//System.out.println(e);
		}
	}
	return d1;
}


	public static void main(String[] args) 
	{
	}

}



