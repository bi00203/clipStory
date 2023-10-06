<%@ page import="java.util.List" %>
<%@ page import="com.example.movie.model.dao.BoardDAO" %>
<%@ page import="com.example.movie.model.dao.CommentDAO" %>
<%@ page import="com.example.movie.model.dto.BoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="currentTime" class="java.util.Date" />
<%
    List boardDTOList = (List) request.getAttribute("boardDTOList");
    int totalRecord = (Integer) request.getAttribute("totalRecord");
    int pageNum = (Integer) request.getAttribute("pageNum");
    int totalPage = (Integer) request.getAttribute("totalPage");
    int limit = (Integer) request.getAttribute("limit");

    int startNum = (Integer) request.getAttribute("startNum"); // 페이지 시작 일련번호

    String items = request.getParameter("items") != null ? request.getParameter("items") : "title";
    String text = request.getParameter("text") != null ? request.getParameter("text") : "";

    int pagePerBlock = 5; // 페이지 범위
    int totalBlock = totalPage % pagePerBlock == 0 ? totalPage / pagePerBlock : totalPage / pagePerBlock + 1; // block의 전체 갯수(페이지 범위 단위의 총 갯수)
    int thisBlock = ((pageNum -1) / pagePerBlock) + 1; // 현재 블럭
    int firstPage = ((thisBlock -1) * pagePerBlock) + 1; // 블럭의 첫 페이지
    int lastPage = thisBlock * pagePerBlock; // 블럭의 마지막 페이지
    lastPage = (lastPage > totalPage) ? totalPage : lastPage;

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <title>게시판 목록</title>
</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="container w-75 mt-5 mx-auto">
    <h2>게시판 목록</h2>
    <hr>
    <ul class="list-group">
        <c:forEach var="boardDTO" items="${boardDTOList}" varStatus="status">
            <%-- 현재시간 , 작성시간 구하기 --%>
            <fmt:parseNumber value="${currentTime.time / (1000*60*60)}" integerOnly="true" var="currentFmtTime" scope="request"/>
            <fmt:parseNumber value="${boardDTO.addDate.time / (1000*60*60)}" integerOnly="true" var="addFmtTime" scope="request"/>
            <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <p style="text-align: right">
                    <c:if test="${(currentFmtTime - addFmtTime) < 24}"> <%-- 현재시간-작성시간 24시간 미만이면 N표시 뜨게함 --%>
                        <span style="color: blue; font-weight: bold">N</span>
                        <c:if test="${boardDTO.hit > 10}"> <%-- 24시간 미만이고 조회수가 10이상이면 H표시 --%>
                            <span style="color: red; font-weight: bold">H</span>
                        </c:if>
                    </c:if>
                <a href="get.board?action=get&contentNo=${boardDTO.contentNo}" class="text-decoration-none">
                    [<%=(totalRecord--)-(pageNum-1)*limit%>] ${boardDTO.title} (${boardDTO.cnt})<%--( 댓글수 )--%>
                </a>
                <p>${boardDTO.addDate}</p>
                <p style="text-align: right">${boardDTO.nickName}</p>
                <p style="text-align: right">${boardDTO.hit}</p>
            </li>
            <%
                startNum--;
            %>
        </c:forEach>
    </ul>
    <hr>
    <div align="center" class="paging">
        <a href="<c:url value="list.board?action=list&pageNum=1"/>"><span>첫페이지</span></a>
        <%
            if(thisBlock > 1) {
        %>
        <a href="list.board?action=list&pageNum=<%=(firstPage - 1)%>"><span> < 이전 </span></a>
        <%
            }
        %>
        <c:set var="pageNum" value="<%=pageNum%>" />
        <c:forEach var="i" begin="<%=firstPage%>" end="<%=lastPage%>">
            <a href="pageNum.board?action=list&pageNum=${i}">
                <c:choose>
                    <c:when test="${pageNum==i}"> <!--현재 페이지이면 볼드처리 -->
                        <span style="color: #4C5317; font-weight: bold">[${i}]</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #4C5317;">[${i}]</span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:forEach>
        <%
            if(thisBlock < totalBlock) {
        %>
        <a href="list.board?action=list&pageNum=<%=(lastPage + 1)%>"><span> 다음 ></span> </a>
        <%
            }
        %>
        <a href="<c:url value="list.board?action=list&pageNum=${totalPage}"/>"><span>끝페이지</span></a>
    </div>
<%--    <div align="center">--%>
<%--        <c:set var="pageNum" value="<%=pageNum%>" />--%>
<%--        <c:forEach var="i" begin="1" end="<%=totalPage%>">--%>
<%--            <a href="pageNum.board?action=list&pageNum=${i}">--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${pageNum==i}"> <!--현재 페이지이면 볼드처리 -->--%>
<%--                        <font color="4C5317"><b> [${i}]</b></font>--%>
<%--                    </c:when>--%>
<%--                    <c:otherwise>--%>
<%--                        <font color="4C5317"> [${i}]</font>--%>
<%--                    </c:otherwise>--%>
<%--                </c:choose>--%>
<%--            </a>--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
    <c:if test="${error != null}">
        <div class="alert alert-danger alert-dismissible fade show mt-3">
            에러 발생 : ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <button class="btn btn-outline-info mb-3" type="button" onclick="location.href='add.board?action=add'">글 쓰기</button>
    <div align="left">
        <form name="frmList" action="./list.board?action=list" method="get">
            <input type="hidden" name="pageNum" value="<%=pageNum%>">
            <input type="hidden" name="num">
            <table>
                <tr>
                    <td width="100%" align="left">
                        <select name="items" class="txt">
                            <option value="title" <% if(items.equals("title")){%>selected<%}%>>제목</option>
                            <option value="content" <% if(items.equals("content")){%>selected<%}%>>내용</option>
                            <option value="nickName" <% if(items.equals("nickName")){%>selected<%}%>>닉네임</option>
                        </select>
                        <input name="text" type="text" value="<%=text%>"/>
                        <input type="button" id="btn-search" class="btn btn-primary" value="검색"/>
                        <input type="button" id="btn-reset" class="btn btn-secondary" value="취소"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
<%--    <div class="collapse" id="addForm">--%>
<%--        <div class="card card-body">--%>
<%--            <form method="post" action="./add.board?action=add">--%>
<%--                <label class="form-label">제목</label>--%>
<%--                <input type="text" name="title" class="form-control">--%>
<%--                <label class="form-label">내용</label>--%>
<%--                <textarea cols="50" rows="5" name="content" class="form-control"></textarea>--%>
<%--                <input type="text" name="memberId" class="form-control" value="테스트 멤버아이디" hidden>--%>
<%--                <input type="text" name="nickName" class="form-control" value="테스트 닉네임" hidden>--%>
<%--                <button type="submit" class="btn btn-success mt-3">저장</button>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
</div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        //페이징 영역의 a태그를 클릭할 때 a 태그의 기능을 막고, 폼을 적용
        const btnPaging = document.querySelectorAll('.paging a');
        const frmList = document.querySelector('form[name=frmList]');
        btnPaging.forEach(btn => {
            btn.addEventListener('click', function (e){
                e.preventDefault(); // a링크 막음
                frmList.pageNum.value = e.target.parentNode.href.split('?')[1].split('&')[1].split('=')[1];
                frmList.action = 'list.board';
                console.log(e.target);
                frmList.submit();
            }, false);
        });
        // 검색 클릭시 검색 조건은 그대로, 1페이지로 이동
        const  btnSearch = document.querySelector('#btn-search');
        btnSearch.addEventListener('click', function (){
            frmList.pageNum.value=1;
            frmList.submit();
        });

        const btnReset = document.querySelector('#btn-reset');
        btnReset.addEventListener('click', function (){
            frmList.pageNum.value = 1;
            frmList.items.value = 'subject';
            frmList.text.value = '';
            frmList.submit();
        });
    });
</script>
</html>