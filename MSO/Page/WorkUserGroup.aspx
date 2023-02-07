<%@ Page Title="" ValidateRequest="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WorkUserGroup.aspx.cs" Inherits="MSO.Page.WorkUserGroup" EnableSessionState="ReadOnly" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/Map.js"></script>
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
 .modal-dialog{ width: 100%; height: 100%; margin: 35px 15px; padding: 0; }
    </style>
<asp:HiddenField ID="hid_DBNAME" runat="server" />
    <div class="title">
       잔업/특근 관리
    </div>
    <div>
        <table>
            <tr>
                <td>년도</td>
                <td>
                    <input id="sdate" type="month" runat="server" />
                    ~ 
                    <input id="edate" type="month" runat="server" />
                </td>
                <td></td>
                <td>
                    <asp:Button ID="btn_Search" runat="server" Text="검색" CssClass="btn-primary" OnClick="btn_Search_Click" />                   
                    <input id="btn_User" type="button" value="직원 관리" class="btn-primary" />
                    <input id="btn_Holiy" type="button" value="공휴일 관리" class="btn-primary" />
                    <input id="btn_HoliyApi" type="button" value="공휴일 API" class="btn-primary" />
                    <input id="btn_add" type="button" value="등록" class="btn-primary" style="visibility:hidden" />
                </td>

            </tr>
            <tr>
                <td colspan="4">&nbsp;</td>

            </tr>

            <tr>
                <td colspan="4">
                    <table id="tab" class="tableList_01">
                        <colgroup>
                            <col style="width: 30px" />
                            <col style="width: 50px" />
                            <col style="width: 150px" />
                            <col style="width: 30px" />
                            <col style="width: 20px" />
                            <col style="width: 30px" />
                            <col style="width: 30px" />
                            <col style="width: 30px" />
                        </colgroup>

                        <thead>
                            <tr>
                                <th>
                                     <asp:CheckBox ID="cb_All" runat="server"  />
                                </th>
                                <th>직원</th>
                                <th>이메일</th>
                                <th>년도</th>
                                <th>월</th>
                                <th>근무시간</th>
                                <th>야근시간</th>
                                <th>특근시간</th>
                            </tr>
                        </thead>
                        <tbody>

                            <asp:Repeater ID="rpt_List" runat="server" OnItemDataBound="Rpt_List_ItemDataBound">
                                <ItemTemplate>
                                    <tr class="tr" style="cursor: pointer;">
                                        <td>
                                            <asp:CheckBox ID="cb_check" runat="server"  CssClass="ckeckbox"/>
                                            <asp:HiddenField ID="hid_UserID" Value='<%#Eval("UserId")%>' runat="server" />
                                            <asp:HiddenField ID="hid_Email" Value='<%#Eval("Email")%>' runat="server" />
                                        </td>
                                        <td onclick="getRowData('<%#Eval("UserId")%>','<%#Eval("yy")%>-<%#Eval("mm")%>','<%#Eval("UserName")%>')">
                                            <asp:Label ID="lbl_UserName" runat="server" Text='<%#Eval("UserName")%>'></asp:Label>
                                        </td>
                                        <td onclick="getRowData('<%#Eval("UserId")%>','<%#Eval("yy")%>-<%#Eval("mm")%>','<%#Eval("UserName")%>')">
                                            <asp:Label runat="server" ID="lbl_Email" Text='<%#Eval("Email")%>'></asp:Label></td>
                                        <td onclick="getRowData('<%#Eval("UserId")%>','<%#Eval("yy")%>-<%#Eval("mm")%>','<%#Eval("UserName")%>')">
                                            <asp:Label runat="server" ID="lbl_YY" Text='<%#Eval("YY")%>'></asp:Label></td>
                                        <td onclick="getRowData('<%#Eval("UserId")%>','<%#Eval("yy")%>-<%#Eval("mm")%>','<%#Eval("UserName")%>')">
                                            <asp:Label runat="server" ID="lbl_MM" Text='<%#Eval("MM")%>'></asp:Label></td>
                                        <td class="right" onclick="getRowData('<%#Eval("UserId")%>','<%#Eval("yy")%>-<%#Eval("mm")%>','<%#Eval("UserName")%>')">
                                            <asp:Label runat="server" ID="lbl_WoorkTime" Text='<%#Eval("WoorkTime")%>'></asp:Label></td>
                                        <td class="right" onclick="getRowData('<%#Eval("UserId")%>','<%#Eval("yy")%>-<%#Eval("mm")%>','<%#Eval("UserName")%>')">
                                            <asp:Label runat="server" ID="lbl_Overtime" Text='<%#Eval("Overtime")%>'></asp:Label></td>
                                        <td class="right" onclick="getRowData('<%#Eval("UserId")%>','<%#Eval("yy")%>-<%#Eval("mm")%>','<%#Eval("UserName")%>')">
                                            <asp:Label runat="server" ID="lbl_WorkOvertime" Text='<%#Eval("WorkOvertime")%>'></asp:Label></td>
                                        
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="9">
                    <asp:Label ID="lbl_NoData" runat="server" />
                </td>

            </tr>
        </table>
    </div>
    <br />
    <asp:FileUpload ID="fileUpload" runat="server" />
    <br />
    <asp:Button ID="btn_Import" runat="server" CssClass="btn-primary" Text="엑셀 임포트" OnClick="Btn_Import_Click" Style="height: 25px" />
    <asp:Button ID="btn_Excel" Text="엑셀 저장" runat="server" CssClass="btn-primary" OnClick="Btn_Excel_Click" />
    <asp:Button ID="btn_Email" runat="server" Text="이메일전송 " CssClass="btn-primary" OnClick="Btn_Email_Click" />
    <input id="btn_Del" type="button" value="삭제" class="btn-primary" style="visibility: hidden" />

    <div class="modal fade modal" id="modal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div style="width: 360px;" class="modal-content">
                <div class="modal-header">
                    <label id="lbl_title">잔업 특근관리</label>
                    <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="panel-body">

                        <table width="100%" border="0">
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">아이디</label></td>
                                <td style="text-align: left">
                                    <input id="hid_Num" value="0" type="hidden" />
                                    <input id="txt_UserId" type="text" placeholder="아이디" disabled="disabled" />
                                    <input id="txt_UserName" type="text" placeholder="이름" disabled="disabled" />
                                    <button id="btn_UserFind" class="btn-danger">검색</button>
                                </td>

                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">날짜</label>
                                </td>
                                <td style="text-align: left">
                                    <input id="txt_AttenDay" type="date" placeholder="날짜" /></td>
                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">출근시간</label>
                                </td>
                                <td style="text-align: left">
                                    <select id="sel_AttenHH" style="height: 25px">
                                        <option selected="selected">9</option>
                                        <option>10</option>
                                        <option>11</option>
                                        <option>12</option>
                                        <option>13</option>
                                        <option>14</option>
                                        <option>15</option>
                                        <option>16</option>
                                        <option>17</option>
                                        <option>18</option>
                                        <option>19</option>
                                        <option>20</option>
                                        <option>21</option>
                                        <option>22</option>
                                        <option>23</option>
                                        <option>20</option>
                                        <option>21</option>
                                        <option>22</option>
                                        <option>23</option>
                                        <option>24</option>
                                    </select>:
                                    <input id="txt_AttenMM" type="text" placeholder="출근시간" value="00" numberonly maxlength="2" style="width: 30px" /></td>
                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">퇴근시간</label>
                                </td>
                                <td style="text-align: left">
                                    <select id="sel_LeaveTimeHH" style="height: 25px">
                                        <option>9</option>
                                        <option>10</option>
                                        <option>11</option>
                                        <option>12</option>
                                        <option>13</option>
                                        <option>14</option>
                                        <option>15</option>
                                        <option>16</option>
                                        <option>17</option>
                                        <option selected="selected">18</option>
                                        <option>19</option>
                                        <option>20</option>
                                        <option>21</option>
                                        <option>22</option>
                                        <option>23</option>
                                        <option>20</option>
                                        <option>21</option>
                                        <option>22</option>
                                        <option>23</option>
                                        <option>24</option>
                                    </select>:
                                    <input id="txt_LeaveTimeMM" type="text" placeholder="퇴근시간" value="00" numberonly maxlength="2" style="width: 30px" /></td>
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

        function getRowData(userid, attenday, username) {
            var pop = PopupCenter("WorkUserView?userid=" + userid + "&sday=" + attenday + "&eday=" + attenday + "&username=" + username+"&dbname="+ $("#<%=hid_DBNAME.ClientID%>").val(), '사용자 잔업관리', 700, 350);
            pop.focus();
        }

        function ExcelComplt(str)
        {
            alert(str);
            $("#<%=btn_Search.ClientID%>").click();
        }



        /// 초기데이터 셋팅 
        function initData() {
            $("#hid_Num").val("0");
            $("#txt_UserId").val("");
            $("#txt_UserName").val("");
            $("#txt_AttenDay").val("");
            $("#sel_AttenHH option:eq(0)").attr("selected", "selected");// 첫번째 선택 시키기 
            $("#sel_LeaveTimeHH option:eq(10)").attr("selected", "selected");// 10번째 선택 시키기 
            //sel_LeaveTimeHH
        }

        // 



        ///사용자 검색 자식창에서 부모 함수에 바인딩 
        function getUser(id, name) {
            $("#txt_UserId").val(id);
            $("#txt_UserName").val(name);
        }


        var rowresult = 0;
        function Del(num) {
            var params = {
                Num: num
            }
            ///
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/WorkWebService.asmx/sp_Woork_Del", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false, // 동기로 처리 
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    //   alert("성공")
                    rowresult += 1;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert(XMLHttpRequest.responseText)
                }
            });
        }


        $(function () {
            $(document).on("click", "#btn_add", function () {
                $("#modal").modal("show"); // 
            });
            $("input:text[numberOnly]").on("keyup", function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ""));
            });


            $(document).on("click", "#add", function (e) {
                e.preventDefault();
                if ($("#txt_UserId").val() == "") {
                    alert("아이디을 입력하여 주세요")
                    $("#txt_UserId").focus();
                    return false;
                }
                if ($("#txt_AttenDay").val() == "") {
                    alert("아이디을 입력하여 주세요");
                    $("#txt_AttenDay").focus();
                    return false;
                }
                if ($("#txt_AttenMM").val() == "") {
                    alert("출근시간을 확인하여 주세요")
                    $("#txt_AttenMM").focus();
                    return false;
                }

                if ($("#txt_LeaveTimeMM").val() == "") {
                    alert("출근시간을 확인하여 주세요")
                    $("#txt_LeaveTimeMM").focus();
                    return false;
                }

                // params 
                var params = {
                    Num: $("#hid_Num").val(),
                    UserId: $("#txt_UserId").val(),
                    AttenDay: $("#txt_AttenDay").val(),
                    AttenTime: $("#sel_AttenHH").val() + ":" + $("#txt_AttenMM").val(),
                    LeaveTime: $("#sel_LeaveTimeHH").val() + ":" + $("#txt_LeaveTimeMM").val()
                }
                //params 

                //ajax
                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "/WebService/WorkWebService.asmx/sp_Work_Ins", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false, // 동기로 처리 
                    data: params, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        alert("저장 되었습니다");
                        initData();
                        $("#modal").modal("hide");
                        //alert(Object.keys(res).length)
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert(XMLHttpRequest.responseText);
                    }
                });
                //ajax 
            });


            $(document).on("change", "#<%=cb_All.ClientID%>", function () {
                //서버 컨트롤이라 모든 체크 박스 찾는다 
                $("input[type='checkbox']").prop('checked', $(this).is(":checked"));
              


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
            })

            $("#btn_UserFind").on("click", function (e) {
                e.preventDefault();
                var pop = PopupCenter('FindUser?dbname='+ $("#<%=hid_DBNAME.ClientID%>").val(), '사원검색', 500, 300);
               // pop.focus();
            });


            $(document).on("click", "#btn_Email", function (e) {
                e.preventDefault();
                rowresult = 0;
                var bol = confirm("일괄 매일 발송하시겠습니까?");
                if (bol == false) {
                    alert("취소 되었습니다");
                    return false;
                }
            });


            $(document).on("click", "#btn_User", function (e) {
                e.preventDefault();
                var pop = PopupCenter('UserList?dbname='+ $("#<%=hid_DBNAME.ClientID%>").val(), '직원관리', 750, 400);
                //pop.focus();
            });


            $(document).on("change", "#cbAll", function () {
              //  alert("")
                $(".ckeckbox").attr("checked", $(this).is(":checked"));
            })

            $(document).on("click", "#btn_Holiy", function (e) {
                 e.preventDefault();
                var pop = PopupCenter('CalendarHoliDay?dbname='+ $("#<%=hid_DBNAME.ClientID%>").val(), '공휴일관리', 850, 700);
                //pop.focus();
            });

            $(document).on("click","#btn_HoliyApi", function (e) {
                e.preventDefault();
                var pop = PopupCenter('getHoilday?dbname='+ $("#<%=hid_DBNAME.ClientID%>").val(), '공휴일API', 400, 500);
            })

        });

    </script>

</asp:Content>
