<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="getHoilday.aspx.cs" Inherits="MSO.Page.getHoilday" EnableSessionState="ReadOnly" %>

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
    </style><asp:HiddenField ID="hid_DBNAME" runat="server" />
<div class="title">공휴일 API 데이터 가져오기</div>
    <table>
        <tr>
            <td>년도</td>
            <td>
                <%--<input type="text" runat="server" id="txt_sdate" />--%>
                <asp:TextBox ID="txt_date" runat="server" numberOnly MaxLength="4" />
            <td>
                <asp:Button ID="btn_Save" runat="server" CssClass="btn-primary" Text="가져오기" OnClick="btn_Save_Click" />
                &nbsp;
                <asp:Button ID="btn_List" runat="server" CssClass="btn-primary" Text="조회" OnClick="btn_List_Click" OnClientClick="return ValCheck();" />

            </td>
    </table>
    <br />
    <table class="tableList_01">
        <colgroup>
            <col style="width: 100px;" />
            <col style="width: 100px;" />
            <col style="width: 100px;" />

        </colgroup>
        <thead>
            <tr>
                <th>공휴일명</th>
                <th>공휴일여부</th>
                <th>날짜</th>
            </tr>

        </thead>
        <tbody>
            <asp:Repeater ID="rep_List" runat="server">
                <ItemTemplate>
                    <tr style='cursor: pointer'>
                        <td class="left"><%#Eval("title")%></td>
                        <td class="center"><%#Eval("YN")%></td>
                        <td class="center" ><%#Eval("HoliDay")%></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
    <table>
        <tr>
            <td colspan="3">
                <asp:Label ID="lbl_NoData" runat="server"></asp:Label></td>

        </tr>

    </table>
  
    <script type="text/javascript">
        function ValCheck()
        {
            if ($("#<%=txt_date.ClientID%>").val() == "")
                {
                    alert("년도을 입력하여 주세요");
                    return false;
                }
        }



        $(function () {
            $("#btn_close").click(function () {
                window.close();
            })

            //$("#<%=txt_date.ClientID%>")
            $(document).on("propertychange change keyup paste input", "input:text[numberOnly]", function (e) {
                e.preventDefault();
                 $(this).val(function (index, value) {
                    return value
                        .replace(/\D/g, "")
                        .replace(/\B(?=(\d{3})+(?!\d))/g, "")
                        ;
                });
               
            });
          
        })

    </script>

</asp:Content>
