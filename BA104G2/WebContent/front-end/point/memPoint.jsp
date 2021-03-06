<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.value_record.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<jsp:useBean id="MemProSvc" class="com.member_profile.model.MemberProfileService"/>




<head>
<title>我的點數儲值資訊</title>
<style>
.alert-infoeric {
    color: #fcf8e3;
    background-color: #3c9682;
    
}
</style>


</head>

<jsp:include page="/front-end/member_top.jsp" flush="true" />
<jsp:include page="/front-end/coupon_notify.jsp" />


<body >

<%	

	ValueRecordService valueRecordSvc = new ValueRecordService ();
		List<ValueRecordVO> list = new ArrayList<ValueRecordVO>();
		String mem_num = (String)session.getAttribute("mem_num");
		list = valueRecordSvc.getMyRecord(mem_num);
		request.setAttribute("valueRecordSvc", list);

%>
<center>

		
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>




<div class="container">
    <div class="row">
        <div class="col-md-12">
             <h3><div class="alert alert-infoeric">
         	       目前點數餘額：　 ${MemProSvc.getOneMemInfo(mem_num).rem_point} </div></h3>
            <div class="alert alert-success" style="display:none;">
                <span class="glyphicon glyphicon-ok"></span> Drag table row and cange Order</div>
            <table class="table">
                 <tbody>   
                    <tr align='center' valign='middle'>
                    <td>儲值編號</td>
					<td>儲值時間</td>
					<td>儲值金額</td>     
                    </tr>
                 
     
	<c:forEach varStatus="valuecount" var="valueRecordVO" items="${valueRecordSvc}">
		<tr align='center' valign='middle' <c:if test="${valuecount.count%2!=0}" > class="success"</c:if> > <!--將修改的那一筆加入對比色而已-->
			<td>${valueRecordVO.value_num}</td>
			<td><fmt:formatDate value="${valueRecordVO.value_date}" pattern="yyyy/MM/dd HH:mm:ss"/></td>		
			<td>${valueRecordVO.value_cash}</td>			
		</tr>
	</c:forEach>
       <c:if test="${valueRecordSvc.isEmpty()}">
       	<div class="text-center" style="color:red; font-size:100px;">暫無資料!!</div>
       </c:if>             
                 
                            
                </tbody>
            </table>
        </div>
    </div>
</div>




</center>
<jsp:include page="/front-end/member_foot.jsp"  flush="true" />

</body>

</html>