package b_teampro2.userinfo;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addressSearch")
public class addressSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
	
		String key = request.getParameter("key");
		try {
			response.getWriter().write(getJSON(key));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
	
	}
	public String getJSON(String key) throws Exception {
		if(key == null) key = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		UserSystemDBBean system = UserSystemDBBean.getInstance();
		ArrayList<String> keyList = system.getKey(key);
		for(int i=0;i<keyList.size();i++) {
			result.append("[{\"value\": \"" + keyList.get(i) + "\"},");
			result.append("{\"value\": \"" + keyList.get(i) + "\"},");
			result.append("{\"value\": \"" + keyList.get(i) + "\"},");
			result.append("{\"value\": \"" + keyList.get(i) + "\"}],");
		}
		result.append("]}");
	 return result.toString();
	}

}
