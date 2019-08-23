package CT;
import java.io.*;
import java.sql.*;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.ChartUtilities;
import databaseconnection.*;

public class Evaluation2 {
   
public static void main(File BarChart)throws Exception {

Connection con1 = databasecon.getconnection();
Statement st1 = con1.createStatement();
ResultSet rs=null;
rs=st1.executeQuery("select avg(Weight) from weights where feature like 'U%' ");

      final DefaultCategoryDataset dataset = new DefaultCategoryDataset( );
		while(rs.next()){
			dataset.addValue( rs.getDouble(1) , "User-Based", "User-Based");      
		}

rs=st1.executeQuery("select avg(Weight) from weights where feature like 'R%' ");
		while(rs.next()){
			dataset.addValue( rs.getDouble(1) , "Review-Based", "Review-Based");      
		}
		
      JFreeChart barChart = ChartFactory.createBarChart(
         "", 
         "Meta Features ", "Weight", 
         dataset,PlotOrientation.VERTICAL, 
         true, true, true);
         
     int width = 640;    /* Width of the image */
      int height = 380;   /* Height of the image */ 
              
      ChartUtilities.saveChartAsJPEG( BarChart , barChart , width , height );
   }

	public static void main(String[] args) throws Exception
	{	
			File f=new File("E:/Apache Tomcat/webapps/NetSpam/images/graph.jpg");
			main(f);
	}

}