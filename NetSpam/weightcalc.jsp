<html>
<head>
<style>
table,th,td{
    border-collapse: collapse;
    border: 1px solid #dddddd;
           }
th, td {
    padding: 5px;
    text-align: center;
       }

</style>
</head>


<%@ page  import="java.sql.*" import="CT.*" import="java.text.DecimalFormat" import="databaseconnection.*" %>

<body>
<h1>Weight Calculation</h1>

            <table>
              <thead>
                <tr>
                  <th>Sno</th>
                  <th>Metapath </th>
                  <th>Weight</th>

                </tr>
              </thead>
<%
try{
String q1="select* from spacimity"; 


Connection con1 = databasecon.getconnection();
PreparedStatement ps=con1.prepareStatement("insert into weights values (?,?)");
int c=0;
Statement st1 = con1.createStatement();
Statement st2 = con1.createStatement();
Statement st3 = con1.createStatement();
st1.executeUpdate("delete from weights");


ResultSet rs=st1.executeQuery(q1);
ResultSet rs2=null;
double up=0.0;
double down=0.0;
double we=0.0;
double spam=0;

	
	while(rs.next())
	{ 
		 up=0.0;
		 down=0.0;
		
		String feature=rs.getString(1);
		rs2=st2.executeQuery("select * from metapath where feature='"+feature+"'  ");	
		while(rs2.next()){
			String temp=rs2.getString("spam");
			if(temp.equals("Spam"))
				spam=1;
			else
				 spam=0;

			down=down+rs2.getDouble("score");//sum of all scores	
			up=up+(rs2.getDouble("score")*rs.getDouble("score")*spam);  //avg score of each feature* score of that review * spam or not(1 or 0)

		}
				we=up/down;
				ps.setString(1,feature);
				ps.setDouble(2,we);

				
				try{ ps.executeUpdate();
				}catch(Exception e){
				System.out.println(e);
				}

											%>

              <tbody>
                <tr>
                  <td><%=++c%></td>
                  <td><font size="3" color=""><%=feature%></font></td>
                  <td><font size="3" color=""><%=we%></td>


<%}
}
catch(Exception e1)
{
out.println(e1.getMessage());
}


%>

</table>
		

<a href="graph.jsp">Graph</a>

</body>
</html>