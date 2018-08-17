package rishi; /**
 * Created by rishi on 8/5/18.
 */
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;


public class DBUtil {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
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
        return con;

    }
}
