import java.sql.Connection;


public class Boxes {

    // driver, database and access crewdentials
    private static final String DRIVER = "org.postgresql.Driver";
    private static final String DATABASE = "jdbc:postgresql://localhost:5432/boxes";
    private static final String USER = "warehouse_manager";
    private static final String PASSWORD = "jw8s0F4";

    public static void main(String[] args) {

        // Create connection to DB
        Connection conn = ConnectionManager.openConnection(DRIVER, DATABASE, USER, PASSWORD);

        // get item info giver product_id
        Query.getProductInfo(conn, "362c3266-ab5a-4f61-bb37-924c2a8b9850");

        // get invoice by user
        Query.getInvoiceByUsername(conn, "pippo");

        // get open Ticket
        Query.getOpenTicket(conn);

        ConnectionManager.closeConnection(conn);

    }

}
