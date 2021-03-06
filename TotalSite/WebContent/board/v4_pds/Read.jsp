<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<jsp:useBean id="dao" class="totalsite.board.BoardDao"	/>
<jsp:useBean id="dto" class="totalsite.board.BoardDto"	/>

<body>
<%	
	int num = Integer.parseInt(request.getParameter("num"));
	// List.jsp 페이지로 돌아갈 때 쓸 값
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	dto = dao.getBoard(num);
	pageContext.setAttribute("dto", dto);
%>

<br><br>
<table align=center width=70% border=0 cellspacing=3 cellpadding=0>
 <tr>
  <td bgcolor=9CA2EE height=25 align=center class=m>글읽기</td>
 </tr>
 <tr>
  <td colspan=2>
   <table border=0 cellpadding=3 cellspacing=0 width=100%> 
    <tr> 
	 <td align=center bgcolor=#dddddd width=10%> 이 름 </td>
	 <%-- <td bgcolor=#ffffe8><%=dto.getName()%></td> --%>
	 <td bgcolor=#ffffe8><jsp:getProperty property="name" name="dto"	/></td>
	 <td align=center bgcolor=#dddddd width=10%> 등록날짜 </td>
	 <td bgcolor=#ffffe8><%=dto.getRegdate()%></td>
	</tr>
    <tr>
	 <td align=center bgcolor=#dddddd width=10%> 메 일 </td>
	 <td bgcolor=#ffffe8 ><%=dto.getEmail()%></td> 
	 <td align=center bgcolor=#dddddd width=10%> 홈페이지 </td>
	 <td bgcolor=#ffffe8 ><a href="http://<%=dto.getHomepage()%>" target="_new">http://<%=dto.getHomepage()%></a></td> 
	</tr>
    <tr> 
     <td align=center bgcolor=#dddddd> 제 목</td>
     <td bgcolor=#ffffe8 colspan=3><%=dto.getSubject()%></td>
   </tr>
   <tr> 
     <td align=center bgcolor=#dddddd> 첨부 파일</td>
     <td bgcolor=#ffffe8 colspan=3><a href="download.jsp?name=<%=dto.getFilename()%>"	>
				<%=dto.getFilename()%></a><br/></td>
   </tr>
   <tr> 
    <td colspan=4><%=dto.getContent()%></td>
   </tr>
   <tr>
    <td colspan=4 align=right>
     	<%=dto.getIp()%>	로 부터 글을 남기셨습니다./  조회수 :	<%=dto.getCount()%> 
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align=center colspan=2> 
	<hr size=1>
	<!-- [ <a href="javascript:list()">목 록</a> | -->
	[ <a href="javascript:document.list.submit()">목 록</a> |  
	<a href="Update.jsp?num=<%=num%>">수 정</a> |
	<a href="Reply.jsp?num=<%=num%>">답 변</a> |
	<a href="Delete.jsp?num=<%=num%>">삭 제</a> ]<br>
  </td>
 </tr>
</table>

<form name="list" method="post" action="List.jsp">
	<input type="hidden" name="keyFiled" value="<%=keyField%>"	/>
	<input type="hidden" name="keyWord" value="<%=keyWord%>"		/>
</form>
</body>
</html>
