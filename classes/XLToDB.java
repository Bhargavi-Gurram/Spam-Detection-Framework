package CT;
import java.io.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import javax.swing.JOptionPane;
import databaseconnection.*;
import java.util.*;
import java.sql.*; 

    public class XLToDB {  

	public static final String INSERT_RECORDS = "INSERT INTO reviews2(prodid,rating,review, userid,date_)VALUES(?,?,?,?,?)";

	
	

			 public static void main(String[] args) throws Exception{
					XLToDB.insertRecords("reviews.xlsx");
			  }
            
			
			public static boolean insertRecords(String s){

			File f=new File("E:/NetSpam Dataset/"+s);


	/* Create Connection objects */
            Connection con = null;
            PreparedStatement prepStmt = null;
            java.sql.Statement stmt = null;
            int count = 0;
            ArrayList<String> mylist = new ArrayList<String>();

            try{
                con =databasecon.getconnection();
                System.out.println("Connection :: ["+con+"]");
                prepStmt = con.prepareStatement(INSERT_RECORDS);
                stmt = con.createStatement();

				count = 1;


				FileInputStream fis = new FileInputStream(f);
                XSSFWorkbook workbook = new XSSFWorkbook (fis);
                XSSFSheet sheet = workbook.getSheetAt(0);
                Iterator ite = sheet.rowIterator();
                   while(ite.hasNext()) {
                            Row row = (Row) ite.next(); 
                            Iterator<Cell> cellIterator = row.cellIterator();
                            int index=1;
						int c=1;
                                    while(cellIterator.hasNext()) {

                                            Cell cell = cellIterator.next();
                                            
						switch(cell.getCellType()) { 
									
											case Cell.CELL_TYPE_STRING: //handle string columns
				
                                						          prepStmt.setString((index), cell.getStringCellValue()); 
                                    
                                    						               break;

        						                                    case Cell.CELL_TYPE_NUMERIC: //handle double data
	                                                						int i = (int)cell.getNumericCellValue();
												prepStmt.setInt((index), (int) cell.getNumericCellValue());
																							//System.out.println("in case1 "+(index));
                                    								break;

									
											}


										index++;										
											c++;

			


                                    }
																				count++;
                    //we can execute the statement before reading the next row
try{                  int i= prepStmt.executeUpdate();
						if(i>=1){
					  //System.out.println("inseted");
					  }
               
}
catch(Exception e){
System.out.println(e);
}

				}
                   /* Close input stream */
                   fis.close();
                   /* Close prepared statement */
                   prepStmt.close();

                   /* Close connection */
                   con.close();

            }catch(Exception e){
                e.printStackTrace();            
            }

return true;
            }
    }