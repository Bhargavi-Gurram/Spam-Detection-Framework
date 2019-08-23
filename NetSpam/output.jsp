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

<h1>Final Output</h1>
<br>
<br>
<center>
<table>
              <thead>
                <tr>
                  <th>Sno</th>
                  <th>Review</th>
		  <th>Result</th>
                </tr>
              </thead>
<%
try{
String t="reviews2";
String t1="final";
Connection con1 = databasecon.getconnection();
Statement st1 = con1.createStatement();
Statement st2 = con1.createStatement();
String q1="select * from " +t;
String q2="select * from " +t1;
ResultSet rs1=st2.executeQuery(q2); 
ResultSet rs=st1.executeQuery(q1);	
int c=0;
while(rs1.next() && rs.next())
	{
%>

              <tbody>
                <tr>
                  <td><%=++c%></td>
		
		  <td><font size="3" color=""><%String sub=rs.getString(4);
				  try{
					  out.println(sub.substring(0,120)+"....");
				  }catch(Exception e){
				  	  out.println(sub);
				  }
				  %></font></td>
                
                  <td><%Double k=rs1.getDouble("avg(f1)");
			if(k>=0.5)out.println("<font color=red>Spam</font>");else out.println("<font color=blue>NonSpam</font>");%></td>

	<%}
}

catch(Exception e){}
%>
</center>
</table>
</body>
</html>