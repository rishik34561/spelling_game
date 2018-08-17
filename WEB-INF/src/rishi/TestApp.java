package rishi; /**
 * Created by rishi on 8/4/18.
 */
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;


public class TestApp {

    public void go(HttpServletRequest request) throws SQLException, ClassNotFoundException  {

        System.out.println("inside rishi.TestApp");

        Connection con = null;
        PreparedStatement pstmt = null;

        Class.forName("org.apache.derby.jdbc.ClientDriver");

        Properties props = new Properties(); // connection properties
        // providing a user name and password is optional in the embedded
        // and derbyclient frameworks
        props.put("user", "app");
        props.put("password", "app");

        con = DriverManager.getConnection("jdbc:derby://localhost:1527/derbyDB", props);

        try {
            String query = "INSERT INTO words (word) VALUES (?)";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1,request.getParameter("myText"));

            pstmt.executeUpdate();

            con.close();
        }
        catch(Exception e) {
            e.printStackTrace();
        }

       // response.sendRedirect("confirm.jsp");

    }
}