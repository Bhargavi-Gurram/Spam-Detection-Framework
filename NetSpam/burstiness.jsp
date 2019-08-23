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

<%@ page  import="java.sql.*" import="CT.*" import="databaseconnection.*" %>

<body>
<h1>User Behavioral Based Feature</h1>
<h3><u>Burstiness UB-BST</u></h3>



            <table>
              <thead>
                <tr>
                  <th>Sno</th>
                  <th>Review</th>
		  <th>User</th>
                  <th>Date</th>

  		  <th>Result</th>
                </tr>
              </thead>

<%
try{

String tab=request.getParameter("tab");
session.setAttribute("tab",tab);
String q1="select * from "+tab;
int c=0;
Connection con1 = databasecon.getconnection();
Statement st1 = con1.createStatement();
Statement st2 = con1.createStatement();
Statement st3 = con1.createStatement();
st1.executeUpdate("delete from metapath");
st2.executeUpdate("delete from f1");
st2.executeUpdate("ALTER TABLE f1 AUTO_INCREMENT=1");
ResultSet rs=st1.executeQuery(q1);
PreparedStatement ps=con1.prepareStatement("insert into metapath values (?,?,?,?)");

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
                                             <td><font size="3" color=""><%=rs.getString("userid")%></td>

				  <td><%=rs.getString("date_")%>
					<%double d1=Burstiness.score(rs.getString("userid"),rs.getString("prodid"),tab);%></td>

					<td>

					<%String res=Burstiness.main(rs.getString("userid"),rs.getString("prodid"),tab);
						if(res.equals("Spam"))
							{String sql1 = "INSERT INTO f1(f1) " + "VALUES (1)";
    							st3.executeUpdate(sql1);

							out.println("<font color=red>"+res+"</font>");
							}

						else{String sql1 = "INSERT INTO f1(f1) " + "VALUES (0)";
    							st3.executeUpdate(sql1);
							out.println("<font color=blue>"+res+"</font>");}



					%></td>


			<%

				ps.setInt(1,rs.getInt(1));
				  ps.setString(2,res);
				ps.setDouble(3,d1);
				  ps.setString(4,"UB-BST");
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


<form method="post" action="negativeratio.jsp">
	<h3><input  type="submit" value="Negative Ratio">
</form>


</body>
</html>
