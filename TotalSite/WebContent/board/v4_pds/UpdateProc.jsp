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
		// 새로 수정할 값 넣어줌
		dto = new BoardDto();
		dto.setName(request.getParameter("name"));
		dto.setEmail(request.getParameter("email"));
		dto.setSubject(request.getParameter("subject"));
		dto.setContent(request.getParameter("content"));
		// dto를 리셋했으니 sql조건문에 들어 갈 num도 다시 세팅
		dto.setNum(num);
		dao.updateBoard(dto);
		
		response.sendRedirect("List.jsp");
	}
	else{
%>
	<script>
		alert("패스워드를 틀렸습니다.");
		history.back();
	</script>
<%
	}
%>