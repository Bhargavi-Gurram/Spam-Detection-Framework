
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

<h1>Review Behavioral Based Feature</h1>
<h3><u>Rate Deviation RB-DEV</u></h3>


            <table>
              <thead>
                <tr>
                  <th>Sno</th>
                  <th>Review</th>
                  <th>Rating </th>
                  <th>Product</th>
                  
		<th>Result</th>
                </tr>
              </thead>

<%
String tab=(String)session.getAttribute("tab");
try{
String q1="select * from "+tab; 
int c=0;
DecimalFormat df2 = new DecimalFormat("#.##");
Connection con1 = databasecon.getconnection();
Statement st1 = con1.createStatement();
Statement st2 = con1.createStatement();

Statement st3 = con1.createStatement();
PreparedStatement ps=con1.prepareStatement("insert into metapath values (?,?,?,?)");
ResultSet rs=st1.executeQuery(q1);
st2.executeUpdate("delete from f5");
st2.executeUpdate("ALTER TABLE f5 AUTO_INCREMENT=1");
while(rs.next())
	{
%>

              <tbody>
                <tr>
                  <td><%=++c%></td>
                  <td><font size="3" color=""><%String sub=rs.getString(4);
				  try{
					  out.println(sub.substring(0,20)+"....");
				  }catch(Exception e){
				  	  out.println(sub);
				  }
				  %></font></td>
                  <td><font size="3" color=""><%=rs.getString(3)%></td>
                  <td><font size="3" color=""><%=rs.getString(2)%></td>
                  
					<%double d1=RateDeviation.score(rs.getDouble("rating"),rs.getString("sno"),rs.getString("userid"),rs.getString("prodid"),tab);
					
					
			  %></td>
			  <td>
					<%String res=RateDeviation.main(rs.getDouble("rating"),rs.getString("sno"),rs.getString("userid"),rs.getString("prodid"),tab); 
					if(res.equals("Spam"))
{String sql1 = "INSERT INTO f5(f5) " + "VALUES (1)";
   st3.executeUpdate(sql1);	
out.println("<font color=red>"+res+"</font>");}
					else{
String sql1 = "INSERT INTO f5(f5) " + "VALUES (0)";
st3.executeUpdate(sql1);	
out.println("<font color=blue>"+res+"</font>");}%>

<%
				ps.setInt(1,rs.getInt(1));
				  ps.setString(2,res);
				ps.setDouble(3,d1);
				  ps.setString(4,"RB-DEV");
				try{ ps.executeUpdate();
				}catch(Exception e){}
			  %>


                </tr>


<%}
}
catch(Exception e1)
{
out.println(e1.getMessage());
}
%>

</table>
		

<form method="post" action="res.jsp">
	<h3><input  type="submit" value="RES & PP1">
</form>

</body>
</html>