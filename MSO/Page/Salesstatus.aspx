<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Salesstatus.aspx.cs" Inherits="MSO.Page.Salesstatus" EnableSessionState="ReadOnly" %>

<%@ Register Assembly="ASPnetPagerV2_8" Namespace="ASPnetControls" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
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
            font-size: 14px;
        }

        .nav-tabs a, .nav-tabs a:hover, .nav-tabs a:focus {
            outline: 0;
        }

        .sactive {
            background-color: cornflowerblue;
        }

        .invtotal 
        {
            
            display:inline-block;
           

        }
        .invtotal > .invtot_col
        {
            display:inline-flex;
            margin:10px;        
            height:35px;
           
        }

        .invtotal > .invtot_col > .invtot_header
        {
                        
            text-align: center;
            background-color: #f5f9fb;
            color: #31799c;            
            font-size: 12px;
            font-weight:bold;
            padding:8px;
            border: 1px solid #cad4d9;
            height:100%;
        }
        .invtotal > .invtot_col > .invtot_data {
            
            border: 1px solid #cad4d9;
            padding: 8px;
            font-size: 12px;
            font-family: "NotoR";
            height:100%;
            width:100px;
            text-align:right;
        }
    </style>



    <script src="/Scripts/common.js"></script>
    <script>
        function roundTable(objID) {
            var obj = document.getElementById(objID);
            var Parent, objTmp, Table, TBody, TR, TD;
            var bdcolor, bgcolor, Space;
            var trIDX, tdIDX, MAX;
            var styleWidth, styleHeight;

            // get parent node
            Parent = obj.parentNode;
            objTmp = document.createElement('SPAN');
            Parent.insertBefore(objTmp, obj);
            Parent.removeChild(obj);

            // get attribute
            bdcolor = obj.getAttribute('rborder');
            bgcolor = obj.getAttribute('rbgcolor');
            radius = parseInt(obj.getAttribute('radius'));
            if (radius == null || radius < 1) radius = 1;
            else if (radius > 6) radius = 6;

            MAX = radius * 2 + 1;

            /*
            create table {{
            */
            Table = document.createElement('TABLE');
            TBody = document.createElement('TBODY');

            Table.cellSpacing = 0;
            Table.cellPadding = 0;

            for (trIDX = 0; trIDX < MAX; trIDX++) {
                TR = document.createElement('TR');
                Space = Math.abs(trIDX - parseInt(radius));
                for (tdIDX = 0; tdIDX < MAX; tdIDX++) {
                    TD = document.createElement('TD');

                    styleWidth = '1px'; styleHeight = '1px';
                    if (tdIDX == 0 || tdIDX == MAX - 1) styleHeight = null;
                    else if (trIDX == 0 || trIDX == MAX - 1) styleWidth = null;
                    else if (radius > 2) {
                        if (Math.abs(tdIDX - radius) == 1) styleWidth = '2px';
                        if (Math.abs(trIDX - radius) == 1) styleHeight = '2px';
                    }

                    if (styleWidth != null) TD.style.width = styleWidth;
                    if (styleHeight != null) TD.style.height = styleHeight;

                    if (Space == tdIDX || Space == MAX - tdIDX - 1) TD.style.backgroundColor = bdcolor;
                    else if (tdIDX > Space && Space < MAX - tdIDX - 1) TD.style.backgroundColor = bgcolor;

                    if (Space == 0 && tdIDX == radius) TD.appendChild(obj);
                    TR.appendChild(TD);
                }
                TBody.appendChild(TR);
            }

            /*
            }}
            */

            Table.appendChild(TBody);

            // insert table and remove original table
            Parent.insertBefore(Table, objTmp);
        }
    </script>
    <asp:HiddenField ID="hid_DBNAME" runat="server" />
    <div class="title">
        매출현황
    </div>
    <div class="panel panel-default" style="width: 1500px; padding: 10px; margin: 10px">
        <div id="Tabs" role="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li id="li1" class="li "><a href="#personal" aria-controls="personal" id="tab1" role="tab" data-toggle="tab" class="tabmenu" style="background-color: cornflowerblue;">조회 조건
                </a></li>
                <li id="li2" class="li"><a href="#employment" aria-controls="employment" id="tab2" role="tab" data-toggle="tab" class="tabmenu">조회 결과</a></li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content" style="padding-top: 20px">
                <div role="tabpanel" class="tab-pane active" id="personal">
                    <table>
                        <tr style="height: 45px;">
                            <td></td>
                            <td>

                                <table>
                                    <tr>
                                        <td>
                                            <asp:RadioButtonList ID="tbList" runat="server" RepeatDirection="Horizontal" CssClass="rb" AutoPostBack="True">
                                                <asp:ListItem Value="Vendor" Selected="True">판매처별 집계</asp:ListItem>
                                                <asp:ListItem Value="Item" style="margin-left: 20px;">품목별 집계</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>
                        <tr style="height: 45px;">
                            <td>조회 기간</td>
                            <td>
                                <input type="date" id="txt_sdate" runat="server" />&nbsp;~&nbsp;<input type="date" id="txt_edate" runat="server" />
                            </td>
                        </tr>
                        <tr style="height: 45px;">
                            <td>
                                <asp:Label ID="LB_Vendor" runat="server">판매처</asp:Label>
                                <asp:Label ID="LB_Item" runat="server" Style="display: none;">품목</asp:Label>

                            </td>
                            <td>
                                <asp:HiddenField ID="hid_coustomer1" runat="server" />
                                <asp:HiddenField ID="hid_coustomer1Name" runat="server" />
                                <asp:TextBox ID="txt_Coustomer1" runat="server" Width="140px" disabled='disabled' />
                                <asp:Button ID="btn_CustomerSearch1" runat="server" Text="찾기" CssClass="search btn-primary search" />
                                ~
                                <asp:HiddenField ID="hid_coustomer2" runat="server" Value="ZZZZZZZZZZZZ" />
                                <asp:HiddenField ID="hid_coustomer2Name" runat="server" />
                                <asp:TextBox ID="txt_Coustomer2" runat="server" Width="140px" disabled='disabled' />
                                <asp:Button ID="btn_CustomerSearch2" runat="server" Text="찾기" CssClass="search btn-primary search" />
                                <asp:HiddenField ID="hid_txt_Coustomer1" runat="server" />
                                <asp:HiddenField ID="hid_txt_Coustomer2" runat="server" />
                            </td>
                        </tr>
                    </table>



                </div>
                <div role="tabpanel" class="tab-pane" id="employment">

                    <asp:DropDownList ID="ddl_PageSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddl_PageSize_SelectedIndexChanged" style="margin-bottom:5px">
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>

                    </asp:DropDownList>
                    <div class="invtotal">
                        <div class="invtot_col">
                           <div class="invtot_header">직접 재료비</div> <div class="invtot_data"><asp:Label  id="tot_COGS" runat="server" Text="0"></asp:Label></div> 
                        </div>
                        <div class="invtot_col">
                           <div class="invtot_header">매출액</div> <div class="invtot_data"><asp:Label  id="tot_Y" runat="server" Text="0"></asp:Label></div> 
                        </div>
                        <div class="invtot_col">
                           <div class="invtot_header">예상 매출액</div> <div class="invtot_data"><asp:Label  id="tot_N" runat="server" Text="0"></asp:Label></div> 
                        </div>
                        <div class="invtot_col">
                           <div class="invtot_header">매출 합계</div> <div class="invtot_data"><asp:Label  id="tot_sum" runat="server" Text="0"></asp:Label></div> 
                        </div>
                    </div>
                         

                    <table id="table" class="tableList_01">
                        <asp:Repeater ID="rep_List1" runat="server">
                            <HeaderTemplate>
                                <thead>
                                    <th>판매처코드</th>
                                    <th>판매처명</th>
                                    <th>거래선 PO번호</th>
                                    <th>주문번호</th>
                                    <th>주문일자</th>
                                    <th>주문금액</th>
                                    <th>매출번호</th>
                                    <th>매출일자</th>
                                    <th>매출액</th>
                                    <th>직접 재료비</th>
                                    <th>AR여부</th>
                                    <th>매출구분</th>
                                </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style='cursor: pointer' onclick="OpenDetilPopup('<%#Eval("PONUMBER")%>','<%#Eval("ORDNUMBER")%>','<%#Eval("DOCTYPE")%>','<%#Eval("INVNUMBER")%>','<%#Eval("AR")%>')">
                                    <td><%#Eval("CUSTOMER")%></td>
                                    <!--판매처코드 -->
                                    <td><%#Eval("NAMECUST")%></td>
                                    <!--판매처명 -->
                                    <td><%#Eval("PONUMBER")%></td>
                                    <!--거래선po -->
                                    <td><%#Eval("ORDNUMBER")%></td>
                                    <!--주문번호 -->
                                    <td class="center"><%#SetDate(Eval("ORDDATE"))%></td>
                                    <!--주문일자 -->
                                    <td class="right"><%#SetComma(Eval("ORDAMT"))%></td>
                                    <!--주문금액 -->
                                    <td><%#Eval("INVNUMBER")%></td>
                                    <!--매출번호 -->
                                    <td class="center"><%#SetDate(Eval("INVDATE"))%></td>
                                    <!-- 매출 일자-->
                                    <td class="right"><%#SetComma(Eval("INVSUBTOT"))%></td>
                                    <!--매출액-->
                                    <td class="right"><%#SetComma(Eval("COGS"))%></td>
                                    <!--직접 재료비 추가  2022-06-22-->                                    
                                    <td class="center"><%#Eval("AR")%></td>
                                    <!-- AR여부-->
                                    <td><%#Eval("ARTYPE")%></td>
                                    <!--매출구분 -->
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                       
                        <asp:Repeater ID="rep_List2" runat="server">
                            <HeaderTemplate>
                                <thead>
                                    <th>품목코드</th>
                                    <th>품목명</th>
                                    <th>주문금액</th>
                                    <th>매출액</th>
                                    <th>직접 재료비</th>
                                    <th>AR여부</th>
                                    <th>매출구분</th>
                                </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style='cursor: pointer'>
                                    <td><%#Eval("ITEMNO")%></td>
                                    <td><%#Eval("ITEMDESC")%></td>
                                    <td class="right"><%#SetComma(Eval("ORDAMT"))%></td>
                                    <td class="right"><%#SetComma(Eval("EXTINVMISC"))%></td>                                    
                                    <td class="right"><%#SetComma(Eval("COGS"))%></td>
                                    <td class="center"><%#Eval("AR")%></td>
                                    <td class="center"><%#Eval("ARTYPE")%></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                    <table>
                         <tr>
                            <td colspan="11">
                                <cc1:PagerV2_8 ID="pager" runat="server" OnCommand="Command" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td runat="server" id="norow">
                                <asp:Label ID="lbl_nodata" runat="server" />
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>
        <br />
        <br />
        <%--     <asp:Button ID="Button1" Text="Submit" runat="server" CssClass="btn btn-primary" OnClick="Button1_Click" />--%>
        <asp:HiddenField ID="TabName" runat="server" />
        <asp:HiddenField ID="hid_row" runat="server" />
        <asp:HiddenField ID="hid_Type" runat="server" Value="Vendor" />
    </div>
    <asp:Button ID="btn_Search" runat="server" Text="검색" OnClick="btn_Search_Click" CssClass="btn-primary" />
    <asp:Button ID="btn_Excel" Text="엑셀 저장" runat="server" CssClass="btn-primary" OnClick="btn_Excel_Click" disabled="disabled" />
    
    <script type="text/javascript">

        function Sclose() {
            window.close();
        };
        function OpenDetilPopup(ponumber, ordnumber, doctype, invoicenumber, ar) {
            //SalesstatusDetil
            var pop = PopupCenter('SalesstatusDetil?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val() + "&ponumber=" + ponumber + "&ordnumber=" + ordnumber + "&doctype=" + doctype + "&invoicenumber=" + invoicenumber + "&ar=" + ar, '판매현황상세', 700, 560);
        }


        function getCustomer(cnum, cname) {
            if ($("#<%=hid_row.ClientID%>").val() == "1") {
                $("#<%=hid_coustomer1.ClientID%>").val(cnum);
                $("#<%=txt_Coustomer1.ClientID%>").val(cnum);

                $("#<%=hid_txt_Coustomer1.ClientID%>").val(cnum);
            }
            else {
                $("#<%=hid_coustomer2.ClientID%>").val(cnum);
                $("#<%=txt_Coustomer2.ClientID%>").val(cnum);

                $("#<%=hid_txt_Coustomer2.ClientID%>").val(cnum);
            }
        }

        function getItem(itemno, itemname) {
            if ($("#<%=hid_row.ClientID%>").val() == "1") {
                $("#<%=hid_coustomer1.ClientID%>").val(itemno);
                $("#<%=txt_Coustomer1.ClientID%>").val(itemno);

            }
            else {
                $("#<%=hid_coustomer2.ClientID%>").val(itemno);
                $("#<%=txt_Coustomer2.ClientID%>").val(itemno);
            }
        }

        function employment() {
            $("#personal").removeClass("active");
            $("#employment").addClass("active");
            $('#Tabs a[href="#employment"]').tab('show');
            $("#tab2").attr("style", "background-color:cornflowerblue");
            $("#tab1").attr("style", "");
            $('#<%=btn_Excel.ClientID%>').removeAttr('disabled');

        }

        function resizeToMinimum(w, h) {
            w = w > window.outerWidth ? w : window.outerWidth;
            h = h > window.outerHeight ? h : window.outerHeight;
            window.resizeTo(w, h);
        };


        //초기 화면 설정
        function Init() {
            if ($('input[name$=tbList]:checked').val() == "Vendor") {
                if (!$("#<%=hid_coustomer2.ClientID%>").val()) {
                    $("#<%=hid_coustomer2.ClientID%>").val("ZZZZZZZZZZZZ");
                }

                $("#<%=hid_Type.ClientID%>").val("Vendor");
                $('#<%= LB_Vendor.ClientID %>').css("display", "inline");
                $('#<%= LB_Item.ClientID %>').css("display", "none");
            }
            else {
                if (!$("#<%=hid_coustomer2.ClientID%>").val()) {
                    $("#<%=hid_coustomer2.ClientID%>").val("ZZZZZZZZZZZZZZZZZZZZZZZZ");
                }

                $("#<%=hid_Type.ClientID%>").val("Item");
                $('#<%= LB_Vendor.ClientID %>').css("display", "none");
                $('#<%= LB_Item.ClientID %>').css("display", "inline");
            }
        };


        function Sclose() {
            window.close();
        };



       $(function () {
            Init();
            var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "personal";
            //tabName = "employment";
            //alert(tabName);
            $('#Tabs a[href="#' + tabName + '"]').tab('show');
            $("#Tabs a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });

            $('input[name$=tbList]').change(function () {
                if ($('input[name$=tbList]:checked').val() == "Vendor") {
                    $("#<%=hid_Type.ClientID%>").val("Vendor");
                    $('#<%= LB_Vendor.ClientID %>').css("display", "inline");
                    $('#<%= LB_Item.ClientID %>').css("display", "none");
                        <%--  $('#<%= HeadList1.ClientID %>').css("display", "table-row");
                        $('#<%= HeadList2.ClientID %>').css("display", "none");--%>
                    $("#<%=hid_coustomer1.ClientID%>").val("");
                    $("#<%=hid_coustomer2.ClientID%>").val("ZZZZZZZZZZZZ");
                    $("#<%=hid_coustomer1Name.ClientID%>").val("");
                    $("#<%=hid_coustomer2Name.ClientID%>").val("");
                    $("#<%=txt_Coustomer1.ClientID%>").val("");
                    $("#<%=txt_Coustomer2.ClientID%>").val("");
                }
                else {
                    $("#<%=hid_Type.ClientID%>").val("Item");
                    $('#<%= LB_Vendor.ClientID %>').css("display", "none");
                    $('#<%= LB_Item.ClientID %>').css("display", "inline");
                        <%-- $('#<%= HeadList1.ClientID %>').css("display", "none");
                        $('#<%= HeadList2.ClientID %>').css("display", "table-row");--%>
                    $("#<%=hid_coustomer1.ClientID%>").val("");
                    $("#<%=hid_coustomer2.ClientID%>").val("ZZZZZZZZZZZZZZZZZZZZZZZZ");
                    $("#<%=hid_coustomer1Name.ClientID%>").val("");
                    $("#<%=hid_coustomer2Name.ClientID%>").val("");
                    $("#<%=txt_Coustomer1.ClientID%>").val("");
                    $("#<%=txt_Coustomer2.ClientID%>").val("");

                }

            })




            $(document).on("click", ".li", function () {
                var id = $(this).attr("id");
                //$(this).attr("style","background-color:cornflowerblue")
                //alert(id)
                //$(this).addClass("sactive");
                if (id == "li1") {
                    $("#tab1").attr("style", "background-color:cornflowerblue");
                    $("#tab2").attr("style", "");
                    $('#<%=btn_Excel.ClientID%>').attr('disabled', 'disabled');
                    
                }
                else {
                    $("#tab2").attr("style", "background-color:cornflowerblue");
                    $("#tab1").attr("style", "");                    
                    $('#<%=btn_Search.ClientID%>').trigger('click');
                    
                }
                //alert(id);
            });



            $(document).on("click", "#<%=btn_CustomerSearch1.ClientID%>", function () {
                $("#<%=hid_row.ClientID%>").val("1");
                if ($("#<%=hid_Type.ClientID%>").val() == "Vendor") {
                    PopupCenter('FindCustomer?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '판매처검색', 700, 300);


                }
                else {
                    PopupCenter('FindItem?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '품목검색', 700, 300);

                }
            });

            $(document).on("click", "#<%=btn_CustomerSearch2.ClientID%>", function () {
                $("#<%=hid_row.ClientID%>").val("2");
                 if ($("#<%=hid_Type.ClientID%>").val() == "Vendor") {
                    PopupCenter('FindCustomer?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '판매처검색', 700, 300);


                }
                else {
                     PopupCenter('FindItem?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '품목검색', 700, 300);

                 }
             });
           
        })
    </script>
</asp:Content>
