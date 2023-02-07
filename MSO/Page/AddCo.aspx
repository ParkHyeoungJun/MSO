<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddCo.aspx.cs" Inherits="MSO.Page.AddCo" EnableSessionState="ReadOnly" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .center {
            text-align: center;
        }

        .left {
            text-align: left;
        }

        .right {
            text-align: right;
        }

        .tableList_01 {
            width: 440px;
        }

            .tableList_01 th, td {
                padding-left: 2px;
                padding-right: 2px;
                word-break: break-all;
                word-wrap: break-word;
            }

            .tableList_01 th {
                text-align: center;
                background-color: #f5f9fb;
                color: #31799c;
                padding: 8px;
                font-size: 12px;
                border: 1px solid #cad4d9;
                white-space: nowrap;
            }

            .tableList_01 td {
                border-bottom: 1px solid #cad4d9;
                border-left: 1px solid #cad4d9;
                border-right: 1px solid #cad4d9;
                padding-bottom: 3px;
                padding-right: 5px;
                padding-top: 3px;
                padding-left: 5px;
                margin-left: 3px;
                white-space: nowrap;
                font-family: "NotoR";
            }

                .tableList_01 td input {
                    width: 100%;
                    border: 0px;
                }

        .title {
            font-weight: bold;
            font-size:14px;
        }

        .modal-dialog {
            width: 100%;
            height: 100%;
            margin: 35px 15px;
            padding: 0;
        }
    </style>

    <br />
    <div class="title">
        경영계획 거래선 관리
    </div>
    <div>
        <table>
            <tr>
                <td>년도</td>
                <td>
                    <asp:DropDownList ID="ddl_Year" runat="server"></asp:DropDownList></td>
                <td>담당자</td>
                <td>
                    <asp:DropDownList ID="ddl_User" runat="server"></asp:DropDownList></td>
                <td>
                    <input id="btn_add" type="button" value="추가" class="btn-primary" /></td>
            </tr>
            <tr>
                <td colspan="5">&nbsp;</td>

            </tr>
        </table>
        <table>
            <tr>
                <td colspan="5">
                    <div class="test">
                        <table border="1" class="tableList_01" id="tab">
                        </table>

                    </div>

                </td>
            </tr>

        </table>


        <table style="width: 440px;">


            <tr>
                <td colspan="5">&nbsp;</td>

            </tr>

            <tr>
                <td colspan="5" class="right">
                    <input id="btn_save" type="button" value="저장" class="btn-primary" style="width: 50px" />
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hid_DBNAME" runat="server" />
    <!-- 동적으로 추가된 행 id 기억하기 위함-->
    <input type="hidden" id="hid_row" />
    <script type="text/javascript">
        function List() {
           //$('div.test').block({ 
           //     message: '<h1>Loading...</h1>', 
           //     css: { border: '1px solid #a00' } 
           // }); 
            var params = {
                UserId: $("#<%=ddl_User.ClientID%>").val(),
                YYYY: $("#<%=ddl_Year.ClientID%>").val()
            }
            ///
            $('#tab').empty();
            var str = "";
            str += "<thead><tr><th style='width: 50px;'>번호</th><th style='width: 150px;'>거래선</th><th  style='width: 200px;'>거래선명</th><th style='width: 70px;'>검색</th><th style='width: 70px;'>삭제</th></tr></thead>";
            $('#tab').append(str);
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/ManagementWebService.asmx/sp_ManagementMaster_List", // 컨트롤러에서 대기중인 URL 주소이다.
               async: false,
                dataType: "text",
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    var data = res.split("[")[1]//.split("[")[0];
                    data = data.split("]")[0]
                    data = "[" + data + "]"
                    // console.log(data)
                    data = JSON.parse(data);
                    //alert(res)
                    // 기존 tbody에 붙이면 버그가 있어 일일이 넣어줌
                    str = "";

                    if (Object.keys(data).length == 0) {
                        str += "<tr data-row='nodata' ><td colspan='5' class='center'>검색된 데이터가 없습니다</td></tr>";
                        $("#tab").append(str);
                    }
                    $.each(data, function (i, v) {
                        str = "<tr data-row='" + v.Idx + "' id='" + v.Idx + "'>";
                        str += "<td class='right'><input type='hidden' id='hid_idx" + (i + 1) + "' value='" + v.Idx + "' data-idx='" + (i + 1) + "' class='idx' />" + (i + 1) + "</td>";
                        str += "<td>" + "<input type='text' id='CusttomerCode" + v.Idx + "' class='CusttomerCode' disabled='disabled' value='" + v.CusttomerCode + "'></td>";
                        str += "<td>" + "<input type='text' id='CusttomerName" + v.Idx + "' class='CusttomerName' disabled='disabled' value='" + v.CusttomerName + "' /></td>";
                        str += "<td><button style='width:70px;' class='btnSearch btn-primary' data-row='" + v.Idx + "'>검색</button></td>";
                        str += "<td><button style='width:70px;' class='btnDel btn-primary' data-row='" + v.Idx + "'>삭제</button></td>"
                        str += "</tr>";
                        // alert(str);
                        $('#tab').append(str);
                        //alert(v.CusttomerCode);
                    })
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("저장 도중 실패!" + XMLHttpRequest.responseText)
                }
            });
        }



        var rowidx = 0;
        function save(idx) {
            var params = {
                Idx: $("#hid_idx" + idx).val(),
                UserId: $("#<%=ddl_User.ClientID%>").val(),
                CusttomerCode: $("#CusttomerCode" + idx).val(),
                CusttomerName: $("#CusttomerName" + idx).val(),
                YYYY: $("#<%=ddl_Year.ClientID%>").val()
            }
            ///
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/ManagementWebService.asmx/sp_Management_Ins", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false, // 동기로 처리 
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    rowidx = +1;
                    //      alert(Object.keys(res).length)
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                 //   alert("저장 도중 실패!")
                }
            });

            ///
        }

        ///동적으로 생성된 버튼에서 팝업창에서 거래처 활당
        function getCustem(cnum, cname) {
          //  alert("받음")
            var idx = $("#hid_row").val();
            $("#CusttomerCode" + idx).val(cnum);
            $("#CusttomerName" + idx).val(cname);
        }
       $(function () {

            var date = new Date();
            $("#<%=ddl_Year.ClientID%>").val((date.getFullYear()));



            List();

            $(document).on("click", "#btn_add", function () {
                var rowcount = $('#tab>tr:last').data("row");
                if (rowcount == undefined) {
                    rowcount = 1;
                }
                else if (rowcount == "nodata") {
                    rowcount = 1;
                    $('#tab').empty();
                    var str = "";
                    str += "<thead><tr><th style='width: 50px;'>번호</th><th style='width: 150px;'>거래선</th><th  style='width: 200px;'>거래선명</th><th style='width: 70px;'>검색</th><th style='width: 70px;'>삭제</th></tr></thead>";
                    $('#tab').append(str);
                }
                else {
                    rowcount = Number(rowcount) + 1;
                }
                //alert(rowcount)

                // return false;
                var str = "<tr data-row='" + rowcount + "'  id='" + rowcount + "'>";
                str += "<td class='right'><input type='hidden' id='hid_idx" + rowcount + "' value='0' data-idx='" + rowcount + "' class='idx' />" + (Number($('#tab>tr').length) + 1) + "</td>";
                str += "<td>" + "<input type='text' id='CusttomerCode" + rowcount + "' class='CusttomerCode' disabled='disabled' value=''></td>";
                str += "<td>" + "<input type='text' id='CusttomerName" + rowcount + "' class='CusttomerName' disabled='disabled' value='' /></td>";
                str += "<td><button style='width:70px;' class='btnSearch btn-primary' data-row='" + rowcount + "'>검색</button></td>";
                str += "<td><button style='width:70px;' class='btnDel btn-primary' data-row='0' data-id='" + rowcount+"'>삭제</button></td>"
                str += "</tr>";
                // alert(str);
                $('#tab').append(str);
            });

            // 동적 생성된 버튼에 이벤트 붙여주기 
            $(document).on("click", ".btnSearch", function (e) {
                e.preventDefault(); // 이벤트 일시 정지
                var row = $(this).data("row");
               // alert(row);
                $("#hid_row").val(row);
                PopupCenter('CostmerFind?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '거래처검색', 920, 560);
            });
          
           

            // 저장 버튼 
            $(document).on("click", "#btn_save", function (e) {
                e.preventDefault();
                //유효성 검사
                var bol = false;
                $('.idx').each(function () {
                    var idx = $(this).data("idx");
                    var CusttomerCode = $("#CusttomerCode" + idx).val();
                    //alert(CusttomerCode)
                    var CusttomerName = $("#CusttomerName" + idx).val();
                    if (CusttomerCode == "") {
                        alert("거래처코드을 입력하여 주세요")
                        $("#CusttomerCode" + idx).focus();
                        bol = true;
                        // e.preventDefault();
                        return false;
                    }
                    if (CusttomerName == "") {
                        alert("거래처명을 입력하여 주세요")
                        $("#CusttomerName" + idx).focus();
                        // e.preventDefault();
                        bol = true;
                        return false;
                    }
                    //alert(idx);
                });
                // 유효성 검사 
                if (bol) {
                    return false;
                }
                // insert 
                $('.idx').each(function () {
                    var idx = $(this).data("idx");
                    var CusttomerCode = $("#CusttomerCode" + idx).val();
                    var CusttomerName = $("#CusttomerName" + idx).val();
                    //Save
                    save(idx);
                    //save
                });
                if (rowidx > 0) {
                    alert("저장 되었습니다")
                    window.opener.List();
                    window.close();
                }
                else {

                }

            });

            $(document).on("change", "#<%=ddl_User.ClientID%>", function (e) {
                e.preventDefault();
                List();
            })

            $(document).on("change", "#<%=ddl_Year.ClientID%>", function (e) {
                e.preventDefault();
                List();
            })

            $(document).on("click", ".btnDel", function (e) {
                e.preventDefault();

                var bol = confirm("정말로 삭제하시겠습니까?");
                if (bol == false) {
                    alert("취소 되었습니다");
                    return false;
                }
                var row = $(this).data("row");
                var id = $(this).data("id");
                if (row == 0) {


                    $("#" + id).remove();
                    return;
                }
                //ajax
                var params = {
                    UserId: $("#<%=ddl_User.ClientID%>").val(),
                    CusttomerCode: $("#CusttomerCode" + row).val(),
                    YYYY: $("#<%=ddl_Year.ClientID%>").val()
                }
                //alert(params.UserId)
                //alert(params.CusttomerCode)
                ///
                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "/WebService/ManagementWebService.asmx/sp_ManagementMaster_Del", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false, // 동기로 처리 
                    data: params, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        alert("삭제 되었습니다");
                        List();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert(XMLHttpRequest.responseText)
                    }
                });
                //ajax 

            })

            //$('div.test').unblock();
        });


    </script>
</asp:Content>
