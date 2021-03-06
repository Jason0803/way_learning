<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="../../include/common.jsp" %>
</head>
<script>
$(document).ready(function() {

	listReply(); //댓글 목록
	
		
	
		$('#btnReply').click(function(){
			
		
			reply(); 
			
			 
		});
	
	
		//댓글 쓴거 전송 
		//텍스트와,bno, 비밀글 여부를 insert.do의 파라미터값으로 넣음
		function reply(){
			var replytext=$("#replytext").val();
			var boardNo="${requestScope.bvo.boardNo}"; // view 컨트롤러에서 가져옴!
			//비밀댓글 체크 여부
			
		
			
		//var param과, data:param 삭제하고 url에  "${path}/reply/insert.do?replytext="+replytext+"&bno="+bno+"&secret_reply="+secret_reply,  이렇게 써도됨!!
				
			var param="${_csrf.parameterName}=${_csrf.token}&replytext="+replytext+"&boardNo="+boardNo;
			
			$.ajax({
				type: "post",
				url: "${pageContext.request.contextPath}/reply/tech/insert",
				data: param,
				success: function(){
					
					alert("댓글이 등록되었습니다.");
					
					listReply(); //이거안하면 새로고침해야 쓴게 나옴!!!
				}
				
			});
			$("#replytext").val("");
			
		}
	
});
			
	//댓글 불러오는 방식
	function listReply(){
		
		$.ajax({
			type:"get",
			url: "${pageContext.request.contextPath}/reply/tech/list?boardNo=${requestScope.bvo.boardNo}",  //url방식으로 보내기!! url 밑에 param: 해서 정의 안함!!!!
			success: function(result){
				$("#listReply").html(result);
				
				console.log(result);
			}
		});
	 }
	


function deleteBoard(){
	if(confirm("해당 글을 삭제하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/board/tech/delete?boardNo=${requestScope.bvo.boardNo}";
	}
	
}

function updateBoard(){
	if(confirm("해당 글을 수정하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/board/tech/updateView?boardNo=${requestScope.bvo.boardNo}";
	}
}

/* function showModify(rno){
	alert("gg");
	$('#modifyResult').html('<input type="text"  id="reply"  value="ddddddd" />');
	
	

}  */

function boardLikeUp(){

	var param="${_csrf.parameterName}=${_csrf.token}&boardNo=${requestScope.bvo.boardNo}&likeStatus=likeUp";
	
	$.ajax({
		type: "post",
		url: "${pageContext.request.contextPath}/board/tech/changeLike",
		data: param,
		success: function(result){
			
			//alert("likeUp ajax result:"+result);
			
			$("#cntBoardLike").html(result);
			
		}
		
	});
	
	
	
}	

function boardLikeDown(){
	
var param="${_csrf.parameterName}=${_csrf.token}&boardNo=${requestScope.bvo.boardNo}&likeStatus=likeDown";
	
	$.ajax({
		type: "post",
		url: "${pageContext.request.contextPath}/board/tech/changeLike",
		data: param,
		success: function(result){
			
			//alert("likeDown ajax result:"+result);
			
			$("#cntBoardLike").html(result);
			
		}
		
	});
	

}	


/**
* Resize height of (outer) editor frame to match inner height of contents
* @param fckEditor = editor instance reference
* @param min = minimum height (in pixels)
* @param max = maximum height
*/
/* function resizeHeightToContents(CKEDITOR, min, max) {
var frameHeight = CKEDITOR.EditorWindow.parent.innerHeight; //outer frame which includes menu bar
var editHeight = CKEDITOR.EditorWindow.innerHeight; //inner content frame
var contentHeight = CKEDITOR.EditorDocument.body.offsetHeight;
var heightDiff = contentHeight - editHeight;
if ((heightDiff < 0) && (frameHeight > min)) {
//shrink editor frame
frameHeight += heightDiff;
if (frameHeight < min) frameHeight = min;
CKEDITOR.EditorWindow.parent.frameElement.style.height = frameHeight;
}
else if ((heightDiff > 0) && (frameHeight < max)) {
//expand editor frame
frameHeight += heightDiff;
if (frameHeight > max) frameHeight = max;
CKEDITOR.EditorWindow.parent.frameElement.style.height = frameHeight;
}
} */



</script>


<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>




<style>

    .cke_top
    {
        display: none !important;
    }

.cke_bottom {display: !important;}
#profile{width:50px; height:50px; border-radius: 50% }
a{text-decoration:none; cursor: pointer;}
#tag{font-size:10px;border:1px solid grey;border-radius:10%; background-color:grey; color:white; margin-left:10px;}

</style>




<body>
<h2 align="center"><b>게시글</b></h2>
${delete_result}
	<div align="center">
	
	
	
					<table border="1" width="650" align="center">


						<tr>
							<td><img id="profile" src="${path}/resources/upload/${bvo.member.imgProfile}">
							${requestScope.bvo.member.userId} <br> <span
								style="font-size: 10px"><fmt:formatDate value="${bvo.regDate}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>${requestScope.bvo.cntView} ${requestScope.bvo.cntReply} </td>
						</tr>
						
						<tr>

							<td colspan="4">
							번호:${requestScope.bvo.boardNo}  
							<c:forEach var="tag" items="${tagList}">
									<span id="tag" >${tag.TAG}</span>
							
							</c:forEach>
							
							<br>
							제목:${requestScope.bvo.title}
							</td>
							<td>
							<img  src="${path}/resources/img/arrowUp.png" style="width:20px; height:20px;cursor:pointer; " onclick="boardLikeUp()" ><br><br>
							<span id="cntBoardLike" >${bvo.cntBoardLike}</span><br><br>
							<img  src="${path}/resources/img/arrowDown.png" style="width:20px; height:20px;cursor:pointer;" onclick="boardLikeDown()">
							
							</td>

						</tr>
						
						<tr>

							<td colspan="4">
							<textarea id="content" name="content" rows="3" cols="80" placeholder="내용을 입력하세요" >${requestScope.bvo.content}</textarea>
								<script>
			          CKEDITOR.replace("content",{  removePlugins : 'elementspath' , resize_enabled : false, readonly:true }); // 태그의 id
			          CKEDITOR.on('instanceLoaded', function(e){e.editor.resize(700, 700)});

			        
			          
		                        </script> 
							
							</td>
							<td>&nbsp;</td>

						</tr>

					</table>

							<a
								href="${pageContext.request.contextPath}/board/tech/list?keyword=${keyword}"><img
									alt="목록"
									src="${pageContext.request.contextPath}/resources/img/list_btn.jpg"></a>
								<!-- 현재 로그인한 사람이 자신의 글 상세보기 할때는 삭제와 수정버튼이 보여지도록 작성하면됨! --> <sec:authorize
									access="isAuthenticated()">
									<sec:authentication var="mvo" property="principal" />


									<c:if test="${mvo.userId == requestScope.bvo.member.userId }">
										<img alt="삭제"
											src="${pageContext.request.contextPath}/resources/img/delete_btn.jpg"
											onclick="deleteBoard()">
										<img alt="수정"
											src="${pageContext.request.contextPath}/resources/img/modify_btn.jpg"
											onclick="updateBoard()">
									</c:if>
								</sec:authorize>
				
	<!--  댓글 작성하는 양식  form 안씀-->
	
	
	<!-- 댓글목록 출력 -->
	<div id=listReply></div>
	
	
	<div style="text-align: center;  ">
		<br>
		<sec:authorize access="isAuthenticated()">
			<textarea rows="5" cols="80" id="replytext" placeholder="댓글을 작성하세요"></textarea>
			<br>
		
			<button type="button" id="btnReply">댓글쓰기</button>
		</sec:authorize>
	</div>
	
	</div>
</body>
</html>






























