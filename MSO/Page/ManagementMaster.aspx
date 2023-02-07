<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagementMaster.aspx.cs" Inherits="MSO.Page.ManagementMaster" EnableSessionState="ReadOnly" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script src="/Scripts/jquery-3.3.1.js"></script>
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

        .tableList_01 {
            width: 2800px;
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
                width: 30px;
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
                    width: 48px;
                    border: 0px;
                }

       .title {
            font-weight: bold;
            font-size:14px;
        }

        /* page-loading */
        #loading {
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            position: fixed;
            display: block;
            opacity: 0.6;
            background: #e4e4e4;
            z-index: 99;
            text-align: center;
        }



            #loading > img {
                position: absolute;
                top: 50%;
                left: 50%;
                z-index: 100;
            }

            #loading > p {
                position: absolute;
                top: 57%;
                left: 43%;
                z-index: 101;
            }
    </style>
    <asp:HiddenField ID="hid_DBNAME" runat="server" />
    <div class="title">
        경영계획 관리
    </div>

    <table>
        <tr>
            <td>년도</td>
            <td>
                <asp:DropDownList ID="ddl_Year" runat="server"></asp:DropDownList>
            </td>
            <td>버젼</td>
            <td>
                <select id="sel_Servion">
                </select>
                <asp:HiddenField ID="hid_servion" runat="server" Value="1" />
            </td>
            <td>
                <asp:Button ID="Btn_Excel" runat="server" CssClass="btn-primary" OnClick="btn_Excel_Click" Text="엑셀 저장"   
         />
                <button class="btn-primary" id="btn_Addco">거래선 등록</button>
            </td>
        </tr>
        <tr>
            <td colspan="5">&nbsp</td>

        </tr>
    </table>
    <!-- 차후 엑셀 저장 하기 위한-->
    <table id="tab" class="tableList_01">
        <colgroup>
            <col style='width: 65px' />
            <col style='width: 75px' />
            <col style='width: 53px' />
            <col style='width: 71px' />
            <col style='width: 30px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
            <col style='width: 48px' />
        </colgroup>


        <thead>
            <tr>
                <th>담당아이디</th>
                <th>담당이름</th>
                <th>거래선</th>
                <th>거래선명</th>
                <th style='width: 60px'>1월 계획  </th>
                <th style='width: 60px'>1월 실적</th>
                <th style='width: 60px'>2월 계획  </th>
                <th style='width: 60px'>2월 실적</th>
                <th style='width: 60px'>3월 계획  </th>
                <th style='width: 60px'>3월 실적</th>
                <th style='width: 60px'>1/4월 계획  </th>
                <th style='width: 60px'>1/4월 실적</th>
                <th style='width: 60px'>4월 계획</th>
                <th style='width: 60px'>4월 실적</th>
                <th style='width: 60px'>5월 계획</th>
                <th style='width: 60px'>5월 실적</th>
                <th style='width: 60px'>6월 계획</th>
                <th style='width: 60px'>6월 실적</th>
                <th style='width: 60px'>2/4 분기 계획</th>
                <th style='width: 60px'>2/4 분기 실적</th>
                <th style='width: 60px'>상반기 계획</th>
                <th style='width: 60px'>상반기 실적</th>
                <th style='width: 60px'>7월 계획</th>
                <th style='width: 60px'>7월 실적</th>
                <th style='width: 60px'>8월 계획</th>
                <th style='width: 60px'>8월 실작</th>
                <th style='width: 60px'>9월 계획</th>
                <th style='width: 60px'>9월 실적</th>
                <th style='width: 60px'>3/4 분기 계획</th>
                <th style='width: 60px'>3/4 분기 실적</th>
                <th style='width: 60px'>10월 계획</th>
                <th style='width: 60px'>10월 실적</th>
                <th style='width: 60px'>11월 계획</th>
                <th style='width: 60px'>11월 실적</th>
                <th style='width: 60px'>12월 계획</th>
                <th style='width: 60px'>12월 실적</th>
                <th style='width: 60px'>4/4 분기 계획</th>
                <th style='width: 60px'>4/4 분기 실적</th>
                <th style='width: 60px'>하반기 계획</th>
                <th style='width: 60px'>하반기 실작</th>
                <th style='width: 60px'>연간 계획</th>
                <th style='width: 60px'>연간 실적</th>
                <th style='width: 60px'>재료비</th>
                <th style='width: 60px'>조립비</th>
                <th style='width: 60px'>영업이익 계획</th>
                <th style='width: 60px'>영업이익 실적</th>
                <th style='width: 60px'>매출 달성율</th>
            </tr>
        </thead>


    </table>
    <p></p>
    <input id="file_upload" name="file_upload" type="file" />
    <!-- 파일 업로드후 차후 삭제하기위함 -->
    <input type="hidden" id="hid_filename" />
    <br />

    <button id="btn_upload" class="btn-primary">엑셀 임포트</button>


    <input id="btn_save" type="button" value="저장" class="btn-primary" />
    <asp:HiddenField ID="hid_FileName" runat="server" />

    <!--로딩바-->
    <div id="loading" style="margin-left: 0px;">
        <img src="/images/loading.gif">
        <p>조회중..잠시기다려주세요.</p>
    </div>




    <script type="text/javascript">
        var rowidx = 0;
        var savebol = false; // 저장 여부
        function Save(row, id) {
            //alert( $(id))
            var params = {
                Num: $("#hid_Num" + row).val(),
                Idx: $("#hid_Idx" + row).val(),
                Servion: $(id).val(), // 버젼 일괄성 위해
                P1: $("#txt_p1_" + row).val(),
                R1: $("#txt_r1_" + row).val(),
                P2: $("#txt_p2_" + row).val(),
                R2: $("#txt_r2_" + row).val(),
                P3: $("#txt_p3_" + row).val(),
                R3: $("#txt_r3_" + row).val(),
                Q1p: $("#txt_q1p_" + row).val(),
                Q1r: $("#txt_q1r_" + row).val(),
                P4: $("#txt_p4_" + row).val(),
                R4: $("#txt_r4_" + row).val(),
                P5: $("#txt_p5_" + row).val(),
                R5: $("#txt_r5_" + row).val(),
                P6: $("#txt_p6_" + row).val(),
                R6: $("#txt_r6_" + row).val(),
                Q2p: $("#txt_q2p_" + row).val(),
                Q2r: $("#txt_q2r_" + row).val(),
                S1p: $("#txt_s1p_" + row).val(),
                S1r: $("#txt_s1r_" + row).val(),
                P7: $("#txt_p7_" + row).val(),
                R7: $("#txt_r7_" + row).val(),
                P8: $("#txt_p8_" + row).val(),
                R8: $("#txt_r8_" + row).val(),
                P9: $("#txt_p9_" + row).val(),
                R9: $("#txt_r9_" + row).val(),
                Q3p: $("#txt_q3p_" + row).val(),
                Q3r: $("#txt_q3r_" + row).val(),
                P10: $("#txt_p10_" + row).val(),
                R10: $("#txt_r10_" + row).val(),
                P11: $("#txt_p11_" + row).val(),
                R11: $("#txt_r11_" + row).val(),
                P12: $("#txt_p12_" + row).val(),
                R12: $("#txt_r12_" + row).val(),
                Q4p: $("#txt_q4p_" + row).val(),
                Q4r: $("#txt_q4r_" + row).val(),
                S2p: $("#txt_s2p_" + row).val(),
                S2r: $("#txt_s2r_" + row).val(),
                Yp: $("#txt_yp_" + row).val(),
                Yr: $("#txt_yr_" + row).val(),
                Raw: $("#txt_raw_" + row).val(),
                Ass: $("#txt_ass_" + row).val(),
                Plp: $("#txt_plp_" + row).val(),
                Plr: $("#txt_plr_" + row).val(),
                Rusult: $("#txt_result_" + row).val()
            }
            //alert($("#txt_result_" + row).val());
            //alert(params.Rusult)
            // return;
            //ajax 
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/ManagementWebService.asmx/sp_ManagementSub_Ins", // 컨트롤러에서 대기중인 URL 주소이다.
               // async: false, // 동기로 처리 
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    rowidx = +1;
                    //      alert(Object.keys(res).length)
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("저장 실패" + XMLHttpRequest.responseText)
                }
            });
            //ajax 
        }
        //모든 컬럼 총합계을 구한다 
        function AllCount() {
            var total = $(".tr").length; // 총 행수 마지막 행은 합계이니 안한다 
            var p1 = 0;
            var r1 = 0;
            var p2 = 0;
            var r2 = 0;
            var p3 = 0;
            var r3 = 0;
            var q1p = 0;
            var q1r = 0;
            var p4 = 0;
            var r4 = 0;
            var p5 = 0;
            var r5 = 0;
            var p6 = 0;
            var r6 = 0;
            var q2p = 0;
            var q2r = 0;
            var s1p = 0;
            var s1r = 0;
            var p7 = 0;
            var r7 = 0;
            var p8 = 0;
            var r8 = 0;
            var p9 = 0;
            var r9 = 0;
            var q3p = 0;
            var q3r = 0;
            var p10 = 0;
            var r10 = 0;
            var p11 = 0;
            var r11 = 0;
            var p12 = 0;
            var r12 = 0;
            var q4p = 0;
            var q4r = 0;
            var s2p = 0;
            var s2r = 0;
            var yp = 0;
            var yr = 0;
            var raw = 0;
            var ass = 0;
            var plp = 0;
            var plr = 0;
            var Subplp = 0;
            var Subplr = 0;
            var result = 0;



            $(".tr").each(function (i, item) {
                // 맨 마지막은 합계이므료 저장 안한다 
                if (i != total - 1) {
                    // alert(addComma(p1))
                    if ($("#lbl_CusttomerName" + i).text() == "Sub Total:") {
                        p1 += Number($("#txt_p1_" + i).val().replaceAll(",", ""));
                        r1 += Number($("#txt_r1_" + i).val().replaceAll(",", ""));

                        p2 += Number($("#txt_p2_" + i).val().replaceAll(",", ""));
                        r2 += Number($("#txt_r2_" + i).val().replaceAll(",", ""));

                        p3 += Number($("#txt_p3_" + i).val().replaceAll(",", ""));
                        r3 += Number($("#txt_r3_" + i).val().replaceAll(",", ""));

                        q1p += Number($("#txt_q1p_" + i).val().replaceAll(",", ""));
                        q1r += Number($("#txt_q1r_" + i).val().replaceAll(",", ""));

                        p4 += Number($("#txt_p4_" + i).val().replaceAll(",", ""));
                        r4 += Number($("#txt_r4_" + i).val().replaceAll(",", ""));

                        p5 += Number($("#txt_p5_" + i).val().replaceAll(",", ""));
                        r5 += Number($("#txt_r5_" + i).val().replaceAll(",", ""));

                        p6 += Number($("#txt_p6_" + i).val().replaceAll(",", ""));
                        r6 += Number($("#txt_r6_" + i).val().replaceAll(",", ""));

                        q2p += Number($("#txt_q2p_" + i).val().replaceAll(",", ""));
                        q2r += Number($("#txt_q2r_" + i).val().replaceAll(",", ""));

                        s1p += Number($("#txt_s1p_" + i).val().replaceAll(",", ""));
                        s1r += Number($("#txt_s1r_" + i).val().replaceAll(",", ""));

                        p7 += Number($("#txt_p7_" + i).val().replaceAll(",", ""));
                        r7 += Number($("#txt_r7_" + i).val().replaceAll(",", ""));

                        p8 += Number($("#txt_p8_" + i).val().replaceAll(",", ""));
                        r8 += Number($("#txt_r8_" + i).val().replaceAll(",", ""));

                        p9 += Number($("#txt_p9_" + i).val().replaceAll(",", ""));
                        r9 += Number($("#txt_r9_" + i).val().replaceAll(",", ""));

                        q3p += Number($("#txt_q3p_" + i).val().replaceAll(",", ""));
                        q3r += Number($("#txt_q3r_" + i).val().replaceAll(",", ""));


                        p10 += Number($("#txt_p10_" + i).val().replaceAll(",", ""));
                        r10 += Number($("#txt_r10_" + i).val().replaceAll(",", ""));

                        p11 += Number($("#txt_p11_" + i).val().replaceAll(",", ""));
                        r11 += Number($("#txt_r11_" + i).val().replaceAll(",", ""));

                        p12 += Number($("#txt_p12_" + i).val().replaceAll(",", ""));
                        r12 += Number($("#txt_r12_" + i).val().replaceAll(",", ""));

                        q4p += Number($("#txt_q4p_" + i).val().replaceAll(",", ""));
                        q4r += Number($("#txt_q4r_" + i).val().replaceAll(",", ""));
                        //alert(q4p)
                        console.log(q4p)

                        //return;
                        s2p += Number($("#txt_s2p_" + i).val().replaceAll(",", ""));
                        s2r += Number($("#txt_s2r_" + i).val().replaceAll(",", ""));

                        yp += Number($("#txt_yp_" + i).val().replaceAll(",", ""));
                        yr += Number($("#txt_yr_" + i).val().replaceAll(",", ""));

                        raw += Number($("#txt_raw_" + i).val().replaceAll(",", ""));
                        ass += Number($("#txt_ass_" + i).val().replaceAll(",", ""));

                        Subplp += Number($("#txt_plp_" + i).val().replaceAll(",", ""));
                        Subplr += Number($("#txt_plr_" + i).val().replaceAll(",", ""));

                        ////alert(plp);
                        //plr = Math.round((Number($("#txt_yr_" + i).val().replaceAll(",", ""))
                        //    * (100 - (
                        //    Number($("#txt_raw_" + i).val().replaceAll(",", "")) +
                        //    Number($("#txt_ass_" + i).val().replaceAll(",", ""))
                        //    ))
                        //) / 100,0);
                        //result = Math.round((plr / plp) * 100);

                        //alert(result)
                        //$("#txt_result_" + i).val(result);
                    }
                    else {
                        plp = Math.round((Number($("#txt_yp_" + i).val().replaceAll(",", ""))
                            * (100 - (
                                Number($("#txt_raw_" + i).val().replaceAll(",", "")) +
                                Number($("#txt_ass_" + i).val().replaceAll(",", ""))
                            ))
                        ) / 100, 0);
                        //alert(plp);
                        plr = Math.round((Number($("#txt_yr_" + i).val().replaceAll(",", ""))
                            * (100 - (
                                Number($("#txt_raw_" + i).val().replaceAll(",", "")) +
                                Number($("#txt_ass_" + i).val().replaceAll(",", ""))
                            ))
                        ) / 100, 0);
                        $("#txt_plp_" + i).val(addComma(plp))
                        $("#txt_plr_" + i).val(addComma(plr))
                    }
                }
                //          $("#txt_result_" + i).attr("disabled", "disabled");
            })


            // 마지막 컬럼을 찾아 합계을 넣어준다 
            $(".p1").last().val(addComma(p1))
            $(".r1").last().val(addComma(r1))
            $(".p2").last().val(addComma(p2))
            $(".r2").last().val(addComma(r2))
            $(".p3").last().val(addComma(p3))
            $(".r3").last().val(addComma(r3))
            $(".q1p").last().val(addComma(q1p))
            $(".q1r").last().val(addComma(q1r))
            $(".p4").last().val(addComma(p4))
            $(".r4").last().val(addComma(r4))
            $(".p5").last().val(addComma(p5))
            $(".r5").last().val(addComma(r5))
            $(".p6").last().val(addComma(p6))
            $(".r6").last().val(addComma(r6))

            $(".q2p").last().val(addComma(q2p))
            $(".q2r").last().val(addComma(q2r))
            $(".s1p").last().val(addComma(s1p))
            $(".s1r").last().val(addComma(s1r))
            $(".p7").last().val(addComma(p7))
            $(".r7").last().val(addComma(r7))
            $(".p8").last().val(addComma(p8))
            $(".r8").last().val(addComma(r8))
            $(".p9").last().val(addComma(p9))
            $(".r9").last().val(addComma(r9))
            $(".q3p").last().val(addComma(q3p))
            $(".q3r").last().val(addComma(q3r))
            $(".p10").last().val(addComma(p10))
            $(".r10").last().val(addComma(r10))
            $(".p11").last().val(addComma(p11))
            $(".r11").last().val(addComma(r11))
            $(".p12").last().val(addComma(p12))
            $(".r12").last().val(addComma(r12))
            //alert(q4p)
            //alert(q4p)
            $(".q4p").last().val(addComma(q4p))
            $(".q4r").last().val(addComma(q4r))
            $(".s2p").last().val(addComma(s2p))
            $(".s2r").last().val(addComma(s2r))
            $(".yp").last().val(addComma(yp))
            $(".yr").last().val(addComma(yr))

            // $(".raw").last().val(addComma(raw))
            // $(".ass").last().val(addComma(ass))
            $(".plp").last().val(addComma(Subplp))
            $(".plr").last().val(addComma(Subplr))


            var dbplp = 0;
            var dbplr = 0;
            var dbresult = 0;
            $(".tr").each(function (i, item) {
                if (i != total - 1) {
                    //alert(i)
                    if ($("#lbl_CusttomerName" + i).text() == "Sub Total:") {
                        dbplp += Number($("#txt_plp_" + i).val().replaceAll(",", ""));
                        dbplr += Number($("#txt_plr_" + i).val().replaceAll(",", ""));
                        dbresult =
                            Math.round((Number($("#txt_plr_" + i).val().replaceAll(",", ""))
                                / Number($("#txt_plp_" + i).val().replaceAll(",", ""))
                            ) * 100, 0);
                        if (isNaN(dbresult)) {
                            dbresult = 0;
                        }
                        if (!isFinite(dbresult)) {
                            dbresult = 0;
                        }
                        //alert(i+","+ dbresult)
                        $("#txt_result_" + i).val(addComma(dbresult));
                    }

                }
            })
            //alert(addComma(dbplp))
            $(".plp").last().val(addComma(dbplp));
            $(".plr").last().val(addComma(dbplr));
            //dbplr


        }

        /// 클래스아이디 마지막 행을 찾아 SUB Total을 계산
        function FindRowSet(idx,lastidx) {
           
            //alert(myclass)
           // var id = $("#txt_p1_" + i).data("id")
            var sump1 = 0;
            var sumr1 = 0;
            var sump2 = 0;
            var sumr2 = 0;
            var sump3 = 0;
            var sumr3 = 0;


            var sumq1p = 0;
            var sumq1r = 0;
            var sump4 = 0;
            var sumr4 = 0;

            var sump5 = 0;
            var sumr5 = 0;

            var sump6 = 0;
            var sumr6 = 0;

            var sumq2p = 0;
            var sumq2r = 0;

            var sums1p = 0; 
            var sums1r = 0; 

            var sump7 = 0;
            var sumr7 = 0;

            var sump8 = 0;
            var sumr8 = 0;

            var sump9 = 0;
            var sumr9 = 0;

            var sumq3p = 0;
            var sumq3r = 0;

            var sump10 = 0;
            var sumr10 = 0;

            var sump11 = 0;
            var sumr11 = 0;

            var sump12 = 0;
            var sumr12 = 0;

            var sumq4p = 0;
            var sumq4r = 0;

            var sums2p = 0; 
            var sums2r = 0; 

            var sumyp = 0;
            var sumyr = 0;

            var sumplp = 0;
            var sumplr = 0;



            for (var i = idx; i < lastidx; i++) {
                // 1월
                sump1 += Number($("#txt_p1_" + i).val().replaceAll(",", ""));
                sumr1 += Number($("#txt_r1_" + i).val().replaceAll(",", ""));

                //2월 
                sump2 += Number($("#txt_p2_" + i).val().replaceAll(",", ""));
                sumr2 += Number($("#txt_r2_" + i).val().replaceAll(",", ""));

                 //3월 
                sump3 += Number($("#txt_p3_" + i).val().replaceAll(",", ""));
                sumr3 += Number($("#txt_r3_" + i).val().replaceAll(",", ""));

                //1 분기
                sumq1p += Number($("#txt_q1p_" + i).val().replaceAll(",", ""));
                sumq1r += Number($("#txt_q1r_" + i).val().replaceAll(",", ""));

                //4월 
                sump4 += Number($("#txt_p4_" + i).val().replaceAll(",", ""));
                sumr4 += Number($("#txt_r4_" + i).val().replaceAll(",", ""));

                //5월 
                sump5 += Number($("#txt_p5_" + i).val().replaceAll(",", ""));
                sumr5 += Number($("#txt_r5_" + i).val().replaceAll(",", ""));

                //6월 
                sump6 += Number($("#txt_p6_" + i).val().replaceAll(",", ""));
                sumr6 += Number($("#txt_r6_" + i).val().replaceAll(",", ""));

                //2 분기 
                sumq2p += Number($("#txt_q2p_" + i).val().replaceAll(",", ""));
                sumq2r += Number($("#txt_q2r_" + i).val().replaceAll(",", ""));

                //상반기 
                sums1p += Number($("#txt_s1p_" + i).val().replaceAll(",", ""));
                sums1r += Number($("#txt_s1r_" + i).val().replaceAll(",", ""));

                //7월 
                sump7 += Number($("#txt_p7_" + i).val().replaceAll(",", ""));
                sumr7 += Number($("#txt_r7_" + i).val().replaceAll(",", ""));

                //8월 
                sump8 += Number($("#txt_p8_" + i).val().replaceAll(",", ""));
                sumr8 += Number($("#txt_r8_" + i).val().replaceAll(",", ""));

                //9월 
                sump9 += Number($("#txt_p9_" + i).val().replaceAll(",", ""));
                sumr9 += Number($("#txt_r9_" + i).val().replaceAll(",", ""));

                // 3분기 
                sumq3p += Number($("#txt_q3p_" + i).val().replaceAll(",", ""));
                sumq3r += Number($("#txt_q3r_" + i).val().replaceAll(",", ""));

                //10월 
                sump10 += Number($("#txt_p10_" + i).val().replaceAll(",", ""));
                sumr10 += Number($("#txt_r10_" + i).val().replaceAll(",", ""));

                //11월 
                sump11 += Number($("#txt_p11_" + i).val().replaceAll(",", ""));
                sumr11 += Number($("#txt_r11_" + i).val().replaceAll(",", ""));

                //12월 
                sump12 += Number($("#txt_p12_" + i).val().replaceAll(",", ""));
                sumr12 += Number($("#txt_r12_" + i).val().replaceAll(",", ""));

                //4 분기 
                sumq4p += Number($("#txt_q4p_" + i).val().replaceAll(",", ""));
                sumq4r += Number($("#txt_q4r_" + i).val().replaceAll(",", ""));
                
                //상반기 
                sums2p += Number($("#txt_s2p_" + i).val().replaceAll(",", ""));
                sums2r += Number($("#txt_s2r_" + i).val().replaceAll(",", ""));

                // 연간 
                sumyp += Number($("#txt_yp_" + i).val().replaceAll(",", ""));
                sumyr += Number($("#txt_yr_" + i).val().replaceAll(",", ""));

                // 영업이익 
                sumplp += Number($("#txt_plp_" + i).val().replaceAll(",", ""));
                sumplr += Number($("#txt_plr_" + i).val().replaceAll(",", ""));

            }
            // 1월 sub total
            $("#txt_p1_" + (lastidx)).val(addComma(sump1));
            $("#txt_r1_" + (lastidx)).val(addComma(sumr1));

            // 2월

            $("#txt_p2_" + (lastidx)).val(addComma(sump2));
            $("#txt_r2_" + (lastidx)).val(addComma(sumr2));

            // 3월 
            $("#txt_p3_" + (lastidx)).val(addComma(sump3));
            $("#txt_r3_" + (lastidx)).val(addComma(sumr3));

            //1 분기
            $("#txt_q1p_" + (lastidx)).val(addComma(sumq1p));
            $("#txt_q1r_" + (lastidx)).val(addComma(sumq1r));

            //4 월 
            $("#txt_p4_" + (lastidx)).val(addComma(sump4));
            $("#txt_r4_" + (lastidx)).val(addComma(sumr4));

            //5 월 
            $("#txt_p5_" + (lastidx)).val(addComma(sump5));
            $("#txt_r5_" + (lastidx)).val(addComma(sumr5));

            //6 월 
            $("#txt_p6_" + (lastidx)).val(addComma(sump6));
            $("#txt_r6_" + (lastidx)).val(addComma(sumr6));

            //2 분기
            $("#txt_q2p_" + (lastidx)).val(addComma(sumq2p));
            $("#txt_q2r_" + (lastidx)).val(addComma(sumq2r));

            // 상반기 
            $("#txt_s1p_" + (lastidx)).val(addComma(sums1p));
            $("#txt_s1r_" + (lastidx)).val(addComma(sums1r));

            // 7 월 
            $("#txt_p7_" + (lastidx)).val(addComma(sump7));
            $("#txt_r7_" + (lastidx)).val(addComma(sumr7));

            // 8 월 
            $("#txt_p8_" + (lastidx)).val(addComma(sump8));
            $("#txt_r8_" + (lastidx)).val(addComma(sumr8));

            // 9 월 
            $("#txt_p9_" + (lastidx)).val(addComma(sump9));
            $("#txt_r9_" + (lastidx)).val(addComma(sumr9));

            //3 분기
            $("#txt_q3p_" + (lastidx)).val(addComma(sumq3p));
            $("#txt_q3r_" + (lastidx)).val(addComma(sumq3r));

            //10 분기 
            $("#txt_p10_" + (lastidx)).val(addComma(sump10));
            $("#txt_r10_" + (lastidx)).val(addComma(sumr10));

            //11 분기 
            $("#txt_p11_" + (lastidx)).val(addComma(sump11));
            $("#txt_r11_" + (lastidx)).val(addComma(sumr11));

             //12 분기 
            $("#txt_p12_" + (lastidx)).val(addComma(sump12));
            $("#txt_r12_" + (lastidx)).val(addComma(sumr12));

             //4 분기
            $("#txt_q4p_" + (lastidx)).val(addComma(sumq4p));
            $("#txt_q4r_" + (lastidx)).val(addComma(sumq4r));

             // 하반기 
            $("#txt_s2p_" + (lastidx)).val(addComma(sums2p));
            $("#txt_s2r_" + (lastidx)).val(addComma(sums2r));

            // 연간 
            $("#txt_yp_" + (lastidx)).val(addComma(sumyp));
            $("#txt_yr_" + (lastidx)).val(addComma(sumyr));

            // 영업 이익 
            //plr
            $("#txt_plp_" + (lastidx)).val(addComma(sumplp));
            $("#txt_plr_" + (lastidx)).val(addComma(sumplr));


            //result = Math.round((plr / plp) * 100);
            // 매출 달성율
            //$("#txt_result_" + (lastidx)).val(addComma(Math.round((sumyr / sumyp) * 100)))



            //alert($("#txt_p1_" + (lastidx + 1)).val())

            var p1 = isNull($("#txt_p1_" + idx).val().replaceAll(",", ""));
            var p2 = isNull($("#txt_p2_" + idx).val().replaceAll(",", ""));
            var p3 = isNull($("#txt_p3_" + idx).val().replaceAll(",", ""));
            $("#txt_q1p_" + idx).val(addComma(p1 + p2 + p3));
            var r1 = isNull($("#txt_r1_" + idx).val().replaceAll(",", ""));
            var r2 = isNull($("#txt_r2_" + idx).val().replaceAll(",", ""));
            var r3 = isNull($("#txt_r3_" + idx).val().replaceAll(",", ""));
            $("#txt_q1r_" + idx).val(addComma(r1 + r2 + r3));
            var p4 = isNull($("#txt_p4_" + idx).val().replaceAll(",", ""));
            var p5 = isNull($("#txt_p5_" + idx).val().replaceAll(",", ""));
            var p6 = isNull($("#txt_p6_" + idx).val().replaceAll(",", ""));
            $("#txt_q2p_" + idx).val(addComma(p4 + p5 + p6));

            var r4 = isNull($("#txt_r4_" + idx).val().replaceAll(",", ""));
            var r5 = isNull($("#txt_r5_" + idx).val().replaceAll(",", ""));
            var r6 = isNull($("#txt_r6_" + idx).val().replaceAll(",", ""));
            $("#txt_q2r_" + idx).val(addComma(r4 + r5 + r6));
            //상반기 
            $("#txt_s1p_" + idx).val(addComma(p1 + p2 + p3 + p4 + p5 + p6));
            $("#txt_s1r_" + idx).val(addComma(r1 + r2 + r3 + r4 + r5 + r6));

            var p7 = isNull($("#txt_p7_" + idx).val().replaceAll(",", ""));
            var p8 = isNull($("#txt_p8_" + idx).val().replaceAll(",", ""));
            var p9 = isNull($("#txt_p9_" + idx).val().replaceAll(",", ""));
            $("#txt_q3p_" + idx).val(addComma(p7 + p8 + p9));

            var r7 = isNull($("#txt_r7_" + idx).val().replaceAll(",", ""));
            var r8 = isNull($("#txt_r8_" + idx).val().replaceAll(",", ""));
            var r9 = isNull($("#txt_r9_" + idx).val().replaceAll(",", ""));
            $("#txt_q3r_" + idx).val(addComma(r7 + r8 + r9));

            var p10 = isNull($("#txt_p10_" + idx).val().replaceAll(",", ""));
            var p11 = isNull($("#txt_p11_" + idx).val().replaceAll(",", ""));
            var p12 = isNull($("#txt_p12_" + idx).val().replaceAll(",", ""));
            $("#txt_q4p_" + idx).val(addComma(p10 + p11 + p12));

            var r10 = isNull($("#txt_r10_" + idx).val().replaceAll(",", ""));
            var r11 = isNull($("#txt_r11_" + idx).val().replaceAll(",", ""));
            var r12 = isNull($("#txt_r12_" + idx).val().replaceAll(",", ""));
            $("#txt_q4r_" + idx).val(addComma(r10 + r11 + r12));

            // 하반기 
            $("#txt_s2p_" + idx).val(addComma(p7 + p8 + p9 + p10 + p11 + p12));
            $("#txt_s2r_" + idx).val(addComma(r7 + r8 + r9 + r10 + r11 + r12));

            // 년간 
            $("#txt_yp_" + idx).val(addComma(p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 + p10 + p11 + p12));
            $("#txt_yr_" + idx).val(addComma(r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12));

            ////   $("#txt_plp_" + idx).val()


            ////Subplp += Number($("#txt_plp_" + i).val().replaceAll(",", ""));
            ////            Subplr += Number($("#txt_plr_" + i).val().replaceAll(",", ""));
            ////  alert(idx)
        }


        function AuthServionCkeck() {
           // alert("")
            var bol = false;
            //alert($("#sel_Servion").val())
            var size = $("#sel_Servion option").length;
            var index = $('#<%=hid_servion.ClientID%>').val()//.index($('#sel_Servion option:selected')) + 1;
            var params = {
                YYYY: $("#<%=ddl_Year.ClientID%>").val()
            }
            ///
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/ManagementWebService.asmx/getServionCheck", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false,
                dataType: "text",
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    var data = res.split("[")[1]//.split("[")[0];

                    data = data.split("]")[0]
                    data = "[" + data + "]"
                    // console.log(data)
                    data = JSON.parse(data);
                    //   alert(data)
                    // 기존 tbody에 붙이면 버그가 있어 일일이 넣어줌
                    $.each(data, function (i, v) {
                        if (v.YN == "Y") {
                            bol = true;
                        }
                        else {
                            bol = false;
                            alert("작년 데이터건에 대하여 1월에만 수정 가능합니다")
                        }
                        //alert(v.YN)
                        //alert(v.servion)
                    })
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("데이터 로드 도중 실패:" + XMLHttpRequest.responseText);
                }
            });


            //alert(size+","+index)
            // 마지막 선택한것이 아니라면 버젼이 있다는 의미이므료 

            //alert("마지막:"+size + ",현재" + index )
            // 차후 && bol 비교야한다 
            if ((size != index)) {
                //alert("")

                var total = $(".tr").length;
                $(".tr").each(function (i, item) {
                    // 맨 마지막은 합계이므료 저장 안한다 
                    // alert(i + "," + total)
                    if (i != total - 1) {
                        $("#txt_p1_" + i).attr("disabled", "disabled");
                        $("#txt_r1_" + i).attr("disabled", "disabled");
                        $("#txt_p2_" + i).attr("disabled", "disabled");
                        $("#txt_r2_" + i).attr("disabled", "disabled");
                        $("#txt_p3_" + i).attr("disabled", "disabled");
                        $("#txt_r3_" + i).attr("disabled", "disabled");
                        $("#txt_p4_" + i).attr("disabled", "disabled");
                        $("#txt_r4_" + i).attr("disabled", "disabled");
                        $("#txt_p5_" + i).attr("disabled", "disabled");
                        $("#txt_r5_" + i).attr("disabled", "disabled");
                        $("#txt_p6_" + i).attr("disabled", "disabled");
                        $("#txt_r6_" + i).attr("disabled", "disabled");
                        $("#txt_p7_" + i).attr("disabled", "disabled");
                        $("#txt_r7_" + i).attr("disabled", "disabled");
                        $("#txt_p8_" + i).attr("disabled", "disabled");
                        $("#txt_r8_" + i).attr("disabled", "disabled");
                        $("#txt_p9_" + i).attr("disabled", "disabled");
                        $("#txt_r9_" + i).attr("disabled", "disabled");
                        $("#txt_p10_" + i).attr("disabled", "disabled");
                        $("#txt_r10_" + i).attr("disabled", "disabled");
                        $("#txt_p11_" + i).attr("disabled", "disabled");
                        $("#txt_r11_" + i).attr("disabled", "disabled");
                        $("#txt_p12_" + i).attr("disabled", "disabled");
                        $("#txt_r12_" + i).attr("disabled", "disabled");
                        $("#txt_raw_" + i).attr("disabled", "disabled");
                        $("#txt_ass_" + i).attr("disabled", "disabled");
                        $("#txt_plp_" + i).attr("disabled", "disabled");
                        $("#txt_plr_" + i).attr("disabled", "disabled");
                        $("#txt_rusult_" + i).attr("disabled", "disabled");
                    }

                })
            }
            else {
                //alert("마지막")
                var total = $(".tr").length;
                $(".tr").each(function (i, item) {
                    // 맨 마지막은 합계이므료 저장 안한다 
                    if (i != total - 1) {
                        if ($("#lbl_CusttomerName" + i).text() != "Sub Total:") {
                            $("#txt_p1_" + i).removeAttr("disabled");
                            $("#txt_r1_" + i).removeAttr("disabled");
                            $("#txt_p2_" + i).removeAttr("disabled");
                            $("#txt_r2_" + i).removeAttr("disabled");
                            $("#txt_p3_" + i).removeAttr("disabled");
                            $("#txt_r3_" + i).removeAttr("disabled");
                            $("#txt_p4_" + i).removeAttr("disabled");
                            $("#txt_r4_" + i).removeAttr("disabled");
                            $("#txt_p5_" + i).removeAttr("disabled");
                            $("#txt_r5_" + i).removeAttr("disabled");
                            $("#txt_p6_" + i).removeAttr("disabled");
                            $("#txt_r6_" + i).removeAttr("disabled");
                            $("#txt_p7_" + i).removeAttr("disabled");
                            $("#txt_r7_" + i).removeAttr("disabled");
                            $("#txt_p8_" + i).removeAttr("disabled");
                            $("#txt_r8_" + i).removeAttr("disabled");
                            $("#txt_p9_" + i).removeAttr("disabled");
                            $("#txt_r9_" + i).removeAttr("disabled");
                            $("#txt_p10_" + i).removeAttr("disabled");
                            $("#txt_r10_" + i).removeAttr("disabled");
                            $("#txt_p11_" + i).removeAttr("disabled");
                            $("#txt_r11_" + i).removeAttr("disabled");
                            $("#txt_p12_" + i).removeAttr("disabled");
                            $("#txt_r12_" + i).removeAttr("disabled");
                            $("#txt_raw_" + i).removeAttr("disabled");
                            $("#txt_ass_" + i).removeAttr("disabled");
                            $("#txt_plp_" + i).removeAttr("disabled");
                            $("#txt_plr_" + i).removeAttr("disabled");
                            $("#txt_rusult_" + i).removeAttr("disabled");
                        }
                    }

                })
            }
        }



        // 파일 삭제 
        function DelFile() {
            var params = {
                path: $("#hid_filename").val()

            }
            // alert(params.P1)
            // return;
            //ajax 
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/ashx/DelFileHandler.ashx", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false, // 동기로 처리 
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    // alert("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    console.log("삭제 도중 실패!" + XMLHttpRequest.responseText)
                    //alert("저장 도중 실패!" + XMLHttpRequest.responseText)
                }
            });
        }




        function isNull(str) {
            if (isNaN(str)) {
                str = 0;
            }
            else
                return Number(str);
        }


        /// 헤더 설정 
        function SetHeader() {
            $("#tab").empty();
            var str = "";
            str += "<thead>";
            str += "<tr>";
            str += "<th style='height: 30px; width:65px;' rowspan='2'>담당코드</th>";
            str += "<th style='height: 30px;width:75px;' rowspan='2'>담당자</th>";
            str += "<th style='width:53px;' rowspan='2'>거래선</th>";
            str += "<th style='width:71px;' rowspan='2'>거래선명</th>";
            str += "<th colspan='2'>1월</th>";
            str += "<th colspan='2'>2월</th>";
            str += "<th colspan='2'>3월</th>";
            str += "<th colspan='2'>1/4 분기</th>";
            str += "<th colspan='2'>4월</th>";
            str += "<th colspan='2'>5월</th>";
            str += "<th colspan='2'>6월</th>";
            str += "<th colspan='2'>2/4 분기</th>";
            str += "<th colspan='2'>상반기</th>";
            str += "<th colspan='2'>7월</th>";
            str += "<th colspan='2'>8월</th>";
            str += "<th colspan='2'>9월</th>";
            str += "<th colspan='2'>3/4 분기</th>";
            str += "<th colspan='2'>10월</th>";
            str += "<th colspan='2'>11월</th>";
            str += "<th colspan='2'>12월</th>";
            str += "<th colspan='2'>4/4 분기</th>";
            str += "<th colspan='2'>하반기</th>";
            str += "<th colspan='2'>연간</th>";
            str += "<th style='width:71px;' rowspan='2'>재료비</th>";
            str += "<th style='width:71px;' rowspan='2'>조립비</th>";
            str += "<th colspan='2'>영업이익</th>";
            str += "<th style='width:71px;' rowspan='2'>매출 달성율</th>";
            str += "</tr>";
            str += "<tr>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "<th >계획</th>";
            str += "<th >실적</th>";
            str += "</tr>";
            str += "</thead>";
            $("#tab").append(str);


        }


        function List() {
            SetHeader();
            //ajax 
            var params = {
                YYYY: $("#<%=ddl_Year.ClientID%>").val(),
                //hid_servion
                Servion: $("#<%=hid_servion.ClientID%>").val()
            }
            ///
            //  alert(params.Servion)


            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/ManagementWebService.asmx/sp_ManagementSub_Sel", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false, // 동기로 처리 
                dataType: "text",
                data: params, // Json 형식의 데이터이다.
                beforeSend: function (xhr) {
                    $('#load').show();
                },
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    var str = "";
                    var data = res.split("[")[1]//.split("[")[0];
                    data = data.split("]")[0]
                    data = "[" + data + "]"
                    // console.log(data)
                    data = JSON.parse(data);

                    // alert(Object.keys(data).length)
                    if (Object.keys(data).length == 0) {
                        str += "<tr><td colspan='47' class='center'>검색된 데이터가 없습니다</td></tr>";
                        $("#tab").append(str);
                    }

                    // json ArryList 바인딩
                    $.each(data, function (i, v) {
                        str = "<tr id='tr" + i + "' class='tr'>";
                        // 아이디 
                        if (v.UserId != "ZZZ") {
                            if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                                str += "<td><label id='lbl_UserId" + i + "'>" + v.UserId + "</label>"
                            }
                            else {
                                str += "<td><label id='lbl_UserId" + i + "'></label>"
                            }
                        }
                        else {
                            str += "<td><label id='lbl_UserId" + i + "'></label>"
                        }
                        // 히든
                        str += "<input type='hidden' id='hid_Num" + i + "' value='" + v.Num + "' />";
                        str += "<input type='hidden' id='hid_Idx" + i + "' value='" + v.Idx + "' />";

                        str += "</td>";
                        // 이름
                        if (v.UserName != "ZZZ") {
                            str += "<td><label id='lbl_UserName" + i + "'>" + v.UserName + "</label> </td>"
                        }
                        else {
                            str += "<td><label id='lbl_UserName" + i + "'></label> </td>"
                        }

                        //거래선 코드 CusttomerCode
                        str += "<td><label id='lbl_CusttomerCode" + i + "'>" + v.CusttomerCode + "</label> </td>"

                        //거래선 명 CusttomerName

                        str += "<td><label id='lbl_CusttomerName" + i + "'>" + v.CusttomerName + "</label> </td>"

                        //1월 계획,실적 
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {

                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "'  maxlength='6' data-class='p1" + v.UserId + "'  data-idx='" + i + "' class='right p1 p1" + v.UserId + "' type='text' id='txt_p1_" + i + "' value='" + addComma(isNull(v.p1)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "'  maxlength='6' data-class='r1" + v.UserId + "' data-idx='" + i + "' class='right r1 r1" + v.UserId + "' type='text' id='txt_r1_" + i + "' value='" + addComma(isNull(v.r1)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p1" + v.UserId + "'  data-idx='" + i + "' class='right p1 p1" + v.UserId + "' type='text' id='txt_p1_" + i + "' value='" + addComma(isNull(v.p1)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r1" + v.UserId + "' data-idx='" + i + "' class='right r1 r1" + v.UserId + "' type='text' id='txt_r1_" + i + "' value='" + addComma(isNull(v.r1)) + "' /></td>";
                        }
                        //2월 계획,실적 
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {

                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "'  maxlength='6' data-class='p2" + v.UserId + "' data-idx='" + i + "' class='right p2 p2" + v.UserId + "' type='text' id='txt_p2_" + i + "' value='" + addComma(isNull(v.p2)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "'  maxlength='6' data-class='r2" + v.UserId + "' data-idx='" + i + "' class='right r2 r2" + v.UserId + "' type='text' id='txt_r2_" + i + "' value='" + addComma(isNull(v.r2)) + "' /></td>";
                        }
                        else {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' disabled='disabled' numberOnly  maxlength='6' data-class='p2" + v.UserId + "' data-idx='" + i + "' class='right p2 p2" + v.UserId + "' type='text' id='txt_p2_" + i + "' value='" + addComma(isNull(v.p2)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' disabled='disabled' numberOnly  maxlength='6' data-class='r2" + v.UserId + "' data-idx='" + i + "' class='right r2 r2" + v.UserId + "' type='text' id='txt_r2_" + i + "' value='" + addComma(isNull(v.r2)) + "' /></td>";
                        }


                        //3월 계획,실적 
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p3" + v.UserId + "' data-idx='" + i + "' class='right p3 p3" + v.UserId + "' type='text' id='txt_p3_" + i + "' value='" + addComma(isNull(v.p3)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r3" + v.UserId + "' data-idx='" + i + "' class='right r3 r3" + v.UserId + "' type='text' id='txt_r3_" + i + "' value='" + addComma(isNull(v.r3)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p3" + v.UserId + "' data-idx='" + i + "' class='right p3 p3" + v.UserId + "' type='text' id='txt_p3_" + i + "' value='" + addComma(isNull(v.p3)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r3" + v.UserId + "' data-idx='" + i + "' class='right r3 r3" + v.UserId + "' type='text' id='txt_r3_" + i + "' value='" + addComma(isNull(v.r3)) + "' /></td>";
                        }
                        // 1/4월 분기 계획 실적 

                        str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='q1p" + v.UserId + "' data-idx='" + i + "' class='right q1p q1p" + v.UserId + "' type='text' id='txt_q1p_" + i + "' value='" + addComma(isNull(v.q1p)) + "' /></td>";
                        str += "<td><input disabled='disabled' numberOnly data-class='q1r" + v.UserId + "' data-idx='" + i + "' class='right q1r q1r" + v.UserId + "' type='text' id='txt_q1r_" + i + "' value='" + addComma(isNull(v.q1r)) + "' /></td>";

                        //4월 계획,실적 
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p4" + v.UserId + "' data-idx='" + i + "' class='right p4 p4" + v.UserId + "' type='text' id='txt_p4_" + i + "' value='" + addComma(isNull(v.p4)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r4" + v.UserId + "' data-idx='" + i + "' class='right r4 r4" + v.UserId + "' type='text' id='txt_r4_" + i + "' value='" + addComma(isNull(v.r4)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p4" + v.UserId + "' data-idx='" + i + "' class='right p4 p4" + v.UserId + "' type='text' id='txt_p4_" + i + "' value='" + addComma(isNull(v.p4)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r4" + v.UserId + "' data-idx='" + i + "' class='right r4 r4" + v.UserId + "' type='text' id='txt_r4_" + i + "' value='" + addComma(isNull(v.r4)) + "' /></td>";
                        }
                        //5월 계획,실적 
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p5" + v.UserId + "' data-idx='" + i + "' data-idx='" + i + "' class='right p5 p5" + v.UserId + "' type='text' id='txt_p5_" + i + "' value='" + addComma(isNull(v.p5)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r5" + v.UserId + "' data-idx='" + i + "' data-idx='" + i + "' class='right r5 r5" + v.UserId + "' type='text' id='txt_r5_" + i + "' value='" + addComma(isNull(v.r5)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p5" + v.UserId + "' data-idx='" + i + "' data-idx='" + i + "' class='right p5 p5" + v.UserId + "' type='text' id='txt_p5_" + i + "' value='" + addComma(isNull(v.p5)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r5" + v.UserId + "' data-idx='" + i + "' data-idx='" + i + "' class='right r5 r5" + v.UserId + "' type='text' id='txt_r5_" + i + "' value='" + addComma(isNull(v.r5)) + "' /></td>";
                        }
                        //6월 계획,실적 
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p6" + v.UserId + "' data-idx='" + i + "' class='right p6 p6" + v.UserId + "' type='text' id='txt_p6_" + i + "' value='" + addComma(isNull(v.p6)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r6" + v.UserId + "' data-idx='" + i + "' class='right r6 r6" + v.UserId + "' type='text' id='txt_r6_" + i + "' value='" + addComma(isNull(v.r6)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p6" + v.UserId + "' data-idx='" + i + "' class='right p6 p6" + v.UserId + "' type='text' id='txt_p6_" + i + "' value='" + addComma(isNull(v.p6)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r6" + v.UserId + "' data-idx='" + i + "' class='right r6 r6" + v.UserId + "' type='text' id='txt_r6_" + i + "' value='" + addComma(isNull(v.r6)) + "' /></td>";
                        }
                        //2/4 분기 계획 실적

                        str += "<td><input disabled='disabled' data-id='" + v.UserId + "' numberOnly  maxlength='6' data-class='q2p" + v.UserId + "' data-idx='" + i + "' class='right q2p q2p" + v.UserId + "' type='text' id='txt_q2p_" + i + "' value='" + addComma(isNull(v.q2p)) + "' /></td>";
                        str += "<td><input disabled='disabled' data-id='" + v.UserId + "' numberOnly  maxlength='6' data-class='q2r" + v.UserId + "' data-idx='" + i + "' class='right q2r q2r" + v.UserId + "' type='text' id='txt_q2r_" + i + "' value='" + addComma(isNull(v.q2r)) + "' /></td>";

                        //  상반기 계획 실적 
                        str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='s1p" + v.UserId + "' data-idx='" + i + "' class='right s1p s1p" + v.UserId + "' type='text' id='txt_s1p_" + i + "' value='" + addComma(isNull(v.s1p)) + "' /></td>";
                        str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='s1r" + v.UserId + "' data-idx='" + i + "' class='right s1r s1r" + v.UserId + "' type='text' id='txt_s1r_" + i + "' value='" + addComma(isNull(v.s1r)) + "' /></td>";
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            // 7월 계획 실적
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p7" + v.UserId + "' data-idx='" + i + "' class='right p7 p7" + v.UserId + "' type='text' id='txt_p7_" + i + "' value='" + addComma(isNull(v.p7)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r7" + v.UserId + "' data-idx='" + i + "' class='right r7 r7" + v.UserId + "' type='text' id='txt_r7_" + i + "' value='" + addComma(isNull(v.r7)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p7" + v.UserId + "' data-idx='" + i + "' class='right p7 p7" + v.UserId + "' type='text' id='txt_p7_" + i + "' value='" + addComma(isNull(v.p7)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r7" + v.UserId + "' data-idx='" + i + "' class='right r7 r7" + v.UserId + "' type='text' id='txt_r7_" + i + "' value='" + addComma(isNull(v.r7)) + "' /></td>";
                        }
                        // 8월 계획 실적
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p8" + v.UserId + "' data-idx='" + i + "' class='right p8 p8" + v.UserId + "' type='text' id='txt_p8_" + i + "' value='" + addComma(isNull(v.p8)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r8" + v.UserId + "' data-idx='" + i + "' class='right r8 r8" + v.UserId + "' type='text' id='txt_r8_" + i + "' value='" + addComma(isNull(v.r8)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p8" + v.UserId + "' data-idx='" + i + "' class='right p8 p8" + v.UserId + "' type='text' id='txt_p8_" + i + "' value='" + addComma(isNull(v.p8)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r8" + v.UserId + "' data-idx='" + i + "' class='right r8 r8" + v.UserId + "' type='text' id='txt_r8_" + i + "' value='" + addComma(isNull(v.r8)) + "' /></td>";
                        }
                        // 9월 계획 실적
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p9" + v.UserId + "' data-idx='" + i + "' class='right p9 p9" + v.UserId + "' type='text' id='txt_p9_" + i + "' value='" + addComma(isNull(v.p9)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r9" + v.UserId + "' data-idx='" + i + "' class='right r9 r9" + v.UserId + "' type='text' id='txt_r9_" + i + "' value='" + addComma(isNull(v.r9)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p9" + v.UserId + "' data-idx='" + i + "' class='right p9 p9" + v.UserId + "' type='text' id='txt_p9_" + i + "' value='" + addComma(isNull(v.p9)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r9" + v.UserId + "' data-idx='" + i + "' class='right r9 r9" + v.UserId + "' type='text' id='txt_r9_" + i + "' value='" + addComma(isNull(v.r9)) + "' /></td>";
                        }
                        // 3/4 분기 계획 실적

                        str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='q3p" + v.UserId + "' data-idx='" + i + "' class='right q3p q3p" + v.UserId + "' type='text' id='txt_q3p_" + i + "' value='" + addComma(isNull(v.q3p)) + "' /></td>";
                        str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='q3r" + v.UserId + "' data-idx='" + i + "' class='right q3r q3r" + v.UserId + "' type='text' id='txt_q3r_" + i + "' value='" + addComma(isNull(v.q3r)) + "' /></td>";
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            // 10월 계획 실적
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p10" + v.UserId + "' data-idx='" + i + "' class='right p10 p10" + v.UserId + "' type='text' id='txt_p10_" + i + "' value='" + addComma(isNull(v.p10)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r10" + v.UserId + "' data-idx='" + i + "' class='right r10 r10" + v.UserId + "' type='text' id='txt_r10_" + i + "' value='" + addComma(isNull(v.r10)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p10" + v.UserId + "' data-idx='" + i + "' class='right p10 p10" + v.UserId + "' type='text' id='txt_p10_" + i + "' value='" + addComma(isNull(v.p10)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r10" + v.UserId + "' data-idx='" + i + "' class='right r10 r10" + v.UserId + "' type='text' id='txt_r10_" + i + "' value='" + addComma(isNull(v.r10)) + "' /></td>";
                        }
                        // 11월 계획 실적
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p11" + v.UserId + "' data-idx='" + i + "' class='right p11 p11" + v.UserId + "' type='text' id='txt_p11_" + i + "' value='" + addComma(isNull(v.p11)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r11" + v.UserId + "' data-idx='" + i + "' class='right r11 r11" + v.UserId + "' type='text' id='txt_r11_" + i + "' value='" + addComma(isNull(v.r11)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p11" + v.UserId + "' data-idx='" + i + "' class='right p11 p11" + v.UserId + "' type='text' id='txt_p11_" + i + "' value='" + addComma(isNull(v.p11)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r11" + v.UserId + "' data-idx='" + i + "' class='right r11 r11" + v.UserId + "' type='text' id='txt_r11_" + i + "' value='" + addComma(isNull(v.r11)) + "' /></td>";
                        }
                        // 12월 계획 실적
                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='p12" + v.UserId + "' data-idx='" + i + "' class='right p12 p12" + v.UserId + "' type='text' id='txt_p12_" + i + "' value='" + addComma(isNull(v.p12)) + "' /></td>";
                            str += "<td><input onkeypress='if(event.keyCode == 13) {return false;}' numberOnly data-id='" + v.UserId + "' maxlength='6' data-class='r12" + v.UserId + "' data-idx='" + i + "' class='right r12 r12" + v.UserId + "' type='text' id='txt_r12_" + i + "' value='" + addComma(isNull(v.r12)) + "' /></td>";
                        }
                        else {
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='p12" + v.UserId + "' data-idx='" + i + "' class='right p12 p12" + v.UserId + "' type='text' id='txt_p12_" + i + "' value='" + addComma(isNull(v.p12)) + "' /></td>";
                            str += "<td><input disabled='disabled' numberOnly  maxlength='6' data-class='r12" + v.UserId + "' data-idx='" + i + "' class='right r12 r12" + v.UserId + "' type='text' id='txt_r12_" + i + "' value='" + addComma(isNull(v.r12)) + "' /></td>";
                        }
                        //4/4 분기  계획 실적
                        str += "<td><input  disabled='disabled'  maxlength='6' numberOnly data-class='q4p" + v.UserId + "' data-idx='" + i + "' class='right q4p q4p" + v.UserId + "' type='text' id='txt_q4p_" + i + "' value='" + addComma(isNull(v.q4p)) + "' /></td>";
                        str += "<td><input  disabled='disabled' maxlength='6' numberOnly data-class='q4r" + v.UserId + "' data-idx='" + i + "'  class='right q4r q4r" + v.UserId + "' type='text' id='txt_q4r_" + i + "' value='" + addComma(isNull(v.q4r)) + "' /></td>";

                        // 하반기 계획 실적
                        str += "<td><input  disabled='disabled' maxlength='6' numberOnly data-class='s2p" + v.UserId + "' data-idx='" + i + "' class='right s2p s2p" + v.UserId + "' type='text' id='txt_s2p_" + i + "' value='" + addComma(isNull(v.s2p)) + "' /></td>";
                        str += "<td><input  disabled='disabled' maxlength='6' numberOnly data-class='s2r" + v.UserId + "' class='right s2r s2r" + v.UserId + "' type='text' id='txt_s2r_" + i + "' value='" + addComma(isNull(v.s2r)) + "' /></td>";

                        // 연간 계획 실적
                        str += "<td><input disabled='disabled' maxlength='6' numberOnly data-class='yp" + v.UserId + "' data-idx='" + i + "' class='right yp yp" + v.UserId + "' type='text' id='txt_yp_" + i + "' value='" + addComma(isNull(v.yp)) + "' /></td>";
                        str += "<td><input disabled='disabled' maxlength='6' numberOnly data-class='yr" + v.UserId + "' data-idx='" + i + "' class='right yr yr" + v.UserId + "' type='text' id='txt_yr_" + i + "' value='" + addComma(isNull(v.yr)) + "' /></td>";

                        if (v.CusttomerName != "Sub Total:" && v.CusttomerName != "Total:") {
                            // 재료비 
                            str += "<td><input  onkeypress='if(event.keyCode == 13) {return false;}' maxlength='6' data-id='" + v.UserId + "' numberOnly data-class='raw" + v.UserId + "' data-idx='" + i + "' class='right raw raw" + v.UserId + "' type='text' id='txt_raw_" + i + "' value='" + addComma(isNull(v.raw)) + "' />%</td>";
                            // 조립비
                            str += "<td><input  onkeypress='if(event.keyCode == 13) {return false;}' maxlength='6' data-id='" + v.UserId + "' numberOnly data-class='ass" + v.UserId + "' data-idx='" + i + "' class='right ass ass" + v.UserId + "' type='text' id='txt_ass_" + i + "' value='" + addComma(isNull(v.ass)) + "' />%</td>";
                        }
                        else {
                            // 재료비 
                            str += "<td><input readyonly='readyonly' disabled='disabled'  maxlength='6' numberOnly data-class='raw" + v.UserId + "' data-idx='" + i + "' class='right raw raw" + v.UserId + "' type='text' id='txt_raw_" + i + "' value='" + addComma(isNull(v.raw)) + "' />%</td>";
                            // 조립비
                            str += "<td><input readyonly='readyonly' disabled='disabled'  maxlength='6' numberOnly data-class='ass" + v.UserId + "' data-idx='" + i + "' class='right ass ass" + v.UserId + "' type='text' id='txt_ass_" + i + "' value='" + addComma(isNull(v.ass)) + "' />%</td>";
                        }
                        //영업 이익 계획 실적
                        str += "<td><input disabled='disabled' maxlength='6' numberOnly data-class='plp" + v.UserId + "' data-idx='" + i + "' class='right plp plp" + v.UserId + "' type='text' id='txt_plp_" + i + "' value='" + addComma(isNull(v.plp)) + "' /></td>";
                        str += "<td><input disabled='disabled' maxlength='6' numberOnly data-class='plr" + v.UserId + "' data-idx='" + i + "' class='right plr plr" + v.UserId + "' type='text' id='txt_plr_" + i + "' value='" + addComma(isNull(v.plr)) + "' /></td>";
                        if (v.CusttomerName == "Sub Total:") {
                            // 매출  달성율
                            str += "<td><input disabled='disabled'  maxlength='6' numberOnly data-idx='" + i + "' class='right rusult rusult" + v.UserId + "' type='text' id='txt_result_" + i + "' value='" + addComma(isNull(v.rusult)) + "' />%</td>";
                        }
                        else {
                            str += "<td><input disabled='disabled'  maxlength='6' numberOnly data-idx='" + i + "' class='right rusult rusult" + v.UserId + "' type='text' id='txt_result_" + i + "' value='' /></td>";
                        }
                        str += "</tr>";

                        $("#tab").append(str);

                        // console.log(v)
                    })
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("데이터 로드 도중 실패:" + XMLHttpRequest.responseText);
                }
            });
            //ajax 
        }



        // ajax으로 파일 첨부된 내용을 jsonArryList으로 받아 온다 
        function GetExcelList() {
            var params = {
                filename: $("#hid_filename").val()
            }
            ///
            var rowcnt = 0;
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/ExcelWebService.asmx/GetExcelData", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false, // 동기로 처리 
                dataType: "text",
                beforeSend: function (xhr) {
                    $('#load').show();
                },
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.

                    //버젼  마지막에 추가 로직 추가 
                    $('#sel_Servion option:last').prop('selected', true);
                    $("#<%=hid_servion.ClientID%>").val($('#sel_Servion option:last').val());




                    var data = res.split("[")[1]//.split("[")[0];
                    data = data.split("]")[0]
                    data = "[" + data + "]"
                    // console.log(data)
                    data = JSON.parse(data);
                    //alert(data)
                    $.each(data, function (i, v) {
                        rowcnt += 1;
                        console.log(v);
                        $("#lbl_UserId" + i).text(v.UserId);
                        $("#lbl_UserName" + i).text(v.UserName);
                        $("#lbl_CusttomerCode" + i).text(v.CusttomerCode);
                        $("#lbl_CusttomerName" + i).text(v.CusttomerName);
                        $("#txt_p1_" + i).val(v.p1);
                        $("#txt_r1_" + i).val(v.r1);
                        $("#txt_p2_" + i).val(v.p2);
                        $("#txt_r2_" + i).val(v.r2);
                        $("#txt_p3_" + i).val(v.p3);
                        $("#txt_r3_" + i).val(v.r3);
                        $("#txt_q1p_" + i).val(v.q1p);
                        $("#xt_q1r_" + i).val(v.q1r);
                        $("#txt_p4_" + i).val(v.p4);
                        $("#txt_r4_" + i).val(v.r4);
                        $("#txt_p5_" + i).val(v.p5);
                        $("#txt_r5_" + i).val(v.r5);
                        $("#txt_p6_" + i).val(v.p6);
                        $("#txt_r6_" + i).val(v.r6);
                        $("#txt_q2p_" + i).val(v.q2p);
                        $("#txt_q2r_" + i).val(v.q2r);
                        $("#txt_s1p_" + i).val(v.s1p);
                        $("txt_s1r_" + i).val(v.s1r);
                        $("#txt_p7_" + i).val(v.p7);
                        $("#txt_r7_" + i).val(v.r7);
                        $("#txt_p8_" + i).val(v.p8);
                        $("#txt_r8_" + i).val(v.r8);
                        $("#txt_p9_" + i).val(v.p9);
                        $("#txt_r9_" + i).val(v.r9);
                        $("#txt_q3p_" + i).val(v.q3p);
                        $("#txt_q3r_" + i).val(v.q3r);
                        $("#txt_p10_" + i).val(v.p10);
                        $("#txt_r10_" + i).val(v.r10);
                        $("#txt_p11_" + i).val(v.p11);
                        $("#txt_r11_" + i).val(v.r11);
                        $("#txt_p12_" + i).val(v.p12);
                        $("#txt_r12_" + i).val(v.r12);
                        $("#txt_q4p_" + i).val(v.q4p);
                        $("#txt_q4r_" + i).val(v.q4r);
                        $("#txt_s2p_" + i).val(v.s2p);
                        $("#txt_s2r_" + i).val(v.s2r);
                        $("#txt_yp_" + i).val(v.yp);
                        $("#txt_yr_" + i).val(v.yr);
                        $("#txt_raw_" + i).val(v.raw);
                        $("#txt_ass_" + i).val(v.ass);
                        $("#txt_plp_" + i).val(v.plp);
                        $("#txt_plr_" + i).val(v.plr);
                        $("#txt_rusult_" + i).val(v.rusult);
                    });
                    // 기존 tbody에 붙이면 버그가 있어 일일이 넣어줌
                    DelFile(); // 파일 삭제 
                    var total = $(".tr").length;
                    $("#<%=hid_servion.ClientID%>").val(Number($("#<%=hid_servion.ClientID%>").val()) + 1);

                    $(".tr").each(function (i, item) {
                        // 맨 마지막은 합계이므료 저장 안한다 
                        if (i != total - 1) {
                            if ($("#lbl_CusttomerName" + i).text() != "Sub Total:" && $("#lbl_CusttomerName" + i).text() != "Total:") {
                                Save(i, $("#<%=hid_servion.ClientID%>"));
                            }

                        }

                    })

                    if (rowidx > 0) {
                        alert("저장 되었습니다");
                        List();
                        getServion();
                        AuthServionCkeck();
                    }



                //alert($("#<%=hid_servion.ClientID%>").val())
                    $("#sel_Servion").val($("#<%=hid_servion.ClientID%>").val());


                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("데이터 로드 도중 실패:" + XMLHttpRequest.responseText);
                }
            });
        }




        //천단위마다 콤마 생성
        function addComma(data) {
            return data.toString().replaceAll(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        /// 천단위마다 콤마 제거 
        function removeCommas(data) {
            if (!data || data.length == 0) {
                return "";
            } else {
                return x.split(",").join("");
            }
        }

        /// 버젼을 바인딩
        function getServion() {
            var params = {
                YYYY: $("#<%=ddl_Year.ClientID%>").val()
            }
            ///
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/ManagementWebService.asmx/sp_ManagementSub_GetVersion", // 컨트롤러에서 대기중인 URL 주소이다.
                async: false, // 동기로 처리 
                dataType: "text",
                beforeSend: function (xhr) {
                    $('#load').show();
                },
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    var data = res.split("[")[1]//.split("[")[0];
                    data = data.split("]")[0]
                    data = "[" + data + "]"
                    // console.log(data)
                    data = JSON.parse(data);
                    //alert(data)
                    // 기존 tbody에 붙이면 버그가 있어 일일이 넣어줌
                    $("#sel_Servion").empty();
                    $.each(data, function (i, v) {
                        $("#sel_Servion").append("<option value='" + v.servion + "'>Ver." + v.servion + "</option>")
                        $("#sel_Servion").val(v.servion)
                        //$("#<%=hid_servion.ClientID%>").val(v.servion);
                        //alert(v.servion)
                    })

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("데이터 로드 도중 실패:" + XMLHttpRequest.responseText);
                }
            });
        }



        $(function () {
            $('#loading').hide();
            var date = new Date();
            $("#<%=ddl_Year.ClientID%>").val((date.getFullYear()));
            //버젼 체크


            //alert($("#<%=ddl_Year.ClientID%> option:last"))

            //alert("")
            getServion();


            $("#sel_Servion option:last").prop("selected", true);
            $("#<%=hid_servion.ClientID%>").val($("#sel_Servion").val());
            List();
            AuthServionCkeck();

            $(document).on("click", "#btn_save", function (e) {
                e.preventDefault();


                var total = $(".tr").length;
                $(".tr").each(function (i, item) {
                    // 맨 마지막은 합계이므료 저장 안한다 
                    if (i != total - 1) {
                        if ($("#lbl_CusttomerName" + i).text() != "Sub Total:" && $("#lbl_CusttomerName" + i).text() != "Total:") {
                            Save(i, $("#sel_Servion"));
                        }

                    }

                })

                if (rowidx > 0) {
                  //  alert()
                    alert("저장 되었습니다")
                    List();
                    getServion();
                    AuthServionCkeck();
                    
                }

                $("#sel_Servion").val($("#<%=hid_servion.ClientID%>").val());
            })
            $(document).on("change", "#<%=ddl_Year.ClientID%>", function (e) {
                 e.preventDefault();
                getServion();
                List();
                AuthServionCkeck();

                //console.log(e);
            })

            $(document).on("change", "#sel_Servion", function (e) {
                 e.preventDefault();
                $("#<%=hid_servion.ClientID%>").val($(this).val());

                // alert($("#sel_Servion option").length);
                var size = $("#sel_Servion option").length;
                var index = $('#sel_Servion option').index($('#sel_Servion option:selected')) + 1;
                var bol = false;
                List();
                //  $("input:text").removeAttr("readonly");
                AuthServionCkeck();

            })


            $(document).on("propertychange change keyup paste input", "input:text[numberOnly]", function (e) {
                 e.preventDefault();
                var idx = $(this).data("idx");
                var p1 = isNull($("#txt_p1_" + idx).val().replaceAll(",", ""));
                var p2 = isNull($("#txt_p2_" + idx).val().replaceAll(",", ""));
                var p3 = isNull($("#txt_p3_" + idx).val().replaceAll(",", ""));
                $("#txt_q1p_" + idx).val(addComma(p1 + p2 + p3));
                var r1 = isNull($("#txt_r1_" + idx).val().replaceAll(",", ""));
                var r2 = isNull($("#txt_r2_" + idx).val().replaceAll(",", ""));
                var r3 = isNull($("#txt_r3_" + idx).val().replaceAll(",", ""));
                $("#txt_q1r_" + idx).val(addComma(r1 + r2 + r3));
                var p4 = isNull($("#txt_p4_" + idx).val().replaceAll(",", ""));
                var p5 = isNull($("#txt_p5_" + idx).val().replaceAll(",", ""));
                var p6 = isNull($("#txt_p6_" + idx).val().replaceAll(",", ""));
                $("#txt_q2p_" + idx).val(addComma(p4 + p5 + p6));

                var r4 = isNull($("#txt_r4_" + idx).val().replaceAll(",", ""));
                var r5 = isNull($("#txt_r5_" + idx).val().replaceAll(",", ""));
                var r6 = isNull($("#txt_r6_" + idx).val().replaceAll(",", ""));
                $("#txt_q2r_" + idx).val(addComma(r4 + r5 + r6));
                //상반기 
                $("#txt_s1p_" + idx).val(addComma(p1 + p2 + p3 + p4 + p5 + p6));
                $("#txt_s1r_" + idx).val(addComma(r1 + r2 + r3 + r4 + r5 + r6));

                var p7 = isNull($("#txt_p7_" + idx).val().replaceAll(",", ""));
                var p8 = isNull($("#txt_p8_" + idx).val().replaceAll(",", ""));
                var p9 = isNull($("#txt_p9_" + idx).val().replaceAll(",", ""));
                $("#txt_q3p_" + idx).val(addComma(p7 + p8 + p9));

                var r7 = isNull($("#txt_r7_" + idx).val().replaceAll(",", ""));
                var r8 = isNull($("#txt_r8_" + idx).val().replaceAll(",", ""));
                var r9 = isNull($("#txt_r9_" + idx).val().replaceAll(",", ""));
                $("#txt_q3r_" + idx).val(addComma(r7 + r8 + r9));

                var p10 = isNull($("#txt_p10_" + idx).val().replaceAll(",", ""));
                var p11 = isNull($("#txt_p11_" + idx).val().replaceAll(",", ""));
                var p12 = isNull($("#txt_p12_" + idx).val().replaceAll(",", ""));
                $("#txt_q4p_" + idx).val(addComma(p10 + p11 + p12));

                var r10 = isNull($("#txt_r10_" + idx).val().replaceAll(",", ""));
                var r11 = isNull($("#txt_r11_" + idx).val().replaceAll(",", ""));
                var r12 = isNull($("#txt_r12_" + idx).val().replaceAll(",", ""));
                $("#txt_q4r_" + idx).val(addComma(r10 + r11 + r12));

                // 하반기 
                $("#txt_s2p_" + idx).val(addComma(p7 + p8 + p9 + p10 + p11 + p12));
                $("#txt_s2r_" + idx).val(addComma(r7 + r8 + r9 + r10 + r11 + r12));

                // 년간 
                $("#txt_yp_" + idx).val(addComma(p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 + p10 + p11 + p12));
                $("#txt_yr_" + idx).val(addComma(r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12));


                var myclass = $(this).data("class");

                // AllCount();  //마지막 모든컬럼 합계
                FindRowSet($('.' + myclass).first().data("idx"), $('.' + myclass).last().data("idx"));
                //FindRowSet($(this).data("idx"), $('.' + myclass).last().data("idx"));
                AllCount();  //마지막 모든컬럼 합계
            })
       


            $(document).on("propertychange change keyup paste input", "input:text[numberOnly]", function (e) {
                e.preventDefault();

                $(this).val(function (index, value) {
                    return value
                        .replace(/\D/g, "")
                        .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                        ;
                });
                //$(this).val($(this).val().replaceAll(/[^0-9]/g, ""));
                $(this).val(addComma($(this).val()));

               



                
              
               //// alert(myclass)
                
               // var plpid = "plp" + $(this).data("id");
               // var plrid = "plr" + $(this).data("id");

               // //alert(id)
               // var plptotal = $("." + plpid).length;
               // var sumplp = 0;
               // $('.' + plpid).each(function (index, val) {
               //     if (index != plptotal - 1) {
               //         if ($("#lbl_CusttomerName" + index).text() != "Sub Total:") {
               //             // alert(Number($(this).val().replaceAll(",", "")))
               //             sumplp += Number($(this).val().replaceAll(",", ""));
               //         }
               //     }
               // });
               // //alert("총건수:"+sumplp)
               // $("." + plpid).last().val(addComma(sumplp));

               // var plrtotal = $("." + plrid).length;
               // var sumplr = 0;
               // $('.' + plrid).each(function (index, val) {
               //     if (index != plrtotal - 1) {
               //         if ($("#lbl_CusttomerName" + index).text() != "Sub Total:") {
               //             // alert(Number($(this).val().replaceAll(",", "")))
               //             sumplr += Number($(this).val().replaceAll(",", ""));
               //         }
               //     }
               // });
               // //alert("총건수:"+sumplp)
               // $("." + plrid).last().val(addComma(sumplr));

                
            });







            //$(document).on("keydown", "input:text[numberOnly]", function (e) {
              





            //});


            $(document).on("click", "#btn_upload", function (e) {
                e.preventDefault();

                var ext = $("input[name='file_upload']").val().toLowerCase().split('.');
                ext = ext[ext.length - 1];
                //alert(ext)
                if ($.inArray(ext, ['xls', 'xlsx']) == -1) {
                    alert('엑셀 파일만 업로드 할수 있습니다.');
                    return false;
                }


                var formData = new FormData();
                var inputFile = $("input[name='file_upload']");
                var files = inputFile[0].files;

                formData.append("file_upload", files[0]);
                //alert($('#file_upload')[0].files[0])

                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "/ashx/UploadHandler.ashx", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false,
                    processData: false,
                    contentType: false,
                    data: formData, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        $("#hid_filename").val(res);
                        GetExcelList();
                        $("#file_upload").val("");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert("파일첨부중 에러:" + XMLHttpRequest.responseText);
                    }
                });
            });

            $(document).on("click", "#btn_Addco", function (e) {
                e.preventDefault();
                PopupCenter('AddCo?dbname=' + $("#<%=hid_DBNAME.ClientID%>").val(), '경영 거래선 등록', 600, 400);
            })

            $(document).on("click", "#btn_Excel", function (e) {
                e.preventDefault();
                ///alert("")
                //ajax 
                var params = {
                    YYYY: $("#<%=ddl_Year.ClientID%>").val(),
                    Servion: $("#sel_Servion").val()
                }
                ///
                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "Management", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false,
                    xhrFields: {
                        responseType: "blob",
                    },
                    data: params, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        //  alert("res");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert("데이터 로드 도중 실패:" + XMLHttpRequest.responseText);
                    }
                });
                //ajax

            })


            $(document).ajaxStart(function () {
                //alert()
                // 로딩 바 이미지를 띄우고
                // $('#loading').show();
                // ajax 통신이 종료되었을 때 실행될 이벤트
            }).ajaxStop(function () {
                // 로딩 바 태그와 이미지를 모두 hide 처리
                $('#loading').hide();
            });

        });//document
    </script>
</asp:Content>
