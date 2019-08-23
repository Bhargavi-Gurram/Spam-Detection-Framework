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
<h1>Spamicity Probability</h1>

            <table>
              <thead>
                <tr>
                  <th>Sno</th>
                  <th>Metapath</th>
                  <th>Probability</th>

                </tr>
              </thead>
<%
try{
String q1="select avg(score), feature from metapath group by feature"; 
Connection con1 = databasecon.getconnection();
PreparedStatement ps=con1.prepareStatement("insert into spacimity values (?,?)");
int c=0;
Statement st1 = con1.createStatement();
st1.executeUpdate("delete from spacimity");
DecimalFormat df2 = new DecimalFormat("#.##");
ResultSet rs=st1.executeQuery(q1);

while(rs.next())
	{
%>

              <tbody>
                <tr>
                  <td><%=++c%></td>
                  <td><font size="3" color=""><%=rs.getString(2)%></font></td>
                  <td><font size="3" color=""><%=df2.format(rs.getDouble(1))%></td>
                  <%					
				  ps.setString(1,rs.getString(2));
					ps.setString(2,df2.format(rs.getDouble(1)).toString());
				try{ ps.executeUpdate();
				}catch(Exception e){
				System.out.println(e);
				}
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
		

<form method="post" action="weightcalc.jsp">
	<h3><input  type="submit" value="Weight Calculation"></h3>
</form>


</body>
</html>