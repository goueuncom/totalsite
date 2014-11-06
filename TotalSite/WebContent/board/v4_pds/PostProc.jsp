<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%	request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="dao" class="totalsite.board.BoardDao"	/>
<jsp:useBean id="dto" class="totalsite.board.BoardDto"	/>
<%
	ServletContext ctx = getServletContext();
	String path = ctx.getRealPath("fileupload");
	int maxSize = 50 * 1024 * 1024;
	
	MultipartRequest multi =
			new MultipartRequest(request, path, maxSize, "euc-kr", new DefaultFileRenamePolicy());
	
	Enumeration names = multi.getFileNames();
	String paramname = (String)names.nextElement();	// upFile
	//out.println(multi.getFilesystemName(paramname));
	dto.setFilename(multi.getFilesystemName(paramname));
	//dto.setFilename(multi.getFilesystemName("upFile"));
	dto.setName(multi.getParameter("name"));
	dto.setEmail(multi.getParameter("email"));
	dto.setHomepage(multi.getParameter("homepage"));
	dto.setSubject(multi.getParameter("subject"));
	dto.setContent(multi.getParameter("content"));
	dto.setPass(multi.getParameter("pass"));
	dto.setIp(multi.getParameter("ip"));
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>