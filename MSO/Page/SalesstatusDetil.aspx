<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesstatusDetil.aspx.cs" Inherits="MSO.Page.SalesstatusDetil" EnableSessionState="ReadOnly" %>

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
            border-top: 1px solid #cad4d9;
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

        .td {
            text-align: center;
            background-color: #f5f9fb;
            color: #31799c;
            padding: 8px;
            font-size: 12px;
            border: 1px solid #cad4d9;
            white-space: nowrap;
        }
    </style>
    <asp:HiddenField ID="hid_DBNAME" runat="server" />
    <asp:HiddenField ID="hid_sAR" runat="server" />
    <asp:HiddenField ID="hid_sDocNo" runat="server" />
    <asp:HiddenField ID="hid_iDocType" runat="server" />
    <br />
    <div class="title">매출현황상세</div>
    <div style="margin-top: 10px;" class="header">
        <table class="tableList_01" style="width: 640px">
            <tr>
                <td  class="td">문서 번호 </td>
                <td>
                    <asp:Label ID="lbl_INVNUMBER" runat="server" />
                </td>
                <td class="td">거래선 PO번호 </td>
                <td>
                    <asp:Label ID="lbl_COSTPO" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="td">판매처 코드 </td>
                <td>
                    <asp:Label ID="lbl_CUSTOMER" runat="server" />
                </td>
                <td class="td">판매처 명 </td>
                <td>
                    <asp:Label ID="lbl_BILNAME" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="td">출고 번호 </td>
                <td colspan="3">
                    <asp:Label ID="lbl_SHINUMBER" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 85px;" class="td">문서 일자 </td>
                <td style="width: 160px;">
                    <asp:Label ID="lbl_INVDATE" runat="server" />
                </td>
                <td style="width: 85px;"  class="td">창고 </td>
                <td style="width: 160px;">
                    <asp:Label ID="lbl_LOCATION" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="td">납품처 코드 </td>
                <td>
                    <asp:Label ID="lbl_SHIPTO" runat="server" />
                </td>
                <td class="td">납품처 명 </td>
                <td>
                    <asp:Label ID="lbl_SHPNAME" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="td">설명 </td>
                <td>
                    <asp:Label ID="lbl_DESCR" runat="server" />
                </td>
                <td class="td">참조 </td>
                <td>
                    <asp:Label ID="lbl_REFERENCE" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <hr />
    <div class="detils" style="width:100%; height:300px; overflow-y:auto">
        <table id="tab" class="tableList_01" style="width:640px">
            <colgroup>
                <col />
                <col />
                <col />
                <col />
                <col />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>품목 코드</th>
                    <th>품목명</th>
                    <th>수량</th>
                    <th>단위</th>
                    <th>단가</th>
                    <th>금액</th>
                    <th>직접 재료비</th>

                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rep_List" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td class="center"><%#Eval("LINENUM")%></td>
                            <td class="left"><%#Eval("ITEM")%></td>
                            <td><%#Eval("ITEMNAME")%></td>
                            <td class="right"><%#SetComma(Eval("QTY"))%></td>
                            <td><%#Eval("UNIT")%></td>
                            
                            <td class="right"><%#SetComma(Eval("UNITPRICE"))%></td>
                            <td class="right"><%#SetComma(Eval("AMOUNT"))%></td>
                            <td class="right"><%#SetComma(Eval("COGS"))%></td>

                        </tr>
                    </ItemTemplate>
                </asp:Repeater>

            </tbody>
            <tr runat="server" id="tr">
                <td colspan="7">
                    <asp:Label ID="lbl_nodata" runat="server" /></td>
            </tr>
        </table>


    </div>
</asp:Content>
