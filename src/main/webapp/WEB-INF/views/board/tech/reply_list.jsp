<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<%@ include file="../../include/common.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>

function replyLikeUp(replyNo){

	var param="${_csrf.parameterName}=${_csrf.token}&likeStatus=likeUp&replyNo="+replyNo;
	
	$.ajax({
		type: "post",
		url: "${pageContext.request.contextPath}/reply/tech/changeLike",
		data: param,
		success: function(result){
			
			//alert("likeUp ajax result:"+result);
			
			$("#cntReplyLike"+replyNo).html(result);
			
		}
		
	});
	
	
	
}	

function replyLikeDown(replyNo){
	
	var param="${_csrf.parameterName}=${_csrf.token}&likeStatus=likeDown&replyNo="+replyNo;
	
	$.ajax({
		type: "post",
		url: "${pageContext.request.contextPath}/reply/tech/changeLike",
		data: param,
		success: function(result){
			
			//alert("likeDown ajax result:"+result);
			
			$("#cntReplyLike"+replyNo).html(result);
			
		}
		
	});
	

}	
	
	
 function showModify(replyNo){
	//alert("수정시작");
	var replytext=$('span[title=modifyResult'+replyNo+']').html();
	//$('span[title='+replyNo+']').html('<input type="text"  id="reply'+replyNo+'" size="50" value="'+replytext+'" />');
	  $('span[title=modifyResult'+replyNo+']').html('<textarea rows="5" cols="80" id="reply'+replyNo+'" >'+replytext+' </textarea>');
	//버튼변경하기
	$('a[id=modify'+replyNo+']').hide();
	$('a[id=deleteReply'+replyNo+']').hide();
	$('input[name=modifyDo'+replyNo+']').show();
	$('a[id=modifyCancel'+replyNo+']').show();
	
	
}  


 



 function modify(replyNo){
		
		var replytext=$('#reply'+replyNo+'').val();
		
		 var param="${_csrf.parameterName}=${_csrf.token}&replytext="+replytext+"&replyNo="+replyNo;
		 $.ajax({
				type: "post",
				url: "${pageContext.request.contextPath}/reply/tech/update",
				data: param,
				success:function(result){
					//alert("result:"+result.replyText);
					$('span[title=modifyResult'+replyNo+']').html(result.replyText); 
					
				}
			}); 
		 
		//버튼변경하기
			$('a[id=modify'+replyNo+']').show();
			$('a[id=deleteReply'+replyNo+']').show();
			$('input[name=modifyDo'+replyNo+']').hide();
			$('a[id=modifyCancel'+replyNo+']').hide();
		
	}  
 
 
 function modifyCancel(replytext,replyNo){
	 
	 
		 $('a[id=modify'+replyNo+']').show();
		 $('a[id=deleteReply'+replyNo+']').show();
		$('input[name=modifyDo'+replyNo+']').hide();
		$('a[id=modifyCancel'+replyNo+']').hide();
		
		$('span[title=modifyResult'+replyNo+']').html(replytext);
		
		
	}  
 
 function deleteReply(replyNo,boardNo){
		
		if(confirm("정말 삭제하시겠습니까?")){
			
			 var param="${_csrf.parameterName}=${_csrf.token}&replyNo="+replyNo+"&boardNo="+boardNo;
			 $.ajax({
					type: "post",
					url: "${pageContext.request.contextPath}/reply/tech/delete",
					data: param,
					success:function(){
						listReply();
					}
				}); 
	
		}

	}  

</script>
<style>
#modifyDo{display:none;}
.modifyCancel{display:none;}
.replyCancel{display:none;}
#replyInsertBtn{display:none;}
table {border:1px solid #000;}
</style>
</head>
<body>

<c:forEach var="row"  items="${list}">
<table style="width:700px; " >
  <tr>
  	<td  nowrap algin="left">
  	 <img id="profile" src="${path}/resources/upload/${row.member.imgProfile}">
  	 ${row.member.userId}
  	 <span style="font-size:10px">(${row.regdate}  ) </span> 
  	<img  src="${path}/resources/img/arrowUp.png" style="width:20px; height:20px;cursor:pointer;float:right; " onclick="replyLikeUp('${row.replyNo}')" ><br>
	<span id="cntReplyLike${row.replyNo}" style="width:20px; height:20px;cursor:pointer;float:right; ">${row.cntReplyLike}</span><br><br>
	<img  src="${path}/resources/img/arrowDown.png" style="width:20px; height:20px;cursor:pointer;float:right;" onclick="replyLikeDown('${row.replyNo}')">
  	  <br>
  	</td>
   </tr>	
  
 <tr>
 <td  nowrap >
 	<span id="modifyResult" title="modifyResult${row.replyNo}" > ${row.replytext} </span><br>
  	 <!-- 본인의 댓글만 수정,삭제가 가능하도록 처리 -->
  	 <sec:authorize access="isAuthenticated()">
  	 <sec:authentication var="mvo" property="principal" /> 
  	 <c:if test="${mvo.userId == row.member.userId}">

  <a href=# id="deleteReply${row.replyNo}" style="color:red; float:right;text-decoration:none;font-size:10px;" onclick="deleteReply('${row.replyNo}','${row.boardNo}')">삭제 </a> 
  <a href="#" id="modify${row.replyNo}" style="float:right;text-decoration:none;font-size:10px;" onclick="showModify('${row.replyNo}')" >수정 &nbsp;|&nbsp;</a> 
   <input type="button" value="수정" name="modifyDo${row.replyNo}" id="modifyDo" style="width:70px;height:30px;" onclick="modify('${row.replyNo}')">
   <a href="#" id="modifyCancel${row.replyNo}" class="modifyCancel" style="color:red;text-decoration:none;font-size:10px;" onclick="modifyCancel('${row.replytext}','${row.replyNo}')">수정취소</a>
   
   </c:if>
   </sec:authorize>
   <br>

  
  	</td>
  	
  </tr>
  
</table>
</c:forEach>



</body>
</html>