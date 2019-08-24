<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%String title="샘플";%>

<jsp:include page="/_template/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>"/>      
</jsp:include>
   
   <br>
   
   <h5>숫자만 입력 제어</h5>
   <input type="text" name="inputNumber">
   
   <h5>영어만 입력 제어</h5>
   <input type="text" name="inputWord">
   
   <h5>숫자+영어 입력 제어</h5>
   <input type="text" name="inputNumberWord">
   
   <h5>숫자+영어 입력 제어(문자열 갯수 제한)</h5>
   <input type="text" name="inputControl">

<jsp:include page="/_template/footer.inc.jsp" flush="false"/>

<script>

//숫자만 입력 제어
$("input:text[name=inputNumber]").keyup(function(e) {

      reg = /[^0-9]/gi;

        v = $(this).val();

        if (reg.test(v)) {

            $(this).val(v.replace(reg, ''));

            $(this).focus();

        }


});

//영어만 입력 제어
$("input:text[name=inputWord]").keyup(function(e) {

      reg = /[^a-zA-Z]/gi;

       v = $(this).val();

       if (reg.test(v)) {

           $(this).val(v.replace(reg, ''));

           $(this).focus();

       }

});

//숫자+영어만 입력 제어
$("input:text[name=inputNumberWord]").keyup(function(e) {

      reg = /[^a-zA-Z0-9+]*/gi;

       v = $(this).val();

       if (reg.test(v)) {

           $(this).val(v.replace(reg, ''));

           $(this).focus();

       }

});

//숫자+영어만 입력 제어(문자열 갯수 제한)
$("input:text[name=inputNuControl]").keyup(function(e) {

      var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
        if( !idReg.test( $("input[name=inputControl]").val() ) ) {
            alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
            return;
        }
});

</script>