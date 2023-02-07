<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WorkUserView.aspx.cs" Inherits="MSO.Page.WorkUserView" EnableSessionState="ReadOnly" %>

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

        .ckeckbox {
            /*width: 20px; 
            height: 20px; */
            cursor: pointer;
        }
    </style>
    <asp:HiddenField ID="hid_DBNAME" runat="server" />
    <asp:HiddenField ID="hid_Userid" Value="" runat="server" />
    <asp:HiddenField ID="hid_UserName" Value="" runat="server" />

    <div class="title">
        잔업/특근 관리
    </div>
    <div id="divSearch">
        <table>
            <tr>
                <td>
                    <input id="btn_add" type="button" value="등록" class="btn-primary" />
                    <button id="btn_Del" class="btn-primary">삭제</button>
                    <asp:Button ID="btn_Excel" runat="server" Text="엑셀저장" CssClass="btn-primary" OnClick="btn_Excel_Click" />
                    <asp:Button ID="btn_Search" runat="server" Text="검색" CssClass="btn-primary" OnClick="btn_Search_Click" Visible="False" />
                </td>
                <td style="visibility: hidden">년도</td>
                <td>
                    <input id="sdate" type="month" runat="server" style="visibility: hidden" />
                    <input id="edate" type="month" runat="server" style="visibility: hidden" />
                </td>
                <td style="visibility: hidden">당당자
                </td>

            </tr>
            <tr>
                <td colspan="4">&nbsp;</td>

            </tr>
        </table>

    </div>



    <table id="tab" class="tableList_01">
        <thead>
            <tr>
                <th>
                    <input id="cbAll" type="checkbox" /></th>
                <th>직원</th>
                <th>요일</th>
                <th>날짜</th>
                <th>출근</th>
                <th>퇴근</th>
                <th>근무시간</th>
                <th>야근시간</th>
                <th>특근시간</th>
            </tr>
        </thead>
        <tbody>

            <asp:Repeater ID="rpt_List" runat="server">
                <ItemTemplate>
                    <tr class="tr" data-rownum="<%#Eval("rownum")%>" data-num="<%#Eval("Num")%>" data-ww="ww<%#Eval("ww")%>" data-mm="mm<%#Eval("mm")%>" style="cursor: pointer;" id="<%#Eval("rownum")%>">
                        <td>
                            <input id="cb_check<%#Eval("Num")%>" type="checkbox" class="ckeckbox" data-num="<%#Eval("Num")%>" data-userid="<%#Eval("Num")%>" style="<%# (Eval("Num").ToString() != "") ? "visibility:initial;": "visibility:hidden;" %>" /></td>
                        <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("UserName")%></td>
                        <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("DATENA")%></td>
                        <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("AttenDay")%></td>
                        <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("AttenTime")%></td>
                        <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("LeaveTime")%></td>
                        <td class="right" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("WoorkTime")%></td>
                        <td class="right" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("Overtime")%></td>
                        <td class="right" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("UserId")%>','<%#Eval("AttenDay")%>','<%#Eval("AttenTime")%>','<%#Eval("LeaveTime")%>','<%#Eval("Overtime")%>','<%#Eval("WorkOvertime")%>','<%#Eval("WoorkTime")%>')"><%#Eval("WorkOvertime")%></td>
                </ItemTemplate>
            </asp:Repeater>

        </tbody>
    </table>
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
                                    <button id="btn_UserFind" class="btn-danger" style="visibility: hidden">검색</button>
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
                                        <option value="08">8</option>
                                        <option value="09" selected="selected">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                    </select>:
                                    <select id="sel_AttenMM" style="height: 25px">
                                        <option value="00">0</option>
                                        <option value="05">5</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                        <option value="30">30</option>
                                        <option value="35">35</option>
                                        <option value="40">40</option>
                                        <option value="45">45</option>
                                        <option value="50">50</option>
                                        <option value="55">55</option>
                                    </select>
                                </td>
                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">퇴근시간</label>
                                </td>
                                <td style="text-align: left">
                                    <select id="sel_LeaveTimeHH" style="height: 25px">
                                        <option value="08">8</option>
                                        <option value="09" selected="selected">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18" selected="selected">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                    </select>:
                                    <select id="sel_LeaveTimeMM" style="height: 25px">
                                        <option value="00">0</option>
                                        <option value="05">5</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                        <option value="30">30</option>
                                        <option value="35">35</option>
                                        <option value="40">40</option>
                                        <option value="45">45</option>
                                        <option value="50">50</option>
                                        <option value="55">55</option>
                                    </select>



                                </td>
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

        /// 초기데이터 셋팅 
        function initData() {
            $("#hid_Num").val("0");
            //$("#txt_UserId").val("");
            //$("#txt_UserName").val("");
            $("#txt_AttenDay").empty();
            var now = new Date();
            var h = now.getHours();
            var m = now.getMinutes();

            var yy = now.getFullYear();
            var mm = now.getMonth()+1;
            var dd = now.getDay()+1;

            //txt_AttenDay
            if (m < 10)
            {
                m = '0'+m
            }
            if (mm < 10)
            {
                mm = '0' + mm;
            }
            if (dd < 10)
            {
                dd = '0' + dd;
            }
            $("#txt_AttenDay").val(yy + "-" + mm +"-"+ dd);
            //alert(dd)
            $("#sel_AttenHH").val("09");
            $("#sel_AttenMM").val("00");
            //getMi
            $("#sel_LeaveTimeHH").val("18")// 9번째 선택 시키기
            $("#sel_LeaveTimeMM").val("00")
            //sel_LeaveTimeHH
        }

        function getRowData(num, userid, attenday, attentime, leavetime, overtime, workovertime, woorktime) {
            if (num != "") {
                $("#hid_Num").val(num);
                $("#txt_AttenDay").val(attenday);
                $("#txt_UserId").val(userid);
                //alert(attentime)
                $("#sel_AttenHH").val(attentime.split(':')[0]);
                $("#sel_AttenMM").val(getMi(attentime.split(':')[1]))
               // alert(leavetime)
                //sel_LeaveTimeHH
                $("#sel_LeaveTimeHH").val(leavetime.split(':')[0]);
                $("#sel_LeaveTimeMM").val(getMi(leavetime.split(':')[1]));
                $("#modal").modal("show"); //
            }
            // alert(num)
        }


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

        function getMi(m)
        {
            if (m >= 0 && m < 5)
            {
                return '0'+0;
            }
            else  if (m >=5  && m < 10)
            {
                return '0'+5;
            }
             else  if (m >=10  && m < 15)
            {
                return 10;
            }
            else  if (m >=15  && m < 20)
            {
                return 15;
            }
            else  if (m >=20  && m < 25)
            {
                return 20;
            }

             else  if (m >=25  && m < 30)
            {
                return 25;
            }

            else  if (m >=30  && m < 35)
            {
                return 30;
            }

            else  if (m >=35  && m < 40)
            {
                return 35;
            }

             else  if (m >=40  && m < 45)
            {
                return 40;
            }
             else  if (m >=45  && m < 50)
            {
                return 45;
            }

             else  if (m >=50  && m < 55)
            {
                return 50;
            }
              else  if (m >=55  && m < 60)
            {
                return 55;
            }
        }


        $(function () {
            $("#txt_UserId").val($("#<%=hid_Userid.ClientID%>").val());
            //alert()
            $("#txt_UserName").val($("#<%=hid_UserName.ClientID%>").val());
            //alert($("#txt_UserName").text())
            // $("#txt_UserName").val($("#<%=hid_UserName.ClientID%>").val());
            $("#btn_UserFind").attr("disabled", "disabled"); // 클릭 이벤트도 못하게 막는다

            initData();
           
            //alert(h + "," + m)


            $(document).on("click", "#btn_add", function () {
                initData(); // 등록 버튼 클릭시 화면 초기화
                $("#modal").modal("show"); // 
            });
            $("input:text[numberOnly]").on("keyup", function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ""));
            });

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
                });
                if (rowresult > 0) {
                    alert("삭제 되었습니다");
                    initData();
                    $("#<%=btn_Search.ClientID%>").click();
                }
            })

            $("#btn_UserFind").on("click", function (e) {
                e.preventDefault();
                var pop = PopupCenter('FindUser?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '사원검색', 500, 300);

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

               

                // params 
                var params = {
                    Num: $("#hid_Num").val(),
                    UserId: $("#txt_UserId").val(),
                    AttenDay: $("#txt_AttenDay").val(),
                    AttenTime: $("#sel_AttenHH").val() + ":" + $("#sel_AttenMM").val(),
                    LeaveTime: $("#sel_LeaveTimeHH").val() + ":" + $("#sel_LeaveTimeMM").val()
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
                        $("#<%=btn_Search.ClientID%>").click();
                        //alert(Object.keys(res).length)
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert(XMLHttpRequest.responseText);
                    }
                });
                //ajax 
            });
        })
    </script>
</asp:Content>
