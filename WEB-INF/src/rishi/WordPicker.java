package rishi;


/**
 * Created by rishi on 8/5/18.
 */

import javax.xml.transform.Result;
import java.sql.*;
import java.io.*;

public class WordPicker {
    public String getWord() throws Exception {
        Connection con = DBUtil.getConnection();
        String getNumRows = "select count(*) from words";
        Statement statement = con.createStatement();
        ResultSet rows = statement.executeQuery(getNumRows);
        int numRows = 0;
        while (rows.next()) {
            numRows = rows.getInt(1);
        }
        int rand = (int)(Math.random() * numRows)+1;
        String query = "select * from (select row_number() over() as rownum, words.* from words) as tmp where rownum="+rand;
        statement = con.createStatement();
        ResultSet rs = statement.executeQuery(query);
        String word = "";
        while (rs.next()) {
            word = rs.getString(2);
        }

        rs.close();
        statement.close();
        con.close();
        return word;
    }

    public static void getAllWords() throws Exception {
        Connection con = DBUtil.getConnection();
        String getNumRows = "select count(*) from words";
        Statement statement = con.createStatement();
        ResultSet rows = statement.executeQuery(getNumRows);
        int numRows = 0;
        while (rows.next()) {
            numRows = rows.getInt(1);
        }

        PrintWriter out = new PrintWriter("/Users/rishi/software/apache-tomcat-7.0.42/webapps/test/word_files.txt");

        for (int i = 1; i < numRows; i++) {
            String query = "select * from (select row_number() over() as rownum, words.* from words) as tmp where rownum="+i;
            statement = con.createStatement();
            ResultSet rs = statement.executeQuery(query);
            String word = "";
            while (rs.next()) {
                word = rs.getString(2);
            }
            out.println(word);
        }
        out.close();
    }

    public static void main(String[] args) throws Exception {
        String word = new WordPicker().getWord();
        System.out.print(word);
    }

}
