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
<h1>User Linguistic based Features</h1>
<h3><u>Average Content Similarity UL-ACS</u></h3>

            <table>
              <thead>
                <tr>
                  <th>Sno</th>
                  <th>Review</th>


                  <th>User</th>
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
st2.executeUpdate("delete from f3");
st2.executeUpdate("ALTER TABLE f3 AUTO_INCREMENT=1");

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


                  <td><%=rs.getString("userid")%>
					<%double d1=AverageContentSimilarity.score(rs.getString("userid"),rs.getString("prodid"),tab);
					%></td>
					<td><%String res=AverageContentSimilarity.main(rs.getString("userid"),rs.getString("prodid"),tab);
					if(res.equals("Spam")){String sql1 = "INSERT INTO f3(f3) " + "VALUES (1)";
    							st3.executeUpdate(sql1);
out.println("<font color=red>"+res+"</font>");}else{String sql1 = "INSERT INTO f3(f3) " + "VALUES (0)";
    							st3.executeUpdate(sql1);
out.println("<font color=blue>"+res+"</font>");}%>
<%

				ps.setInt(1,rs.getInt(1));
				  ps.setString(2,res);
					ps.setDouble(3,d1);
				  ps.setString(4,"UL-ACS");
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


<form method="post" action="earlytime.jsp">
	<h3><input  type="submit" value="Early Time Frame">
</form>

</body>
</html>
