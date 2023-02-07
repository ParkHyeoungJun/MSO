<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Avergestatus.aspx.cs" Inherits="MSO.Page.Avergestatus" EnableSessionState="ReadOnly"  %>
<%@ Register assembly="ASPnetPagerV2_8" namespace="ASPnetControls" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .tableList_01 th {
            text-align: center;
            background-color: #f5f9fb;
            color: #31799c;
            padding: 8px;
            font-size: 12px;
            border: 1px solid #cad4d9;
            white-space: nowrap;
        }
          .title {
            font-weight: bold;
            font-size:14px;
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
            border-spacing: 0px;
        }

        .left {
            text-align: left;
        }

        .right {
            text-align: right;
        }

        .center {
            text-align: center;
        }
        .PagerContainerTable td{
            padding-left:2px;
            padding-right:2px;

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
       매입현황
    </div>
    
    <div class="panel panel-default" style=" width:1500px; padding: 10px; margin: 10px;">
        <div id="Tabs" role="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li id="li1" class="li "><a href="#personal" aria-controls="personal" id="tab1" role="tab" data-toggle="tab" class="tabmenu" style="background-color: cornflowerblue;">조회 조건
                </a></li>
                <li id="li2" class="li"><a href="#employment" aria-controls="employment" id="tab2" role="tab" data-toggle="tab" class="tabmenu" >조회 결과</a></li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content" style="padding-top: 20px">
                <div role="tabpanel" class="tab-pane active" id="personal">
                    <table>
                        <tr style="height: 45px;">
                            <td></td>
                            <td>
                                <asp:RadioButtonList ID="tbList" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Vendor" Selected="True">구매처별 집계</asp:ListItem>
                                    <asp:ListItem Value="Item" style="margin-left: 20px;">품목별 집계</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr style="height: 45px;">
                            <td>조회 기간 &nbsp;</td>
                            <td>
                                <input type="date" id="txt_sdate" runat="server" />&nbsp;~&nbsp;<input type="date" id="txt_edate" runat="server" />
                            </td>
                        </tr>
                        <tr style="height: 45px;">
                            <td>
                                <asp:Label ID="LB_Vendor" runat="server">구매처</asp:Label>
                                <asp:Label ID="LB_Item" runat="server" Style="display: none;">품목</asp:Label>
                            </td>
                            <td>
                                <asp:HiddenField ID="hid_coustomer1" runat="server" />
                                <asp:HiddenField ID="hid_coustomer1Name" runat="server" />
                                <asp:TextBox ID="txt_Coustomer1" runat="server" Width="140px" disabled='disabled' />
                                <asp:Button ID="btn_CustomerSearch1" runat="server" Text="찾기" CssClass="btn-primary search" />
                                ~
                                <asp:HiddenField ID="hid_coustomer2" runat="server" />
                                <asp:HiddenField ID="hid_coustomer2Name" runat="server" />
                                <asp:TextBox ID="txt_Coustomer2" runat="server" Width="140px" disabled='disabled' />
                                <asp:Button ID="btn_CustomerSearch2" runat="server" Text="찾기" CssClass="btn-primary search" />

                            </td>
                        </tr>
                    </table>



                </div>
                <div role="tabpanel" class="tab-pane" id="employment">

                      <asp:DropDownList ID="DL1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DL1_SelectedIndexChanged" style="margin-bottom:5px;">
                                <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="100">100</asp:ListItem>
                    </asp:DropDownList>

                    <div class="invtotal">
                        <div class="invtot_col">
                           <div class="invtot_header">매입액</div> <div class="invtot_data"><asp:Label  id="tot_Y" runat="server" Text="0"></asp:Label></div> 
                        </div>
                        <div class="invtot_col">
                           <div class="invtot_header">예상 매입액</div> <div class="invtot_data"><asp:Label  id="tot_N" runat="server" Text="0"></asp:Label></div> 
                        </div>
                        <div class="invtot_col">
                           <div class="invtot_header">매입 합계</div> <div class="invtot_data"><asp:Label  id="tot_sum" runat="server" Text="0"></asp:Label></div> 
                        </div>
                    </div>

                    <table id="tab" class="tableList_01">
                   
                        <tbody>
      
                            <asp:Repeater ID="rep_List1" runat="server" Visible="false">
                                <HeaderTemplate>
                                     <thead>
                                    <th>구매처</th>
                                    <th>구매처명</th>
                                    <th>구매발주번호</th>
                                    <th>구매발주일자</th>
                                    <th>구매발주금액</th>
                                    <th>매입번호</th>
                                    <th>매입일</th>
                                    <th>매입액</th>
                                    <th>AP여부</th>
                                         </thead>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr style="cursor: pointer;"  onclick="OpenDetilPopup('<%# Eval("PONUMBER")%>','<%#Eval("DOCTYPE")%>','<%#Eval("INVNUMBER")%>','<%#Eval("AP")%>')">
                                        <td class="left"><%#Eval("VDCODE")%></td>
                                        <td class="left"><%#Eval("VENDNAME")%></td>
                                        <td class="left"><%#Eval("PONUMBER")%></td>
                                        <td class="center"><%#SetDate(Eval("PODATE"))%></td>
                                        <td class="right"><%# SetComma(Eval("POAMT"))%></td>
                                        <td class="left"><%#Eval("INVNUMBER")%></td>
                                        <td class="center"><%#SetDate(Eval("INVDATE"))%></td>
                                        <td class="right"><%#SetComma(Eval("INVSUBTOT"))%>
                                        </tdclass=">
                                        <td class="center"><%#Eval("AP")%></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Repeater ID="rep_List2" runat="server" Visible="false">
                                <HeaderTemplate>
                                    <thead>                                        
                                        <th>품목코드</th>
                                        <th>품목명</th>                                
                                        <th>구매발주금액</th>
                                        <th>매입액</th>                                
                                        <th>AP여부</th>
                                    </thead>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="left"><%#Eval("ITEMNO")%></td>
                                        <td class="left"><%#Eval("ITEMDESC")%></td>
                                        <td class="right"><%#SetComma(Eval("POAMT"))%></td>
                                        <td class="right"><%#SetComma(Eval("EXTINVMISC"))%></td>
                                        <td class="left"><%#Eval("AP")%></td>                                                                                                                        
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                             <tr id="tr_nodata" runat="server" Visible="false">
                                <td colspan="9">
                                   <asp:Label ID="lbl_nodata" runat="server"/>
                                </td>
                             </tr>
                            
                                    <cc1:PagerV2_8 ID="pager" runat="server" PageSize="10" OnCommand="Command"/>                      
 
                        </tbody>
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
    <asp:Button ID="btn_Excel" Text="엑셀 저장" runat="server" CssClass="btn-primary" OnClick="btn_Excel_Click" disabled="disabled"/>
    <asp:HiddenField ID="hid_pageNum" runat="server" Value="1" />
    <script type="text/javascript">

         function OpenDetilPopup(ponumber ,doctype,invoicenumber,ap)
        {
             //SalesstatusDetil
             var pop = PopupCenter('AvergestatusDetil?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val() + "&ponumber=" + ponumber + "&doctype=" + doctype + "&invoicenumber=" + invoicenumber + "&ap=" + ap, '매입현황상세', 700, 560);
        }


        function getVendor(vendorid, vendorname) {
            if ($("#<%=hid_row.ClientID%>").val() == "1") {
                $("#<%=hid_coustomer1.ClientID%>").val(vendorid);
                $("#<%=hid_coustomer1Name.ClientID%>").val(vendorname);
                $("#<%=txt_Coustomer1.ClientID%>").val(vendorid);
            }
            else {
                $("#<%=hid_coustomer2.ClientID%>").val(vendorid);
                $("#<%=hid_coustomer2Name.ClientID%>").val(vendorname);
                $("#<%=txt_Coustomer2.ClientID%>").val(vendorid);
            }
        }

        function getItem(temno, itemname) {
            if ($("#<%=hid_row.ClientID%>").val() == "1") {
                $("#<%=hid_coustomer1.ClientID%>").val(temno);
                $("#<%=hid_coustomer1Name.ClientID%>").val(itemname);
                $("#<%=txt_Coustomer1.ClientID%>").val(temno);
            }
            else {
                $("#<%=hid_coustomer2.ClientID%>").val(temno);
                $("#<%=hid_coustomer2Name.ClientID%>").val(itemname);
                $("#<%=txt_Coustomer2.ClientID%>").val(temno);
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
            window. close();
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
            $(document).on("click", ".search", function (e) {
                e.preventDefault();
                var id = $(this).attr("id");
                if (id == "MainContent_btn_CustomerSearch1") {
                    $("#<%=hid_row.ClientID%>").val("1");
                }
                else {
                    $("#<%=hid_row.ClientID%>").val("2");
                }
                if ($("#<%=hid_Type.ClientID%>").val() == "Vendor") {
                    PopupCenter('FindVendor?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '구매처검색', 850, 380);


                }
                else {
                    PopupCenter('FindItem?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '품목검색', 740, 440);                    

                }
            });
        })
    </script>
</asp:Content>