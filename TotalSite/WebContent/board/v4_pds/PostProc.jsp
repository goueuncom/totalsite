<%@ page contentType="text/html; charset=EUC-KR"%>
<%	request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="dao" class="totalsite.board.BoardDao"	/>
<jsp:useBean id="dto" class="totalsite.board.BoardDto"	/>
<%
/* 	필요 없쌉. <jsp:setProperty property="*" 이면 OK
	dto.setName(request.getParameter("name"));
	dto.setName(request.getParameter("email"));
	dto.setName(request.getParameter("homepage"));
	dto.setName(request.getParameter("subject"));
	dto.setName(request.getParameter("content"));
	dto.setName(request.getParameter("pass"));
	dto.setName(request.getParameter("ip"));
	 */
%>
<jsp:setProperty	property="*"	 name="dto"/>
<%
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>