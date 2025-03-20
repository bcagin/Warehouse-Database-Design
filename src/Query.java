import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * LIST OF BOXES QUERIES
 */
public class Query {

    /**
     * Get Info about product
     * @param conn
     * @param id
     */
    public static void getProductInfo(Connection conn, String id){
        Statement stmt;
        ResultSet result;

        try {
            String query = "SELECT prod.name, prod.category, prod.supplier, " + 
                                "prod.price, count as available_quantity " +
                            "FROM warehouse.product AS prod INNER JOIN ( " +
                                "SELECT itm.product_id, COUNT(DISTINCT itm.sku) " +
                                "FROM warehouse.item AS itm GROUP BY itm.product_id " +
                            ") AS itm ON prod.product_id = itm.product_id " +
                            "WHERE prod.product_id = '" + id + "';";

            stmt = conn.createStatement();
            System.out.printf("Statement successfully created.\n");

            result = stmt.executeQuery(query);
            while(result.next()){
                System.out.println(
                    new StringBuilder()
                        .append("Name: ").append(result.getString("name")).append("\n")
                        .append("Catergory: ").append(result.getString("category")).append("\n")
                        .append("Supplier: ").append(result.getString("supplier")).append("\n")
                        .append("Price: ").append(result.getString("price")).append("\n")
                        .append("Quantity: ").append(result.getString("available_quantity")
                        .toString())
                );
            }
            result.close();
            stmt.close();
        } catch (SQLException e) {
            ConnectionManager.closeConnection(conn);
            ConnectionManager.TraceException(e);
        }
    }


    /**
     * 
     * @param conn
     * @param userName
     */
    public static void getInvoiceByUsername(Connection conn, String userName){

        Statement stmt;
        ResultSet result;

        try {
            String query1 = "SELECT ord.fc_username, ord.sku, invoice.* " +
                                "FROM warehouse.fc_order AS ord " +
                                    "LEFT JOIN warehouse.invoice AS invoice " +
                                    "ON ord.invoice_id = invoice.invoice_id " +
                                "WHERE ord.fc_username = '" + userName + "';";


            stmt = conn.createStatement();
            System.out.printf("Statement successfully created.\n");

            result = stmt.executeQuery(query1);
            while(result.next()){
                System.out.println(
                    new StringBuilder()
                        .append("\nCustomer Data:\n")
                        .append("Name: ").append(result.getString("name")).append("\n")
                        .append("Surname: ").append(result.getString("surname")).append("\n")
                        .append("Email: ").append(result.getString("email")).append("\n")
                        .append("\nData Billing:\n")
                        .append("Invoice Number: ").append(result.getString("invoice_id")).append("\n")
                        .append("Payment Amount: ").append(result.getString("payment_amount")).append("\n")
                        .append("Payment Method: ").append(result.getString("payment_method")).append("\n")
                        .append("Payment Date: ").append(result.getString("payment_date")
                        .toString())
                );
            }
            result.close();
            stmt.close();
        } catch (SQLException e) {
            ConnectionManager.closeConnection(conn);
            ConnectionManager.TraceException(e);
        }
    }


    /**
     * Get the open tickets
     * @param conn
     */
    public static void getOpenTicket(Connection conn){

        Statement stmt;
        ResultSet result;

        try {
            String query3 = "SELECT tkt1.ticket_id, t.subject, tkt1.status, " +
                                "tkt1.creation_date AS last_update, tkt1.priority " +
                            "FROM warehouse.ticket_status AS tkt1 " +
                                "LEFT JOIN warehouse.ticket t " +
                                "ON t.ticket_id = tkt1.ticket_id " + 
                            "JOIN ( " +
                                "SELECT ticket_id " +
                                "FROM warehouse.ticket_status " +
                                "EXCEPT ( " +
                                    "SELECT tkt2.ticket_id " +
                                    "FROM warehouse.ticket_status AS tkt2 " +
                                    "WHERE tkt2.status='Resolved' OR tkt2.status='Closed' " +
                                ")" +
                            ") AS open_ticket ON tkt1.ticket_id = open_ticket.ticket_id " +
                            "ORDER BY priority DESC;";


            stmt = conn.createStatement();
            System.out.printf("Statement successfully created.\n");

            result = stmt.executeQuery(query3);
            System.out.println("\nOpen Tickets:\n");
            System.out.println(new StringBuilder()
                    .append("Ticket Id").append("\t\t\t\t")
                    .append("Subject").append("\t\t\t\t\t")
                    .append("Last update").append("\t\t")
                    .append("Priority"));
            while(result.next()){
                System.out.println(
                    new StringBuilder()
                        .append(result.getString("ticket_id")).append("\t")
                        .append(result.getString("subject")).append("\t")
                        .append(result.getString("last_update")).append("\t")
                        .append(result.getString("priority"))
                        .toString());
            }
            result.close();
            stmt.close();
        } catch (SQLException e) {
            ConnectionManager.closeConnection(conn);
            ConnectionManager.TraceException(e);
        }
    }


}