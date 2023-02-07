<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FindItem.aspx.cs" Inherits="MSO.Page.FindItem" EnableSessionState="ReadOnly" %>
<%@ Register assembly="ASPnetPagerV2_8" namespace="ASPnetControls" tagprefix="cc1" %>
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
    <div class="title">품목 검색</div>

    <div>
        <table>
            <tr>
                <td>&nbsp;</td>
                <td>검색 조건:
                    <asp:DropDownList ID="ddl_Type" runat="server">
                        <asp:ListItem Value="ITEMNO">품목코드</asp:ListItem>
                        <asp:ListItem Value="ITEMNAME">품목명칭</asp:ListItem>
                        <asp:ListItem Value="UNIT">단위</asp:ListItem>
                        <asp:ListItem Value="ACCTSET">계정 집합</asp:ListItem>
                    </asp:DropDownList>
                    <%--<%#Eval("Email")%>--%>
                    <asp:TextBox ID="tb_Search" runat="server" style="margin-bottom:4px"></asp:TextBox>
                    <asp:Button ID="btn_List" runat="server" Text="검색" CssClass="btn-primary" OnClick="btn_List_Click" style="margin-bottom:4px" />
                </td>
            </tr>
        
            <tr>
                <td colspan="4">
                    <table id="tab" class="tableList_01">
                        <colgroup>
                            <col style="width:100px;" />
                            <col style="width:50px;" />
                            <col style="width:50px;" />
                            <col style="width:70px;" />
                            <col style="width:150px;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>품목코드</th>
                                <th>품목명칭</th>
                                <th>단위</th>
                                <th>계정집합</th>
                                <th>계정집합 명칭</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rep_List" runat="server">
                                <ItemTemplate>
                                    <tr style='cursor: pointer' onclick="getItem('<%#Eval("ITEMNO")%>','<%#Eval("ITEMNAME")%>')">
                                        <td><%#Eval("ITEMNO")%></td>
                                        <td><%#Eval("ITEMNAME")%></td>
                                        <td><%#Eval("UNIT")%></td>
                                        <td><%#Eval("ACCTSET")%></td>
                                        <td><%#Eval("ACCTSETDESC")%></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                           
                        </tbody>
                    </table>
                </td>
            </tr>
            </table>
            <table style="width: 700px">
            <tr>
                 <td colspan="3">
                     <asp:Label ID="lbl_nodata" runat="server" />
                 </td>
            </tr>
            <tr>
                <td colspan="4">
                    <cc1:PagerV2_8 ID="pager" runat="server" PageSize="10" OnCommand="Command" />
                </td>

            </tr>
            
        </table>
    </div>
    <!-- 페이지 처리 하기위한 현재 페이지-->
    <asp:HiddenField ID="hid_pageNum" runat="server" Value="1" />
    <script type="text/javascript">
        function getItem(itemno, itemname) {
            window.opener.getItem(itemno, itemname);
            window.close();
        }
        $(function () {
            $(document).on("click","#btn_close", function () {
                window.close();
            });

        });

    </script>
</asp:Content>
