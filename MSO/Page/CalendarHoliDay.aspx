<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CalendarHoliDay.aspx.cs" Inherits="MSO.Page.CalendarHoliDay" EnableSessionState="ReadOnly" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- jquery CDN -->
    
    <script src="/Scripts/bootstrap.js"></script>

    <!-- fullcalendar CDN -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
    <!-- fullcalendar 언어 CDN -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>


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

        #calendar {
            max-width: 800px;
            min-height: 300px;
            margin: 0 auto;
        }

        /*요일*/
        .fc-col-header-cell-cushion {
            /*color: #000;*/
        }

            .fc-col-header-cell-cushion:hover {
                /*text-decoration: none;
	color:#000;*/
            }
        /*일자*/
        .fc-daygrid-day-number {
            /*color: #000;
	font-size:1em;*/
        }

        /*종일제목*/
        .fc-event-title.fc-sticky {
        }
        /*more버튼*/
        .fc-daygrid-more-link.fc-more-link {
            color: #000;
        }
        /*일정시간*/
        .fc-daygrid-event > .fc-event-time {
            color: #000;
        }
        /*시간제목*/
        .fc-daygrid-dot-event > .fc-event-title {
            color: #000 !important;
        }
        /*가로 줄 - 월달력 종일 or 복수일자*/
        .fc-h-event {
        }
        /*세로 줄 - 주달력, 일달력*/
        .fc-v-event {
        }
        /*title 옆에 점*/
        .fc-daygrid-event-dot {
        }
        /*month/week/day*/
        .fc-button-active {
            visibility: hidden;
            /*border-color: #ffc107 		!important;
	background-color: #ffc107 	!important;
	color: #000 				!important;
	font-weight: bold 			!important;*/
        }

        /*주말 */
        /* 일요일 */
        .fc-day-sun .fc-daygrid-day-number {
            color: red;
        }
        /* 토요일 */
        .fc-day-sat .fc-daygrid-day-number {
            color: red;
        }

        body {
            font-size: 12px;
            /*font-size:9px;*/
        }

        .title {
            font-weight: bold;
        }
    </style>
    <asp:HiddenField ID="hid_DBNAME" runat="server" />
    <div class="title">
        공휴일 관리
    </div>

    <!--캘린더 영역-->
    <div id='calendar'></div>

    <!-- 모달 창 -->
    <div class="modal fade modal" id="modal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div style="width: 360px;" class="modal-content">
                <div class="modal-header">
                    <label id="lbl_title">공휴일 관리</label>
                    <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="panel-body">

                        <table width="100%" border="0">
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">휴무여부</label></td>
                                <td>

                                    <input id="cb_YN" type="checkbox" />
                                </td>

                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">제목</label></td>
                                <td>
                                    <input id="txt_Title" type="text" style="width: 220px;" placeholder="제목" /></td>

                            </tr>
                            <tr style="height: 45px;">
                                <td>
                                    <label class="control-form" style="width: 50px;">날자</label>
                                </td>
                                <td>
                                    <input id="txt_HoliDay" type="date" style="width: 220px;" placeholder="날자" disabled="disabled" /></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">

                    <button id="del" type="button" class="btn-primary" style="visibility: hidden">삭제</button>
                    <button id="add" type="button" class="btn-primary">저장</button>
                    <button type="button" class="btn-dark" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 모달창--->

    <script type="text/javascript">
        // 초기 데이터 진입 
        function initData()
        {
            //alert("21");
            $("#txt_HoliDay").val("");
            $("#txt_Title").val("");
            $("#cb_YN").prop('checked', false);//.removeAttr("checked");
        }

   

        var isSave = false;

        // 날자로 키값으로 되어 있어 날자 수정은 불가하도록 막는다
        function insertModalOpen(date) {
            $("#del").attr("style", "inline");
          //   initData();
            $("#txt_HoliDay").val(date);
            //HoliDay
            var params = {
                HoliDay: date
            }

            //ajax 
            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/HolidayWebService.asmx/sp_Holiday_Get", // 컨트롤러에서 대기중인 URL 주소이다.
                dataType: "text",
                data: params, // Json 형식의 데이터이다.
              //  async: false,
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    var data = res.split("[")[1]//.split("[")[0];
                    data = data.split("]")[0]
                    data = "[" + data + "]"
                     console.log(data)
                    data = JSON.parse(data);
                    //alert(data)
                    $.each(data, function (i, v) {
                        alert(v)
                        $("#txt_Title").val(v.Title);
                       // alert(v.YN)
                        $("#cb_YN").prop('checked', v.YN);
                        //if (v.YN != "false") {
                        //    $("#cb_YN").attr("checked", true);
                        //}
                        //else {
                        //    $("#cb_YN").attr("checked", false);
                        //}
                        //alert(v)
                    });
                    $("#modal").modal("show"); // 
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("err" + XMLHttpRequest.responseText)
                }

            });
            //AJAX


        }

        /// 2022-04-01    +1 4월 31 
        function List(month) {
            //alert(month)
            $("#calendar").empty();

            var params = {
                Month: month
            }


            $.ajax({
                type: "POST", // HTTP method type(GET, POST) 형식이다.
                url: "/WebService/HolidayWebService.asmx/sp_Holiday_Sel", // 컨트롤러에서 대기중인 URL 주소이다.
                dataType: "text",
                async: false,
                data: params, // Json 형식의 데이터이다.
                success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                    var data = res.split("[")[1]//.split("[")[0];
                    data = data.split("]")[0]
                    data = "[" + data + "]"
                    // console.log(data)
                    data = JSON.parse(data);

                    var events = [];
                    $.each(data, function (i, v) {

                        //var bgyn = v.yn;
                        var bgcolor = "Black";
                        if (v.YN) {
                            bgcolor = "red";
                        }


                        //alert(v.start + "," + v.YN);
                       // console.log(v)
                        events.push({
                            title: v.title
                            , start: v.start
                            , id: v.YN
                            , borderColor: "white"
                            , backgroundColor: "white"
                            , Color: bgcolor
                            // overlap: true,
                            // , display: 'background'
                            , textColor: bgcolor
                            //  ,allDay: true // false시 시간으로 보여준다
                            //,Color:"red"
                        });
                    });

                    SetCalendar(month, events)
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    console.log("err" + XMLHttpRequest.responseText)
                }

            });
        }



        function SetCalendar(month, events) {
            var calendarEl = document.getElementById('calendar');
            calendar = new FullCalendar.Calendar(calendarEl, {
                customButtons: {
                    NextButton: {
                        text: 'Next',
                        click: function (e) {
                            calendar.next();
                            var date = calendar.getDate();
                            var yy = date.getFullYear();
                            var mm = date.getMonth() + 1;
                            if (mm < 10) {
                                mm = '0' + mm;
                            }

                            //alert(yy + "-" + mm)
                            //return false;
                            List(yy + "-" + mm);
                        }
                    },
                    PrevButton: {
                        text: 'Prev',
                        click: function (e) {
                            //calendar.prev()
                            var date = calendar.getDate();
                            var yy = date.getFullYear();
                            var mm = date.getMonth();
                            if (mm < 10) {
                                mm = '0' + mm;
                            }

                            //alert(yy + "-" + mm)
                            //return false;

                            List(yy + "-" + mm);
                        }
                    }

                },
                headerToolbar: {
                    left: 'PrevButton today NextButton',
                    center: 'title',
                    right: 'dayGridMonth'
                },
                locale: 'ko',
                initialDate: month + '-01',//'2022-04-07',
                navLinks: false, // can click day/week names to navigate views
                selectable: true,
                selectMirror: true,
                /// 빈 칸을 선택시
                select: function (arg) {
                    // console.log(arg)
                    // alert(arg.event)
                    insertModalOpen(arg.startStr);	//일자 클릭 시 모달 호출
                },
                eventClick: function (arg) {
                    //  console.log(arg.event.id);
                    //alert(arg.event.startStr.substring(8, 3));
                    //yy arg.event.startStr.substring(0, 4)
                    //mm 
                    var date = new Date(arg.event.startStr)
                    var yyyy = date.getFullYear();
                    var mm = (date.getMonth() + 1);
                    var dd = date.getDate();
                    //alert(dd)
                    if (mm < 10) {
                        mm = "0" + mm;
                    }
                    //alert(mm);
                    if (dd < 10) {
                        dd = "0" + dd;
                    }
                    //alert(yyyy + "-" + mm +"-"+ dd)
                    insertModalOpen(yyyy + "-" + mm + "-" + dd)//, arg.event.title,arg.event.id);	//이벤트 클릭 시 모달 호출
                },
                eventChange: function (arg) {
                    //allDay true로 바꾸면 end가 없어서 만듬
                    if (arg.event.end == null) {
                        var end = new Date();
                        end.setDate(arg.event.start.getDate() + 1);
                        arg.event.setEnd(end);
                    }
                },
                eventDrop: function (arg) {
                    insertModalOpen(arg.startStr);	//이벤트 드래그드랍 시 모달 호출
                },
                eventResize: function (arg) {
                    insertModalOpen(arg.startStr);		//이벤트 사이즈 변경시(일정변경) 모달 호출
                },
                editable: false, // 수정여부 날자로 키값으로 설정되어 날자이동은 막는다
                dayMaxEvents: true, // allow "more" link when too many events
                events: events
            });

            calendar.render();
        }
        var calendar;
       $(function () {




            var date = new Date()
            var yyyy = date.getFullYear();
            var mm = (date.getMonth() + 1);
            if (mm < 10) {
                mm = "0" + mm;
            }
            List(yyyy + '-' + mm)




            /// 저장 
            $(document).on("click", "#add", function (e) {
                e.preventDefault();
                if ($("#txt_Title").val() == "") {
                    alert("제목을 확인하여주세요");
                    $("#txt_Title").focus();
                    return false;
                }

                var params = {
                    YN: $("#cb_YN").is(":checked"),
                    Title: $("#txt_Title").val(),
                    HoliDay: $("#txt_HoliDay").val()
                }

                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "/WebService/HolidayWebService.asmx/sp_Holiday_Ins", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false, // 동기로 처리 
                    data: params, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        alert("저장 되었습니다");
                        var date = calendar.getDate();
                        var yy = date.getFullYear();
                        var mm = date.getMonth() + 1;
                        if (mm < 10) {
                            mm = '0' + mm;
                        }
                        //alert(yy + "-" + mm)
                        $("#modal").modal("hide");
                        List(yy + "-" + mm);
                        //alert(Object.keys(res).length)
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert(XMLHttpRequest.responseText)
                    }
                });

            });

            // 삭제 

            $(document).on("click", "#del", function (e) {
                e.preventDefault();
                var bol = confirm("정말로 삭제하시겠습니까?");
                if (bol == false) {
                    alert("취소 되었습니다");
                    return false;
                }

                //파라미터
                var params = {
                    HoliDay: $("#txt_HoliDay").val()
                }
                //파라미터 

                //ajax 
                $.ajax({
                    type: "POST", // HTTP method type(GET, POST) 형식이다.
                    url: "/WebService/HolidayWebService.asmx/sp_Holiday_Del", // 컨트롤러에서 대기중인 URL 주소이다.
                    async: false, // 동기로 처리 
                    data: params, // Json 형식의 데이터이다.
                    success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                        alert("삭제 되었습니다");
                        var date = calendar.getDate();
                        var yy = date.getFullYear();
                        var mm = date.getMonth() + 1;
                        if (mm < 10) {
                            mm = '0' + mm;
                        }
                        //alert(yy + "-" + mm)
                        $("#modal").modal("hide");
                        List(yy + "-" + mm);
                        //alert(Object.keys(res).length)
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                        alert(XMLHttpRequest.responseText)
                    }
                });
                //ajax
            });


            $('#modal').on('hidden.bs.modal', function (e) {
                //   e.preventDefault();
              //  alert("")
                initData();
                //   window.location.reload();
            })


        })
    </script>

</asp:Content>
