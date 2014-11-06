<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.io.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	
	String name = request.getParameter("name");
	String realPath = getServletContext().getRealPath("fileupload");
	out.println(name);
	out.println(realPath);

	response.setContentType("Application/octet-stream");
	response.setHeader("content-Disposition", "attachment;filename=" + name);
	
	File f = new File(realPath + "/" + new String(name.getBytes("8859_1"), "euc-kr"));
	byte[] data = new byte[1024];
	
	try{
		BufferedInputStream input =
				new BufferedInputStream(new FileInputStream(f));
		BufferedOutputStream output =
				new BufferedOutputStream(response.getOutputStream());
		
		int read = input.read(data);
		while(read != -1){
			output.write(data, 0, read);
			read = input.read(data);
		}
		output.flush();
		output.close();
		input.close();
	}
	catch(Exception err){
		err.printStackTrace();	
	}
%>