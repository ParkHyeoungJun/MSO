<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="MSO.Page.UserList" EnableSessionState="ReadOnly" %>

<%@ Register Assembly="ASPnetPagerV2_8" Namespace="ASPnetControls" TagPrefix="cc1" %>

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
    </style>
<asp:HiddenField ID="hid_DBNAME" runat="server" />
    <!-- 현재 페이지 -->
    <input id="hid_pageNum" type="hidden" value="1" />

    <div class="title">
       직원 관리
    </div>


    <div class="searchTop">
        <div>
            <table>

                <tr>
                    <td>
                        <asp:DropDownList ID="ddl_Type" runat="server">
                            <asp:ListItem Value="UserId">아이디</asp:ListItem>
                            <asp:ListItem Value="UserName">이름</asp:ListItem>
                            <asp:ListItem Value="Email">이메일</asp:ListItem>
                        </asp:DropDownList>

                    </td>
                    <td>
                        <asp:TextBox ID="txt_Search" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btn_Search" runat="server" Text="검색" CssClass="btn-primary" OnClick="btn_Search_Click" />
                    </td>
                    <td>
                        <input id="btn_Regster" type="button" value="등록" class="btn-primary" />
                    </td>
                    <td>
                        <input id="btn_Del" type="button" value="삭제" class="btn-primary" /></td>
                </tr>
            </table>
        </div>
    </div>
    <br />
    <div class="searchConext" <%--style="width:100%; height:300px; overflow-y:scroll"--%>>
        <table id="tab" class="tableList_01">
            <colgroup>
                <col style="width: 30px" />
                <col style="width: 100px" />
                <col style="width: 100px" />
                <col style="width: 150px" />
                <col style="width: 30px" />
                <col style="width: 100px" />
            </colgroup>
            <thead>
                <tr>
                    <th>
                        <input id="cbAll" type="checkbox" />
                    </th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>퇴사여부</th>
                    <th>퇴사일</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rpt_List" runat="server">
                    <ItemTemplate>
                        <tr style="cursor: pointer;" id="<%#Eval("rownum")%>">
                            <td>
                                <input id="cb_check<%#Eval("Num")%>" type="checkbox" class="ckeckbox" data-num="<%#Eval("Num")%>" data-userid="<%#Eval("UserId")%>" /></td>
                            <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("UserName")%>','<%#Eval("UserPwd")%>','<%#Eval("Email")%>','<%#Eval("Retired")%>','<%#Eval("RetiredDay")%>')"><%#Eval("UserId")%></td>
                            <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("UserName")%>','<%#Eval("UserPwd")%>','<%#Eval("Email")%>','<%#Eval("Retired")%>','<%#Eval("RetiredDay")%>')"><%#Eval("UserName")%></td>
                            <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("UserName")%>','<%#Eval("UserPwd")%>','<%#Eval("Email")%>','<%#Eval("Retired")%>','<%#Eval("RetiredDay")%>')"><%#Eval("Email")%></td>
                            <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("UserName")%>','<%#Eval("UserPwd")%>','<%#Eval("Email")%>','<%#Eval("Retired")%>','<%#Eval("RetiredDay")%>')"><%#Eval("Retired")%></td>
                            <td class="center" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("UserName")%>','<%#Eval("UserPwd")%>','<%#Eval("Email")%>','<%#Eval("Retired")%>','<%#Eval("RetiredDay")%>')"><%#Eval("RetiredDay")%></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr>
                    <td colspan="6">
                        <asp:Label ID="lbl_NoData" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <cc1:PagerV2_8 ID="pager" runat="server" OnCommand="pager_Command" PageSize="25" />
                    </td>

                </tr>
            </tbody>
        </table>
        <table>
        </table>

    </div>
    <hr />
    <p>
    </p>


    <div class="modal fade modal" id="modal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div style="width: 360px;" class="modal-content">
                <div class="modal-header">
                    <label id="lbl_title">직원 등록</label>
                    <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="panel-body">

                        <table width="100%" border="0">
                            <tr id="tr_Retired" style="height: 45px;">
                                <td>
                                    <label id="lbl_Retired" class="control-form" style="width: 50px;">퇴사여부</label></td>
                                <td>
                                    <input id="cb_Retired" type="checkbox" />
                                    <input type="date" id="RetiredDay" />
                                </td>

                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">아이디</label></td>
                                <td>
                                    <input id="hid_Num" type="hidden" value="0" />
                                    <input id="txt_UserPwd" type="hidden" />
                                    <input id="txt_UserId" type="text" style="width: 220px;" placeholder="아이디" /></td>

                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">이름</label>
                                </td>
                                <td>
                                    <input id="txt_UserName" type="text" style="width: 220px;" placeholder="이름" /></td>
                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">이메일</label>
                                </td>
                                <td>
                                    <input id="txt_Email" type="email" style="width: 220px;" placeholder="이메일" /></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="add" type="button" class="btn-primary">등록</button>
                    <button type="button" class="btn-dark" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        /// 변수
        var rowresult = 0;

        function Del(num) {
            var userid = $("#cb_check" + num).data("userid");
            var params = {
                UserId: userid
            }
            ///
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/UserWebService.asmx/sp_User_Del", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false, // 동기로 처리 
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    //   alert("성공")
                    rowresult += 1;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("잔업/특근 관리에 사용자 정보가 있습니다")
                }
            });
        }

        // 초기값 설정 
        function initData() {
            $("#cb_Retired").attr("checked", false);
            $("#hid_Num").val("0");
            $("#txt_UserId").val("");
            $("#txt_UserName").val("");
            $("#txt_UserPwd").val("");
            $("#txt_Email").val("");
            $("#txt_UserId").removeAttr("disabled");
            $("#tr_Retired").hide();
            $("#add").text("등록");
            $("#RetiredDay").val("");
            $("#cb_Retired").attr("checked", false);
        }

        /// 상세보기 
        function getRowData(num, userid, username, userpwd, email, retired, retiredday) {
           // alert(retired)
            if (retired == "Y" || retired == "y") {
                $("#cb_Retired").prop('checked', true);
                $("#RetiredDay").val(retiredday);
                $("#RetiredDay").show();
            }
            else
            {
                $("#cb_Retired").prop('checked', false);
                $("#RetiredDay").val("");
                $("#RetiredDay").hide();
            }

            $("#hid_Num").val(num);
            $("#txt_UserId").val(userid);
            $("#txt_UserId").attr("disabled", "disabled")
            $("#txt_UserName").val(username);
            $("#txt_UserPwd").val(userpwd);
            $("#txt_Email").val(email)
            $("#lbl_title").text("직원 수정")
            $("#add").text("수정");
            $("#modal").modal("show"); // 
        }



        $(function () {
            $(document).on("click", "#btn_Regster", function () {
                initData();
                $("#modal").modal("show"); // 
            })

            //저장 
            $(document).on("click", "#add", function (e) {
                e.preventDefault();
                if ($("#txt_UserId").val() == "") {
                    alert("아이디를 확인하여 주세요");
                    $("#txt_UserId").focus();
                    return false;
                }
                if ($("#txt_UserName").val() == "") {
                    alert("이름을 확인하여 주세요");
                    $("#txt_UserName").focus();
                    return false;
                }

                //이메일 정규식
                var pattern = new RegExp("^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
                var result = pattern.test($("#txt_Email").val());
                if (result == false) {
                    alert("이메일을 확인하여 주세요")
                    $("#txt_Email").focus;
                    return false;
                }
                //params 
                $("#txt_UserPwd").val($("#txt_UserId").val()); // 임시로 아이디와 패스워드는 같게 설정 차후 협의 필요
                var params = {
                    UserId: $("#txt_UserId").val(),
                    UserName: $("#txt_UserName").val(),
                    UserPwd: $("#txt_UserPwd").val(),
                    Email: $("#txt_Email").val(),
                    Retired: $("#cb_Retired").is(":checked"),
                    RetiredDay: $("#RetiredDay").val()
                }
                //params 

                //ajax 
                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "/WebService/UserWebService.asmx/sp_User_Ins", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false, // 동기로 처리 
                    data: params, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        alert("저장 되었습니다");
                        initData();
                        $("#modal").modal("hide");
                        $("#<%=btn_Search.ClientID%>").click();
                        //alert(Object.keys(res).length)
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert(XMLHttpRequest.responseText);
                    }
                });
                //ajax 
            })

            $(document).on("change", "#cbAll", function () {
                $(".ckeckbox").prop('checked', $(this).is(":checked"));

            })
            $(document).on("click", "#btn_Del", function (e) {
                e.preventDefault();
                var bol = confirm("정말로 삭제하시겠습니까?");
                if (bol == false) {
                    alert("취소 되었습니다");
                    return false;
                }
                // alert($(".ckeckbox"))
                $('.ckeckbox').each(function (index, item) {
                    // alert(item);
                    var strNum = $(this).data("num");
                    //alert(strNum)
                    if ($(this).is(":checked")) {
                        Del(strNum)
                    }
                    //// 파라미터 

                    ////
                });
                if (rowresult > 0) {
                    alert("삭제 되었습니다");
                    initData();
                    $("#<%=btn_Search.ClientID%>").click();
                }
                else
                {
                    alert("선택 된 데이터가 존재하지 않습니다")
                }
            })
            $(document).on("change", "#cb_Retired", function () {               
                if ($(this).is(":checked")) {
                    var date = new Date();
                    var yyyy = date.getFullYear();
                    var mm = (date.getMonth() + 1);
                    var dd = date.getDate();
                    //alert(dd)
                    if (mm < 10) {
                        mm = "0" + mm;
                    }
                    //alert(mm);
                    if (dd < 10) {
                        dd = "0" + dd;
                    }



                    $("#RetiredDay").val(yyyy + "-" + mm + "-" + dd);
                    $("#RetiredDay").show();
                }
                else {
                    $("#RetiredDay").text("");
                    $("#RetiredDay").hide();
                }
            });
        })
    </script>
</asp:Content>
