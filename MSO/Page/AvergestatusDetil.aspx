<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AvergestatusDetil.aspx.cs" Inherits="MSO.Page.AvergestatusDetil" EnableSessionState="ReadOnly" %>

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
            border-top: 1px solid #cad4d9;
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
    <asp:HiddenField ID="hid_iDocType" runat="server" />
    <asp:HiddenField ID="hid_sAR" runat="server" />
    <asp:HiddenField ID="hid_POsDocNo" runat="server" />
    <asp:HiddenField ID="hid_INVsDocNo" runat="server" />
    <br />
    <div class="title">매입현황상세</div>
    <div style="margin-top: 10px; width:640px" class="header" >
        <table class="tableList_01" style="width: 640px">
            <tr>
                <td style="width: 70px;" class="td">문서 번호 </td>
                <td colspan="3" style="border-top:1px solid #cad4d9;">
                    <asp:Label ID="lbl_InvNum" runat="server"  />
                </td>
            </tr>
            <tr>
                <td style="width: 85px;" class="td">구매처 코드 </td>
                <td>
                    <asp:Label  style="width: 160px" ID="lbl_VendNum" runat="server" />
                </td>
                <td style="width: 85px;" class="td">구매처 명 </td>
                <td>
                    <asp:Label style="width: 160px" ID="lbl_VendName" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="td">입고 번호 </td>
                <td colspan="3">
                    <asp:Label ID="lbl_RcpNum" runat="server" />
                </td>
            </tr>         
            <tr>
                <td style="width: 85px;" class="td" >문서 일자 </td>
                <td>
                    <asp:Label style="width: 160px" ID="lbl_InvDate" runat="server" />
                </td>
                <td style="width: 85px;" class="td">창고 </td>
                <td>
                    <asp:Label style="width: 160px" ID="lbl_Location" runat="server" />
                </td>
            </tr>           
            <tr>
                <td style="width: 85px;" class="td">설명 </td>
                <td>
                    <asp:Label style="width: 160px" ID="lbl_Description" runat="server" />
                </td>
                <td style="width: 85px;" class="td">참조 </td>
                <td>
                    <asp:Label style="width: 160px" ID="lbl_Reference" runat="server" />
                </td>
            </tr>
            
        </table>
        <hr />
    </div>
    
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
                </tr>                
            </thead>            
            <tbody>
                <asp:Repeater ID="rep_List1" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center"><%#Eval("LINENUM")%></td>
                                        <td><%#Eval("ITEM")%></td>
                                        <td><%#Eval("ITEMNAME")%></td>
                                        <td class="right"><%#SetComma(Eval("QTY"))%></td>
                                        <td><%#Eval("UNIT")%></td>
                                        <td class="right"><%#SetComma(Eval("UNITCOST"))%></td>
                                        <td class="right"><%#SetComma(Eval("AMOUNT"))%></td>
                                     </tr>
                                </ItemTemplate>
                  </asp:Repeater>
                <tr  runat="server">
                    <td id="td_nodata" colspan="7">
                       <asp:Label ID="lbl_nodata" runat="server" Visible="false"/>
                    </td>
                 </tr>
            </tbody>
            
        </table>



    </div>
</asp:Content>
