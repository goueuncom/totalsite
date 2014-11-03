<%@ page contentType="text/html; charset=EUC-KR" %>
<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:useBean id="dao" class="totalsite.board.BoardDao"		/>
<jsp:useBean id="dto" class="totalsite.board.BoardDto"		/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	dto = dao.getBoard(num);
%>

<center>
<br><br>
<table width=80% cellspacing=0 cellpadding=3>
 <tr>
  <td bgcolor=84F399 height=25 align=center>답변쓰기</td>
 </tr>
</table>
<br>
<table width=80% cellspacing=0 cellpadding=3 align=center>
<form name=post method=post action="ReplyProc.jsp" >

<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>"		/>
<input type="hidden" name="num" value="<%=num%>"		/>

 <tr>
  <td align=center>
   <table border=0 width=100% align=center>
    <tr>
     <td width=10%>성 명</td>
     <td width=90%><input type=text name=name size=10 maxlength=8></td>
    </tr>
    <tr>
	 <td width=10%>E-Mail</td>
	 <td width=90%><input type=text name=email size=30 maxlength=30></td>
    </tr>
    <tr>
     <td width=10%>홈페이지</td>
     <td width=90%><input type=text name=homepage size=40 maxlength=30></td>
    </tr>
    <tr>
     <td width=10%>제 목</td>
     <td width=90%><input type=text name=subject size=50 maxlength=30></td>
    </tr>
    <tr>
     <td width=10%>내 용</td>
     <td width=90%><textarea name=content rows=10 cols=50>
답변 : ------------------
<br/><%=dto.getContent()%></textarea></td>
    </tr>
    <tr>
     <td width=10%>비밀 번호</td> 
     <td width=90% ><input type=password name=pass size=15 maxlength=15></td>
    </tr>
    <tr>
     <td colspan=2><hr size=1></td>
    </tr>
    <tr>
     <td><input type=submit value="등록" >&nbsp;&nbsp;
         <input type=reset value="다시쓰기">&nbsp;&nbsp;
     </td>
    </tr> 
   </table>
  </td>
 </tr>
</form> 
</table>
</center>
</body>
</html>