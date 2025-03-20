import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class ConnectionManager {

    /**
     * Create and get the Connection to DB
     * @return
     */
    public static Connection openConnection(String DRIVER, String DATABASE, String USER, String PASSWORD){
        
        try {
            // Register Database's driver
            try {
                Class.forName(DRIVER);
                System.out.printf("Driver %s successfully registered.%n\n", DRIVER);
            } catch (ClassNotFoundException e) {
                System.out.printf("Driver %s not found: %s.%n", DRIVER, e.getMessage());
                System.exit(-1);
            }
            // try connecting 
            Connection conn = DriverManager.getConnection(DATABASE, USER, PASSWORD);
            System.out.printf("Connection to database %s successfully established.\n", DATABASE);
            
            return conn;

        } catch (SQLException e) {
            TraceException(e);
            return null;

        }
    }

    /**
     * Close Connection to DB
     * @param conn
     */
    public static void closeConnection(Connection conn){

        try {
            // close the connection
            conn.close();
        } catch (SQLException e) {
            TraceException(e);
        }
    }

    /**
     * Custom tracing of exception
     * @param e
     */
    public static void TraceException(SQLException e) {
        System.out.printf("Database access error:%n");
        // cycle in the exception chain   
        while (e != null) {
            System.out.printf("- Message: %s%n", e.getMessage());
            System.out.printf("- SQL status code: %s%n", e.getSQLState());
            System.out.printf("- SQL error code: %s%n", e.getErrorCode());
            System.out.printf("%n");
            e = e.getNextException();
        }
    }

}
