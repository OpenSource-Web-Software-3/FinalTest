<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="communication.CommunicationDTO" %>
<%@ page import="comment.CommentDAO" %>
<% String  absolutePath_commu = request.getContextPath()+"/Web-source";%>
<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <script src="<%= absolutePath_commu%>/js/communication.js" defer></script>
		
        <!-- css -->
        <link rel="stylesheet" href="<%= absolutePath_commu %>/css/commu-list-style.css" />
        <link rel="stylesheet" href="<%= absolutePath_commu %>/css/aside-style.css" />
		<%@include file="../head-tags.jsp" %>
        
		<title>커뮤니티 | licenseName</title>
	</head>
	<body>
	
		<%
			ArrayList<CommunicationDTO> commuList = (ArrayList<CommunicationDTO>) request.getAttribute("commuList");
			
			String category = null;
			if(request.getParameter("category") != null) category = request.getParameter("category");
			CommentDAO commentDao = new CommentDAO();
			
		%>
		
	   <!-- 게시글을 보여주는 영역 -->
	   <section class="set-margin commu-list">
	       <!-- 자격증 이름 -->
	       <div class="license-name"><%=category %></div>
	       <!-- 정렬, 검색어, 글쓰기를 하나의 div로 묶음 -->
	       <div class="input-wrap">
	           <!-- 검색어, 정렬 기준 선택 -->
	           <ul class="text">
	               <li>
	                   <!-- 정렬기준 -->  <!-- value 공백이어야 합니다 -->
	                   <select name="sortStandard" id="sort-standard">
	                       <option value="" class="default">정렬기준</option>
	                       <option value="title">제목</option>
                           <option value="latest">최신</option>
                           <option value="user">작성자</option>
                           <option value="scrapCount">인기순(스크랩)</option>	                       
	                   </select>
	               </li>
	               <li>
	                   
                       <!-- 서브 카테고리 -->  <!-- value 공백이어야 합니다 -->
                       <select name="sub-category" id="sub-category">
                           <option value="" class="default">주제</option>
                           <option value="free">자유</option>
                           <option value="review">시험 후기</option>
                           <option value="study">공부</option>
                       </select>
                   </li>
	               <li>
	                   <input type="text" id="search" placeholder="검색어 입력"/>
	               </li>
	           </ul>
	           <button class="writeBtn" onclick = "location.href = '<%= absolutePath_commu%>/community/write.jsp?category=<%=category%>'">글쓰기</button>
	       </div>
	       <!-- 게시글 list -->
	       <ul class="list">
              <!-- 임시적으로 9개로 제한 (아마 9개로 갈 거 같습니다.) -->
              <% for(int i = 0; i < commuList.size(); i++) { %>
               <li class="items">
                   <!-- 시험일정 정보  -->
                   <a href="<%=absolutePath_commu %>/community/read.jsp?category=<%=category%>&writingID=<%=commuList.get(i).getWritingID() %>" class="url">             
                       <div class="writing">
                           <span class="title"><%=commuList.get(i).getTitle() %></span>
                           <span class="writer-info"><%=commuList.get(i).getNickName() %> | <%=commuList.get(i).getCommuDate() %></span>
                       </div>
                   </a>
                   <div class="writing-info">
                       <div class="view">
	                       <i class="far fa-eye"></i>
	                       <span class="count"><%=commuList.get(i).getView() %></span>
                       </div>
                       <div class="comment">
	                       <i class="far fa-comment-dots"></i>
	                       <span class="count"><%=commentDao.getAllComment(commuList.get(i).getWritingID()) %></span>
                       </div>
                   </div>
               </li>
               <% } %>
           </ul> 
	   </section>
	   
       <!-- aside -->
       <%@include file="../aside.jsp" %>
	</body>
</html>