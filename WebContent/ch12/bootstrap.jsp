<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String title="dttd"; %>
<jsp:include page="/_template/header.inc.jsp" flush="false"/>
 


<div class="container">
   <div class="card form-control">
      <p>글쓰기</p>
      <form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave(this)">
      <input type="hidden" name="num">
      <input type="hidden" name="ref">
      <input type="hidden" name="re_step">
      <input type="hidden" name="re_level">
      
      <table class="table table-bordered table-striped">
         <tr>
          <th colspan="4"><a href="list.jsp">글목록</a></th>
         </tr>
            <tr>
             <th>아이디</th>
         <%
            String id ="";
            try{
               id = (String)session.getAttribute("id");
               if(id==null || id.equals("")){
         %>
             <td><input type="text" size="10" maxlength="10" name="writer"></td>
         <%     }     
               else{
         %>
            <td><input type="text" size="10" maxlength="10" name="writer" value="<%=id%>"></td>
         <% 
               }
             }catch(Exception e){
               e.printStackTrace();
            }
         %>      
             <th>제목</th>
             <td>

             <input type="text" size="40" maxlength="50" name="subject"
                 >">
             </td>
           </tr>
        <tr>
          <th>Email</th>
          <td>
             <input type="text" size="40" maxlength="30" name="email" style="ime-mode:inactive;" >
          </td>
          <th>비밀번호</th>
          <td><input type="password" size="8" maxlength="12" name="passwd"></td>
        </tr>
        <tr>
          <th>글내용</th>
          <td colspan="3"><textarea name="content" rows="13" cols="40"></textarea></td>
        </tr>
        <tr>
           <th>공개여부</th>
           <td colspan="4">
             <label class="radio-inline">
                <input type="radio" name="open" value="1"> 회원공개
            </label>
            <label class="radio-inline">
                <input type="radio" name="open" value="0"> 전체공개
            </label>
          </td>
        </tr>
        <tr>
            <td colspan="4"> 
            <button class="btn btn-primary mr-2" type="submit">글쓰기</button>  
            <button class="btn btn-danger mr-2" type="reset">다시 작성</button>
            <a href="list.jsp" class="btn btn-primary">목록보기</a>
          </td>
         </tr>
      </table>

      </form>    
   </div>
</div>   
<jsp:include page="/_template/footer.inc.jsp" flush="false" />