package rishi;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by rishi on 8/19/18.
 */
public class SessionUtil {

    public static final String INDEX = "INDEX";
    public static final String SHUFFLED_LIST = "ShuffledList";
    public static int tableSize = 0;

    public static int getNextNumber(HttpServletRequest request) {

        HttpSession session = request.getSession();
        List<Integer> list = (List) session.getAttribute(SHUFFLED_LIST);
        System.out.println("[SessionUtil] getNextNumber()");
        if (list == null) {
            System.out.println("inside null, table size " + tableSize);
            list = new ArrayList<>();
            for (int i = 1; i <= tableSize; i++) {
                System.out.println("adding number " + i + " to the list");
                list.add(i);
            }
            Collections.shuffle(list);
            session.setAttribute(SHUFFLED_LIST, list);
            session.setAttribute(INDEX, 0);
        }

        int currentIndex = (Integer) session.getAttribute(INDEX);

        for (int i : list) {
            System.out.print(i);
            System.out.print(" ");
        }
        if (currentIndex == (tableSize)) {
            currentIndex = -1;
            session.setAttribute(INDEX, 0);
            System.out.println("currentIndex = " + currentIndex);
            return currentIndex;
        }

        int returnValue = list.get(currentIndex);

        session.setAttribute(INDEX, ++currentIndex);
        System.out.println("returning row number as " + returnValue);
        return returnValue;
    }

    public static void initialize() {
        try {

            Connection con = DBUtil.getConnection();
            java.sql.Statement statement = con.createStatement();
            String getNumRows = "select count(*) from words";
            ResultSet rows = statement.executeQuery(getNumRows);
            int numRows = 0;
            while (rows.next()) {
                numRows = rows.getInt(1);
            }
            SessionUtil.tableSize = numRows;
            System.out.println("\n \n ***************** number of rows in db is set to " + SessionUtil.tableSize);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
