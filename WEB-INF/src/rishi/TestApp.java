package rishi; /**
 * Created by rishi on 8/4/18.
 */
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;


public class TestApp {

    public String go(HttpServletRequest request) throws SQLException, ClassNotFoundException  {

        System.out.println("inside rishi.TestApp");

        try {
            return new WordPicker().getWord();
        }
        catch(Exception e) {
            e.printStackTrace();
            return "";
        }

       // response.sendRedirect("confirm.jsp");

    }
}