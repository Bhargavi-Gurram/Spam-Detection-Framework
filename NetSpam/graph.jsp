<html>
<body>

<%@ page  import="java.sql.*"  import="java.io.*" import="CT.*" import="databaseconnection.*" %>

	<center>
		
	<h3>Features weights</h3>
					

			<%
			File f=new File("E:/Apache Tomcat/webapps/NetSpam/g1.jpg");
			Evaluation1.main(f);
			 f=new File("E:/Apache Tomcat/webapps/NetSpam/g2.jpg");
			Evaluation2.main(f);

			%>

			
			<img class="img-responsive" src="g1.jpg" alt="">
			<img class="img-responsive" src="g2.jpg" alt="">
<br>


<%
try{
String q1="select avg(Weight) from weights"; 
int c=0;
Connection con1 = databasecon.getconnection();
Statement st1 = con1.createStatement();
ResultSet rs=st1.executeQuery(q1);
	while(rs.next())
	{
		
}
}
catch(Exception e1)
{
out.println(e1.getMessage());
}
%>

</center>
<a href="output.jsp">next</a>
</body>
</html>
