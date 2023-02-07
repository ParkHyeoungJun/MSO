<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FindUser.aspx.cs" Inherits="MSO.Page.FindUser" EnableSessionState="ReadOnly" %>

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
    <div class="title">직원관리</div>

    <div>
        <table>
            <tr>
                <td>&nbsp;</td>
                <td>검색 조건:
                    <asp:DropDownList ID="ddl_Type" runat="server">
                        <asp:ListItem Value="UserId">아이디</asp:ListItem>
                        <asp:ListItem Value="UserName">이름</asp:ListItem>
                        <asp:ListItem Value="Email">이메일</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <%#Eval("Email")%>
                    <asp:TextBox ID="tb_Search" runat="server" style="margin-bottom:4px"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btn_List" runat="server" Text="검색" CssClass="btn-primary" OnClick="btn_List_Click" style="margin-bottom:4px" />
                </td>
            </tr>
            
            <tr>
                <td colspan="4">
                    <table id="tab" class="tableList_01">
                        <colgroup>
                            <col style="width:100px;" />
                            <col style="width:50px;" />
                            <col style="width:190px;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>아이디</th>
                                <th>이름</th>
                                <th>이메일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rep_List" runat="server">
                                <ItemTemplate>
                                    <tr style='cursor: pointer' onclick="getUser('<%#Eval("UserId")%>','<%#Eval("UserName")%>')">
                                        <td><%#Eval("UserId")%></td>
                                        <td><%#Eval("UserName")%></td>
                                        <td><%#Eval("Email")%></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr>
                                <td colspan="3">
                                    <asp:Label ID="lbl_nodata" runat="server" />
                                </td>

                            </tr>
                        </tbody>
                    </table>
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
        function getUser(id, name) {
            window.opener.getUser(id, name);
            window.close();
        }
       $(function () {
            $(document).on("click","#btn_close", function () {
                window.close();
            });

        });

    </script>

</asp:Content>
