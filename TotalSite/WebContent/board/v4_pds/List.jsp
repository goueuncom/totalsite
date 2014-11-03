<%@page import="totalsite.board.BoardDto"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>

<%!
	public String getParam(HttpServletRequest req, String pname){
		if(req.getParameter(pname) != null){
			return req.getParameter(pname);
		}
		else{
			return "";
		}
	}

	// 페이징에 필요한 변수들
	int totalRecord = 0;			// 전체 글 갯수
	int numPerPage = 7;		// 한 페이지 당 보여질 글의 갯수		
	int pagePerBlock = 3;		// 여러 페이지를 한 번에 보여주는 블럭
	int totalPage = 0;			// 전체 페이지 수
	int totalBlock = 0;			// 전체 블럭 수
	int nowPage = 0;			// 현재 선택한 페이지 번호
	int nowBlock = 0;			// 현재 선택한 블럭
	int beginPerPage = 0;		// 페이지 당 시작 번호
%>
<HTML>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어를 입력하세요.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}
	function list(){
		location.replace("List.jsp");
	}
	function fnRead(param){
		// read form태그의 히든정보들을 모두 전송하겠다
		document.read.num.value = param;
		document.read.submit();
	}
</script>
<BODY>

<jsp:useBean id="dao" class="totalsite.board.BoardDao"	/>
<%-- <jsp:useBean id="dto" class="totalsite.board.BoardDto"	/> --%>
<%
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	if(keyField==null){
		keyField = "name";
	}
	if(keyWord==null)
		keyWord = "";
	
	Vector v = dao.getBoardList(keyField, keyWord);
	BoardDto dto = null;
	
	totalRecord = v.size();
	totalPage = (int)Math.ceil((double) totalRecord/numPerPage);
	
	if(request.getParameter("nowPage") != null)
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	if(request.getParameter("nowBlock") != null)
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	totalBlock = (int) Math.ceil((double) totalPage/pagePerBlock);
	
	beginPerPage = nowPage * numPerPage;
%>

<br>
<h2>JSP Board</h2>

<table align=center border=0 width=80%>
<tr>
	<td align=left>Total :  <%=totalRecord%>	Articles(
		<font color=red>  <%=nowPage%> / <%=totalPage%> Pages </font>)
	</td>
</tr>
</table>

<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=0 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 이름 </td>
				<td> 날짜 </td>
				<td> 조회수 </td>
			</tr>
<%	if(v.isEmpty()){	%>
		<tr><td colspan="5">
			<div align="center"><b>등록된 글이 없습니다.</b></div></td></tr>
<%
	}	else{
		for(int i=beginPerPage; i<beginPerPage + numPerPage; i++){
			if(i == totalRecord)
				break;
			dto = (BoardDto) v.get(i);
			pageContext.setAttribute("dto", dto);
%>

			<tr align="center">
				<td><%=dto.getNum() %></td>
				<td align="left">
					<%=dao.useDepth(dto.getDepth())%>
					<%if(dto.getDepth() > 0){ %>
						<img src="/TotalSite/images/re.gif"	/>
					<% } %>
					<a href="javascript:fnRead('<%=dto.getNum()%>')">
						<%=dto.getSubject() %></a></td>
				<td><%=dto.getName() %></td>
				<td><%=dto.getRegdate() %></td>
				<td><%=dto.getCount() %></td>
			</tr>
<%
		}
	}
%>
		</table>
	</td>
</tr>
<tr>
	<td><BR><BR></td>
</tr>
<tr>
	<td align="left">Go to Page 
	<%
		if(nowBlock > 0){
	%>
			&nbsp;&nbsp; <a href="List.jsp?nowPage=<%=(nowBlock - 1) * pagePerBlock%>&nowBlock=<%=nowBlock - 1%>">
				이전</a>::: &nbsp;&nbsp;
	<%
		}
	%>
	
	<%
		for(int i=0; i<pagePerBlock; i++){
			if((nowBlock*pagePerBlock) + i == totalPage)
				break;
	%>
			<a href="List.jsp?nowPage=<%=(nowBlock  * pagePerBlock) + i %>&nowBlock=<%=nowBlock%>">
					<%= i+1 + (nowBlock * pagePerBlock) %></a>&nbsp;&nbsp;
	<%
		}
	%>
	
	<%
		if(totalBlock > nowBlock + 1){
%>
			&nbsp;&nbsp;:::<a href="List.jsp?nowPage=<%=(nowBlock + 1) * pagePerBlock %>&nowBlock=<%=nowBlock + 1%>">다음</a>
<%
		}
	%>
	</td>
	<td align=right>
		<a href="Post.jsp">[글쓰기]</a>
		<a href="javascript:list()">[처음으로]</a>
	</td>
</tr>
</table>
<BR>
<form action="List.jsp" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="name" 
					<%if(keyField.equals("name")){%> selected="true"	<%}%>	> 이름</option>
				<option value="subject" 
					<%if(keyField.equals("subject")){%> selected="true"	<%}%>	> 제목
				<option value="content" 
					<%if(keyField.equals("content")){%> selected="true"	<%}%>	> 내용
			</select>

			<%-- <input type="text" size="16" name="keyWord" value='<%=getParam(request, "keyWord")%>'> --%>
			<input type="text" size="16" name="keyWord" value='<%=keyWord%>'>
			<input type="button" value="찾기" onClick="check()">
			<input type="hidden" name="page" value= "0">
		</td>
	</tr>
	</table>
</form>

<form name="read" method="post" action="Read.jsp">
	<input type="hidden" name="num" 	/>
	<input type="hidden" name="keyFiled" value="<%=keyField%>"	/>
	<input type="hidden" name="keyWord" value="<%=keyWord%>"		/>
</form>
</BODY>
</HTML>