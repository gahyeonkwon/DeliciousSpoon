<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.util.*, java.security.*, java.io.*, java.net.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.net.*" %>
    <%@ page import="java.io.*" %>
    <%@ page trimDirectiveWhitespaces="true" %>
    <%request.setCharacterEncoding("utf-8");
    try {
           String apiUrl =  "https://sslsms.cafe24.com/smsSenderPhone.php";
            String userAgent = "Mozilla/5.0";
            String postParams = "userId=zkvmflcldh0&passwd=471b1e8c9904b6d87a7dbe3461df8091";
            URL obj = new URL(apiUrl);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", userAgent);

            // For POST only - START
            con.setDoOutput(true);
            OutputStream os = con.getOutputStream();
            os.write(postParams.getBytes());
            os.flush();
            os.close();
            // For POST only - END

            int responseCode = con.getResponseCode();
            System.out.println("POST Response Code :: " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_OK) { //success
                BufferedReader in = new BufferedReader(new InputStreamReader(
                        con.getInputStream()));
                String inputLine;
                StringBuffer buf = new StringBuffer();

                while ((inputLine = in.readLine()) != null) {
                    buf.append(inputLine);
                }
                in.close();
                out.print(buf.toString());
            } else {
                out.println("POST request not worked");
            }
    } catch(IOException ex){

    }
    %>
            