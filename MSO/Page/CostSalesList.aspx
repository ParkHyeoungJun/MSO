<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CostSalesList.aspx.cs" Inherits="MSO.Page.CostSalesList" EnableSessionState="ReadOnly" %>

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

     .modal-body label {
         width:48px;
     }

         .title {
            font-weight: bold;
            font-size:14px;
        }
 .modal-dialog{ width: 100%; height: 100%; margin: 35px 15px; padding: 0; }
    </style>
      
    <script src="../Scripts/jquery-3.3.1.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
<asp:HiddenField ID="hid_DBNAME" runat="server" />
    <div class="title">
       판매부대비용 관리
    </div>
    <div class="searchTop">
        <div>
            <table>
                <tr>
                    <td>기간</td>
                    <td>
                        <input type="month" runat="server" id="txt_sdate" />
                    </td>
                    <td>~</td>
                    <td>
                        <input type="month" runat="server" id="txt_edate" />
                    </td>
                    <td>
                        <asp:Button ID="btn_Search" runat="server" Text="검색" CssClass="btn-primary" OnClick="btn_Search_Click" />
                    </td>
                    <td>
                        <input id="btn_Regster" type="button" value="등록" class="btn-primary" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">&nbsp;</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="searchConext">
        <table id="tab" class="tableList_01">
            <!-- -->
            <colgroup>
                <col style="width: 30px;" />
                <col style="width: 80px;" />
                <col style="width: 150px;" />
                <col style="width: 80px;" />
                <col style="width: 80px;" />
                <col style="width: 80px;" />
                <col style="width: 80px;" />
                <col style="width: 200px;" />
            </colgroup>
            <thead>
                <tr>
                    <th>
                        <input id="cbAll" type="checkbox" />
                    </th>
                    <th>날짜</th>
                    <th>운송사</th>
                    <th>차량번호</th>
                    <th>공급가</th>
                    <th>부가세</th>
                    <th>합계</th>
                    <th>비고</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rpt_List" runat="server">
                    <ItemTemplate>
                        <tr style="cursor: pointer;" id="<%#Eval("rownum")%>">
                            <td>
                                <input id="cb_check<%#Eval("Num")%>" type="checkbox" class="ckeckbox" data-num="<%#Eval("Num")%>" /></td>
                            <td class="center" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("CustCode")%>','<%#Eval("CarNum")%>','<%#Eval("DateDay")%>','<%#Eval("Supply")%>','<%#Eval("Surtax")%>','<%#Eval("Total")%>','<%#Eval("Note")%>')"><%#Eval("DateDay")%></td>
                            <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("CustCode")%>','<%#Eval("CarNum")%>','<%#Eval("DateDay")%>','<%#Eval("Supply")%>','<%#Eval("Surtax")%>','<%#Eval("Total")%>','<%#Eval("Note")%>')"><%#Eval("CARRIERNAME")%></td>
                            <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("CustCode")%>','<%#Eval("CarNum")%>','<%#Eval("DateDay")%>','<%#Eval("Supply")%>','<%#Eval("Surtax")%>','<%#Eval("Total")%>','<%#Eval("Note")%>')"><%#Eval("CarNum")%></td>
                            <td class="right" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("CustCode")%>','<%#Eval("CarNum")%>','<%#Eval("DateDay")%>','<%#Eval("Supply")%>','<%#Eval("Surtax")%>','<%#Eval("Total")%>','<%#Eval("Note")%>')">
                                <label id="lbl_Supply<%#Eval("Num")%>"><%#Eval("Supply")%></label>
                            </td>
                            <td class="right" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("CustCode")%>','<%#Eval("CarNum")%>','<%#Eval("DateDay")%>','<%#Eval("Supply")%>','<%#Eval("Surtax")%>','<%#Eval("Total")%>','<%#Eval("Note")%>')">
                                <label id="lbl_Surtax<%#Eval("Num")%>"><%#Eval("Surtax")%></label></td>
                            <td class="right" onclick="getRowData('<%#Eval("Num")%>','<%#Eval("CustCode")%>','<%#Eval("CarNum")%>','<%#Eval("DateDay")%>','<%#Eval("Supply")%>','<%#Eval("Surtax")%>','<%#Eval("Total")%>','<%#Eval("Note")%>')">
                                <label id="lbl_Total<%#Eval("Num")%>"><%#Eval("Total")%></label></td>
                            <td onclick="getRowData('<%#Eval("Num")%>','<%#Eval("CustCode")%>','<%#Eval("CarNum")%>','<%#Eval("DateDay")%>','<%#Eval("Supply")%>','<%#Eval("Surtax")%>','<%#Eval("Total")%>','<%#Eval("Note")%>')"><%#OutputCheckWord(Eval("Note").ToString())%></td>
                        </tr>
                    </ItemTemplate>

                </asp:Repeater>
            </tbody>
        </table>
        <table>
            <tr>
                <td colspan="8">
                    <asp:Label ID="lbl_NoData" runat="server" />
                </td>
            </tr>

        </table>
    </div>
    <table>
        <tr>
            <td colspan="6">&nbsp;</td>
        </tr>
        <tr>
            <td><asp:Button ID="btn_Excel" Text="엑셀 저장" runat="server" CssClass="btn-primary" OnClick="btn_Excel_Click" /></td>
            <td colspan="5"><input id="btn_Del" type="button" value="삭제" class="btn-primary" /></td>
        </tr>
    </table>



    <div class="modal fade modal " id="modal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div id="divdialog" class="modal-dialog" role="document">
            <div style="width: 900px;" class="modal-content">
                <div class="modal-header">
                    <label id="lbl_title">판매부대비용 등록</label>
                    <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                        <table>
                            <tr style="height: 45px;">
                                <td>
                                    <input type="hidden" id="hid_num" value="0" />
                                    <label class="control-form">운송사</label>
                                </td>
                                <td colspan="3">
                                    <asp:DropDownList ID="ddl_CustCode" runat="server" Style="width: 100%; height:23px;">
                                    </asp:DropDownList>
                               </td>
                                <td>
                                    <label class="control-form">차량번호</label>                                    
                                </td>
                                <td colspan="3">
                                    <input id="txt_CarNum" type="text" style="width: 180px;" />
                                </td>
                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" >날짜</label>
                                </td>
                                <td>
                                    <input id="txt_DateDay" type="date" style="width: 90px;" />
                               </td>
                                <td>
                                    <label>공급가</label>
                                </td>
                                <td>
                                    <input id="txt_Supply" type="text" numberonly style="width: 180px;" />
                                </td>
                                <td>
                                    <label>부가세</label>
                                </td>
                                <td>
                                    <input id="txt_Surtax" type="text" numberonly style="width: 180px;" />
                                </td>
                                <td>
                                    <label style="width:29px;">합계</label>
                                </td>
                                <td>
                                    <input id="txt_Total" type="text" disabled="disabled" style="width: 180px;" />
                                </td>
                            </tr>
                            <tr style="height: 45px;">
                                <td colspan="8">
                                    <label>비고</label>
                                    <input id="txt_Note" type="text" style="width: 780px" />
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
        var rowresult = 0;


        /// 화면 초기 셋팅 
        function initData() {
            $("#hid_num").val("0");
            $("#<%=ddl_CustCode.ClientID%>:eq(0)").prop("selected", true); /// 1첫번째 선택
            $("#txt_CarNum").val("");
            $("#txt_DateDay").val("");
            $("#txt_Supply").val("");
            $("#txt_Surtax").val("");
            $("#txt_Total").val("");
            $("#txt_Note").val(""); // '은 에러 발생하여 치환 
            $("#lbl_title").text("판매부대비용 저장");
            $("#add").text("저장");
        }




        function DataAvg() {
            var sumSupply = 0;
            var sumSurtax = 0;
            var sumTotal = 0;
            $('.ckeckbox').each(function (index, item) {

                var strNum = $(this).data("num");
                //alert(strNum);
                sumSupply += Number($("#lbl_Supply" + strNum).text().replaceAll(",", ""))
                sumSurtax += Number($("#lbl_Surtax" + strNum).text().replaceAll(",", ""))
                //alert($("#lbl_Total6").text())
                sumTotal += Number($("#lbl_Total" + strNum).text().replaceAll(",", ""))
            });
            var str = "<tr>";
            str += "<td colspan='2' style='font-weight: bold;'>합계</td>";
            str += "<td colspan='2'> </td>";
            str += "<td class='right' style='font-weight: bold;'>" + addComma(sumSupply) + "</td>";
            str += "<td class='right' style='font-weight: bold;'>" + addComma(sumSurtax) + "</td>";
            str += "<td class='right' style='font-weight: bold;'>" + addComma(sumTotal) + "</td>";
            str += "<td > </td>";
            str += "</tr>";
            $("#tab").append(str);
            //alert(sumTotal);
        }


        /// 삭제 
        function Del(num) {
            var params = {
                Num: num
            }
            ///
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/CostSalesWebService.asmx/sp_CostSales_Del", // 컨트롤러에서 대기중인 URL 주소이다.
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
            // alert(num);
        }


        ///상세 보기 
        function getRowData(Num, CustCode, CarNum, DateDay, Supply, Surtax, Total, Note) {
            // alert('')
            $("#hid_num").val(Num);
            $("#<%=ddl_CustCode.ClientID%>").val(CustCode);
            $("#txt_CarNum").val(CarNum);
            $("#txt_DateDay").val(DateDay);
            $("#txt_Supply").val(Supply);
            $("#txt_Surtax").val(Surtax);
            $("#txt_Total").val(Total);
            $("#txt_Note").val(Note.replace("&quot;", "'")); // '은 에러 발생하여 치환 
            $("#lbl_title").text("판매부대비용 수정");
            $("#add").text("수정");
            $("#modal").modal("show"); // 닫기--%>
        }
        ///숫자로 변환
        function strparint(str) {
            //alert(str)
            return Number(str);
        }

        //천단위마다 콤마 생성
        function addComma(data) {
            return data.toString().replaceAll(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        //모든 콤마 제거 방법
        function removeCommas(data) {
            if (!data || data.length == 0) {
                return "";
            } else {
                return x.split(",").join("");
            }
        }

        $(function () {
            $(document).on("click", "#btn_Regster", function () {
                initData();
                $("#modfiy").hide(); // 저장 버튼 활성화
                $("#add").show(); // 수정 버튼 비활성화
                $("#modal").modal("show"); // 모달 창 띄우기
            });

            ///사용자가 키보드 눌렸을때마다 콤마 찍어준다 
            $("input:text[numberOnly]").on("keyup", function () {
                if ($(this).attr("id") == "txt_Supply") {
                    //var data = Number(Math.round(strparint($(this).val(),) / 10));
                    var data = Math.round(strparint($(this).val().replaceAll(",", "") / 10), 0);
                    //alert(data)
                    if (isNaN(data)) {
                        data = "0";
                    }
                    $("#txt_Surtax").val(addComma(data));
                }

                //
                //  $("#txt_Surtax").val(addComma($("#txt_Surtax").val()))
                $(this).val(addComma($(this).val().replaceAll(/[^0-9]/g, "")));
                $("#txt_Total").val(addComma(strparint($("#txt_Supply").val().replaceAll(",", "")) + strparint($("#txt_Surtax").val().replaceAll(",", ""))));
            });

            /// 사용자가 키보드 다 누르고 포커스 나갔을때 이벤트 발생 
            $("input:text[numberOnly]").on("keydown", function () {
                $(this).val(function (index, value) {
                    return value
                        .replace(/\D/g, "")
                        .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                        ;
                });
                //$(this).val($(this).val().replaceAll(/[^0-9]/g, ""));
                $(this).val(addComma($(this).val()));
                $("#txt_Supply").val(addComma($("#txt_Supply").val()));

                $("#txt_Total").val(addComma(strparint($("#txt_Supply").val().replaceAll(",", "")) + strparint($("#txt_Surtax").val().replaceAll(",", ""))));
            });


            $(document).on("click", "#add", function (e) {
                e.preventDefault();
                if ($("#txt_DateDay").val() == "") {
                    $("#txt_DateDay").focus();
                    alert("날자를 선택하여 주세요");
                    return false;
                }
                if ($("#txt_Supply").val() == "") {
                    $("#txt_Supply").focus();
                    alert("공급가를 주세요");
                    return false;
                }
                if ($("#txt_Surtax").val() == "") {
                    $("#txt_Surtax").focus();
                    alert("공급가를 주세요");
                    return false;
                }

                /// params 
                var params = {
                    Num: $("#hid_num").val(),
                    CustCode: $("#<%=ddl_CustCode.ClientID%>").val(),
                    CarNum: $("#txt_CarNum").val(),
                    DateDay: $("#txt_DateDay").val(),
                    Supply: $("#txt_Supply").val(),
                    Surtax: $("#txt_Surtax").val(),
                    Total: $("#txt_Total").val(),
                    Note: $("#txt_Note").val()
                }
                ///
                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "/WebService/CostSalesWebService.asmx/sp_CostSales_Ins", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false, // 동기로 처리 
                    data: params, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        alert("저장되었습니다");
                        $("#add").text("저장");
                        $("#lbl_title").text("판매부대비용 등록");
                        $("#hid_num").val("0"); // 저장 모드  , 0이 아니면 수정이므료 
                        $("#modal").modal("hide"); // 닫기
                        initData();
                        $("#<%=btn_Search.ClientID%>").click();
                        //      alert(Object.keys(res).length)
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert(XMLHttpRequest.responseText)
                    }
                });
                /// params 
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
                    //// 파라미터 

                    ////
                });
                if (rowresult > 0) {
                    alert("삭제 되었습니다");
                    initData();
                    $("#<%=btn_Search.ClientID%>").click();
                }
            })
        });
    </script>

</asp:Content>
