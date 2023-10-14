<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="UTF-8">
  <link href="/css/myPageCSS/myPage.css" rel="stylesheet">
  <script src="/js/myPageJS/myPage.js" defer></script>
  <title>마이 페이지</title>

</head>
<body>
<jsp:include page="../../inc/header.jsp"/>

<div class="profile">
  <h3 class="display-5"> <%-- 프로필 --%>
    <a class="profile-link" href="/modify.member?action=modify&memberId=${loginInfo.memberId}">프로필 <input type="button" value="프로필 수정" class="button"></a>
  </h3>
  <form name="frmMypage" action="/modify.mypage?action=mypage" method="post">
    <div class="profileInfo">
      <label class="col-sm-2">아이디 ${loginInfo.memberId}</label>
      <label class="col-sm-2">이름 ${loginInfo.name}</label>
      <label class="col-sm-2">닉네임 ${loginInfo.nickName}</label>
      <label class="col-sm-2" id="zzimh"><p>찜 &nbsp;</p>
        <i class="fa-solid fa-heart fa-1x heart"></i> &nbsp;<p>${loginInfo.zzimCnt}</p>
      </label>
    </div>
  </form>
</div>
<div class="tab-item"> <!-- 마이페이지 탭 메뉴 부분 -->
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="mytab-link active" href="#tab1">내가 쓴 글</a>
    </li>
    <li class="nav-item">
      <a class="mytab-link" href="#tab2">내가 쓴 댓글</a>
    </li>
    <li class="nav-item">
      <a class="mytab-link" href="#tab3">내가 쓴 리뷰</a>
    </li>
    <li class="nav-item">
      <a class="mytab-link" href="#tab4">내가 찜한 영화</a>
    </li>
  </ul>

  <!-- "내가 쓴 글" -->
  <div class="tab-content" id="tab1">
    <div class="myContent">
      <div class="button1">
        <!-- 기능 편의 버튼 -->
        <input type="button" class="btn-checkAll1" value="전체 선택">
        <input type="button" class="btn-removeAll1"  value="전체 삭제">
        <input type="button" class="btn-selected1"  value="선택 삭제">
      </div>
        <form name="frmRemoveSelected1" method="post">
          <ul class="list-group-1">
            <c:forEach var="boardDTO" items="${boardDTOList}" varStatus="status">
              <li>
                <div class="flex_my">
                <form action="#" >
                  <!--label 태그는 체크박스를 누르지 않아도 연결된 체크박스를 체크해줌-->
                  <label for="chk${boardDTO.contentNo}">
                    <input type="checkbox" name="selectedItems1" class="button chkButton" value="${boardDTO.contentNo}" id="chk${boardDTO.contentNo}">
                    <i class="circle"></i>
                  </label>
                </form>
                    <a href="get.board?action=get&contentNo=${boardDTO.contentNo}" class="text-decoration-none" type="hidden">
                      <p class="myList" > ${boardDTO.title}
                          ${boardDTO.addDate}
                          ${boardDTO.nickName}
                          ${boardDTO.hit}
                        <a href="./remove.board?action=remove&contentNo=${boardDTO.contentNo}"
                           class="remove-btn" style="font-size: 30px">X</a>
                      </p>
                    </a>
                </div>
              </li>
            </c:forEach>
          </ul>
        </form>
    </div>
  </div>

  <!-- "내가 쓴 댓글" -->
  <div class="tab-content" id="tab2">
    <div class="myComment">
      <div class="button1">
        <!-- 기능 편의 버튼 -->
        <input type="button" class="btn-checkAll2"  value="전체 선택">
        <input type="button" class="btn-removeAll2"  value="전체 삭제">
        <input type="button" class="btn-selected2" value="선택 삭제">
      </div>
        <form name="frmRemoveSelected2" method="post">
          <ul class="list-group-2">
            <c:forEach var="commentDTO" items="${commentDTOList}" varStatus="status">
              <li>
                <div class="flex_my">
                <form action="#" >
                  <!--label태그는 체크박스를 누르지 않아도 연결된 체크박스를 체크해줌-->
                  <label for="chk${commentDTO.commentNo}">
                    <input type="checkbox" name="selectedItems2" class="button chkButton" value="${commentDTO.commentNo}" id="chk${commentDTO.commentNo}">
                    <i class="circle"></i>
                  </label>
                </form>
                    <a href="get.board?action=get&contentNo=${commentDTO.contentNo}" class="text-decoration-none" >
                       <p class="myList"> ${commentDTO.commentNo}
                           ${commentDTO.addDate}
                           ${commentDTO.nickName}
                      <a href="./remove.board?action=remove&contentNo=${commentDTO.commentNo}"
                         class="remove-btn" style="font-size: 30px">X</a>
                       </p>
                    </a>
                </div>
              </li>
            </c:forEach>
          </ul>
        </form>
    </div>
  </div>

  <!-- "내가 쓴 리뷰" -->
  <div class="tab-content" id="tab3">
    <div class="myReview">
      <div class="button1">
        <!-- 기능 편의 버튼 -->
        <input type="button" class="btn-checkAll3"  value="전체 선택">
        <input type="button" class="btn-removeAll3" value="전체 삭제">
        <input type="button" class="btn-selected3"  value="선택 삭제">
      </div>
        <form name="frmRemoveSelected3" method="post">
          <ul class="list-group-3">
            <c:forEach var="reviewDTO" items="${reviewDTOList}" varStatus="status">
              <li>
                <div class="flex_my">
                <form action="#">
                  <!--label태그는 체크박스를 누르지 않아도 연결된 체크박스를 체크해줌-->
                  <label for="chk${reviewDTO.reviewNo}">
                    <input type="checkbox" name="selectedItems3" class="button chkButton" value="${reviewDTO.reviewNo}" id="chk${reviewDTO.reviewNo}">
                    <i class="circle"></i>
                  </label>
                </form>
                    <a href="view.movie?action=view&movieNo=${reviewDTO.movieNo}" class="text-decoration-none" >
                      <p class="myList"> ${reviewDTO.review}
                          ${reviewDTO.addDate}
                          ${reviewDTO.nickName}
                        <a href="./remove.movie?action=remove&movieNo=${reviewDTO.movieNo}"
                           class="remove-btn" style="font-size: 30px">X</a>
                      </p>
                    </a>
                  </div>
              </li>
            </c:forEach>
          </ul>
        </form>
      </div>
  </div>

  <div class="tab-content" id="tab4">
    <!-- "내가 찜한 영화" -->
    <div class="Zzim">
        <c:forEach var="movieDTO" items="${zzimMovieList}" varStatus="status">
            <li class="list-group-zzim">
              <a href="view.movie?action=view&movieNo=${movieDTO.movieNo}" class="text-decoration-4" >
                    <img src="${movieDTO.poster}" alt="영화 이미지">
              <p>${movieDTO.movieName}</p>
              </a>
            </li>
            <c:if test="${status.index % 4 == 3}">
            <div class="margin-img"></div>
            </c:if>
        </c:forEach>
    </div>
  </div>
</div>
<jsp:include page="../../inc/footer.jsp"/>

</body>
</html>