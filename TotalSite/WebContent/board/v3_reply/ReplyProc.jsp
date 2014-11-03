<%@ page contentType="text/html; charset=EUC-KR"%>
<%@page import="totalsite.board.BoardDto"%>
<%	request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="dao" class="totalsite.board.BoardDao"	/>
<jsp:useBean id="dto" class="totalsite.board.BoardDto"	/>
<jsp:setProperty property="*" name="dto"	/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDto parent = dao.getBoard(num);
	
	dao.replyUpdatePos(parent);
	
	dto.setPos(parent.getPos());
	dto.setDepth(parent.getDepth());
	dao.replyBoard(dto);
	
	response.sendRedirect("List.jsp");
%>