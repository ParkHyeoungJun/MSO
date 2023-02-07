<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CostmerFind.aspx.cs" Inherits="MSO.Page.CostmerFind" EnableSessionState="ReadOnly" %>

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
            font-size: 14px;
        }
    </style>
    <asp:HiddenField ID="hid_DBNAME" runat="server" />
    <div class="title">거래선관리</div>

    <div>
        <table>
            <tr>
                <td colspan="4">
                    <table>
                        <tr   >
                            <td> 검색 조건:
                                <asp:DropDownList ID="ddl_Type" runat="server">
                                    <asp:ListItem Value="IDCUST">거래선코드</asp:ListItem>
                                    <asp:ListItem Value="NAMECUST">거래선명</asp:ListItem>
                                    <asp:ListItem Value="IDTAXREGI1">사업자번호</asp:ListItem>
                                    <asp:ListItem Value="TEXTSTRE1">주소</asp:ListItem>
                                    <asp:ListItem Value="TEXTSTRE2">상세주소</asp:ListItem>
                                    <asp:ListItem Value="CODEPSTL">우편번호</asp:ListItem>
                                    <asp:ListItem Value="NAMECTAC">담당자</asp:ListItem>
                                </asp:DropDownList></td>
                              <td><asp:TextBox ID="tb_Search" runat="server" style="margin-bottom:4px"></asp:TextBox></td>
                             <td><asp:Button ID="btn_List" runat="server" Text="검색" CssClass="btn-primary" OnClick="btn_List_Click" style="margin-bottom:4px" /></td>
                        </tr>

                    </table>


                    
                    
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <table id="tab" class="tableList_01">
                        <colgroup>
                            <col style="width: 10px;" />
                            <col style="width: 100px;" />
                            <col style="width: 100px;" />
                            <col style="width: 120px;" />
                            <col style="width: 180px;" />
                            <col style="width: 80px;" />
                            <col style="width: 50px;" />
                            <col style="width: 50px;" />
                            <col style="width: 80px;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>거래선코드</th>
                                <th>거래선명</th>
                                <th>사업자번호</th>
                                <th>주소</th>
                                <th>상세주소</th>
                                <th>우편번호</th>
                                <th>담당자</th>
                                <th>이메일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rep_List" runat="server">
                                <ItemTemplate>
                                    <tr style='cursor: pointer' onclick="getCustem('<%#Eval("IDCUST")%>','<%#Eval("NAMECUST")%>')">
                                        <td class="right"><%#Eval("rownum")%></td>
                                        <td class="left"><%#Eval("IDCUST")%></td>
                                        <td><%#Eval("NAMECUST")%></td>
                                        <td><%#Eval("TAXREGNO")%></td>
                                        <td><%#Eval("ADDR1")%></td>
                                        <td><%#Eval("ADDR2")%></td>
                                        <td class="left"><%#Eval("CODEPSTL")%></td>
                                        <td><%#Eval("NAMECTAC")%></td>
                                        <td><%#Eval("EMAIL")%></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>

                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
        <table style="width: 825px">
            <tr>
                <td>
                    <asp:Label ID="lbl_nodata" runat="server" /></td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <div class="center">
                        <cc1:PagerV2_8 ID="pager" runat="server" OnCommand="Command" PageSize="10" />
                    </div>
                </td>

            </tr>
          
        </table>
    </div>
    <!-- 페이지 처리 하기위한 현재 페이지-->
    <asp:HiddenField ID="hid_pageNum" runat="server" Value="1" />
    <script type="text/javascript">
        function getCustem(cnum, cname) {
           // alert("넘김" + cname)
            window.opener.getCustem(cnum, cname);
            window.close();
        }

        $(function () {
            $(document).on("click", "#btn_close", function () {
                window.close();
            })
        })
    </script>

</asp:Content>
