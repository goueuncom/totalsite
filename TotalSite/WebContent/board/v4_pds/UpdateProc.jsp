<%@page import="totalsite.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="totalsite.board.BoardDao"		/>
<jsp:useBean id="dto" class="totalsite.board.BoardDto"		/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String userPass = request.getParameter("pass");
	
	dto = dao.getBoard(num);
	//pageContext.setAttribute("dto", dto);
	
	if(userPass.equals(dto.getPass())){
		// ���� ������ �� �־���
		dto = new BoardDto();
		dto.setName(request.getParameter("name"));
		dto.setEmail(request.getParameter("email"));
		dto.setSubject(request.getParameter("subject"));
		dto.setContent(request.getParameter("content"));
		// dto�� ���������� sql���ǹ��� ��� �� num�� �ٽ� ����
		dto.setNum(num);
		dao.updateBoard(dto);
		
		response.sendRedirect("List.jsp");
	}
	else{
%>
	<script>
		alert("�н����带 Ʋ�Ƚ��ϴ�.");
		history.back();
	</script>
<%
	}
%>