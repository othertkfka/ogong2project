<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>공부기록</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/e3409dba93.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.0/dist/chart.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">

	var today = new Date();
	var labels = [];
	var labels2 = [];
	var data = [];
	var data2 = [];
	var myChart;
	var myChart2;
	var config;
	var config2;
	
	$(function(){
		var month;
		if(((today.getMonth()+1)+"").length == 2){
			month = (today.getMonth()+1);
		}else{
			month = "0"+(today.getMonth()+1);
		}
		$("#current").html(today.getFullYear()+"-"+month);
		
		
		<c:forEach items="${lineChart}" var="learningHistory">			
			labels.push("${learningHistory.learningDate}");
			data.push(${learningHistory.learningType});
       	</c:forEach>
       	
       	<c:forEach items="${pieChart}" var="learningHistory">			
			labels2.push("${learningHistory.learningType}");
			data2.push(${learningHistory.learningTime});
	   	</c:forEach>
	   	
		var ctx = document.getElementById("myChart");
		var ctx2 = document.getElementById("myChart2");
		config = {
				type: 'line',
				data: 
				{
					labels: labels, //X축 제목
					
					datasets: [{ //실제값
						label: '공부시간(분)', 
						data: data,
						backgroundColor: [ //백그라운드 색상 지정하는 부분 
							'rgba(255, 206, 86, 0.2)'
						],
						borderColor: [
							'rgba(255, 206, 86, 1)'
						],
						borderWidth: 2 //보더의 굵기
					}]
				}
				,
				options: {
					responsive: false,  //false로 바꿔주지 않으면 설정한 값과 달리 꽉차는 반응형으로 만들어진다.
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true
							}
						}]
					},
				}
			};
		config2 = {
				type: 'pie',
				data: 
				{
					labels: labels2, //X축 제목
					
					datasets: [{ //실제값
						label: '공부시간', 
						data: data2,
						backgroundColor: [ //백그라운드 색상 지정하는 부분 
							'rgba(255, 99, 132, 0.2)',
				            'rgba(54, 162, 235, 0.2)',
				            'rgba(255, 206, 86, 0.2)',
				            'rgba(75, 192, 192, 0.2)',
				            'rgba(153, 102, 255, 0.2)',
				            'rgba(255, 159, 64, 0.2)',
						],
						borderColor: [
				            'rgba(255, 99, 132, 1)',
				            'rgba(54, 162, 235, 1)',
				            'rgba(255, 206, 86, 1)',
				            'rgba(75, 192, 192, 1)',
				            'rgba(153, 102, 255, 1)',
				            'rgba(255, 159, 64, 1)'
				        ],
				        borderWidth: 1
					}]
				}
				,
				options: {
					title: {
			            display: true,
			            text: '면적별 세대수',
			            position: 'top',
			            fontSize: 40,
			            fontColor: '#000'
			        }

				}
			};
		myChart = new Chart(ctx, config);
		myChart2 = new Chart(ctx2, config2);
	})
	
	function prevMonth() {
		today = new Date(today.getFullYear(), today.getMonth()-1);
		var month;
		if(((today.getMonth()+1)+"").length == 2){
			month = (today.getMonth()+1);
		}else{
			month = "0"+(today.getMonth()+1);
		}
		$("#current").html(today.getFullYear()+"-"+month);
		getHistoryList($("#current").html().trim());
		
		getlineChartList($("#current").html().trim());
		getPieChartList($("#current").html().trim());
	}
	
	function nextMonth() {
		today = new Date(today.getFullYear(), today.getMonth()+1);
		var month;
		if(((today.getMonth()+1)+"").length == 2){
			month = (today.getMonth()+1);
		}else{
			month = "0"+(today.getMonth()+1);
		}
		$("#current").html(today.getFullYear()+"-"+month);
		getHistoryList($("#current").html().trim());
		
		getlineChartList($("#current").html().trim());
		getPieChartList($("#current").html().trim());
	}

	function getHistoryList(month) {
		$.ajax({
			type : 'post',
			url : "/learningHistory/getLearningHistoryList",
			data : JSON.stringify({
									email: "${email}",
									learningDate: month
			}),
			dataType: "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(result) {	
				$("#table").children("tr").remove();
				$("#table").children("div").remove();
				$("#notfound").remove();
				var addListHtml ="";
				if(result.length > 0) {
					$.each(result, function(index, list){
						addListHtml += "<tr>";
	                    addListHtml += "<td>"+index+"</td>";
	                    addListHtml += "<td>"+list.learningDate+"</td>";
	                    addListHtml += "<td>"+list.learningType+"</td>";
	                    addListHtml += "<td>"+list.learningTime+"</td>";
	                    addListHtml += "</tr>";
					});
				}else{
					addListHtml += '<div class="text-center" id="notfound">'
					addListHtml += '<i class="fas fa-exclamation-triangle"></i>';
					addListHtml += ' 공부기록이 없습니다';
					addListHtml += '</div>'
				}
				$("#table").append(addListHtml);
			}
		});
	}
	
	function getlineChartList(month) {
		$.ajax({
			type : 'post',
			url : "/learningHistory/getLineChartTime",
			data : JSON.stringify({
									email: "${email}",
									learningDate: month
			}),
			dataType: "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(result) {	
				config.data.labels = [];
				config.data.datasets[0].data = [];
				
				for(var i=0; i<result.length; i++){
					config.data.labels.push(result[i].learningDate);
					config.data.datasets[0].data.push(result[i].learningType);
				}
				
		       	myChart.update();
			}
		});
	}
	
	function getPieChartList(month) {
		$.ajax({
			type : 'post',
			url : "/learningHistory/getPieChartTime",
			data : JSON.stringify({
									email: "${email}",
									learningDate: month
			}),
			dataType: "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(result) {	
				config2.data.labels = [];
				config2.data.datasets[0].data = [];
				
				for(var i=0; i<result.length; i++){
					config2.data.labels.push(result[i].learningType);
					config2.data.datasets[0].data.push(result[i].learningTime);
				}
				
		       	myChart2.update();
			}
		});
	}
	
	
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Serif+KR:wght@600&family=Sunflower:wght@300&display=swap')
	;
body, table, div, p, th, td {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}
#notfound {
	margin: 10px 0px 10px 0px;
}
a.page-link {
	color: black;
}
</style>
</head>
<body>
	<jsp:include page="../common/toolbar.jsp" />
	


<div class="wrapper">

    <div class="content-header">
      <div class="container">
      
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">공부기록</h1>
          </div>
        </div>
        
      </div>
    </div>

    <section class="content">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 col-6">
            <div class="small-box bg-white">
              <div class="inner">
              	<p>오늘 공부한 시간</p>
                <h3>${todayLearningTime}</h3>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-6">
            <div class="small-box bg-white">
              <div class="inner">
              	<p>하루 평균 공부시간</p>
                <h3>${averageLearningTime}</h3>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-6">
            <div class="small-box bg-white">
              <div class="inner">
              	<p>전체 공부시간</p>
                <h3>${totalLearningTime}</h3>
              </div>
            </div>
          </div>
        </div><br><hr><br>
        
        <div class="row">
          <section class="col-lg-7 connectedSortable">
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="fas fa-book"></i>
                  한 달의 공부기록
                </h3>

                <div class="card-tools">
                  <ul class="pagination">
                    <li class="page-item"><a class="page-link" onclick="prevMonth()"
                    						style="cursor:pointer">&laquo;</a></li>
                    <li class="page-item"><a class="page-link" id="current"></a></li>
                    <li class="page-item"><a class="page-link" onclick="nextMonth()"
                    						style="cursor:pointer">&raquo;</a></li>
                  </ul>
                </div>
              </div>
              <div class="card-body">
                <div class="card-body table-responsive p-0">
	                <table class="table table-hover text-nowrap">
	                  <thead>
	                    <tr>
	                      <th>No</th>
	                      <th>날짜</th>
	                      <th>공부종류</th>
	                      <th>공부시간</th>
	                    </tr>
	                  </thead>
	                  <tbody id="table">
	                  	<c:forEach var="learningHistory" items="${list}" varStatus="vs">
	                  		<tr>
		                      <td>${vs.count}</td>
		                      <td>${learningHistory.learningDate}</td>
		                      <td>${learningHistory.learningType}</td>
		                      <td>${learningHistory.learningTime}</td>
		                    </tr>
	                  	</c:forEach>
	                  	<c:if test="${list.size() == 0}">
	                  		<div class="text-center" id="notfound">
								<i class="fas fa-exclamation-triangle"></i>
								공부기록이 없습니다
							</div>
	                  	</c:if>
	                  </tbody>
	                </table>
	              </div>
              </div>
            </div>
          </section>
          <section class="col-lg-5 connectedSortable">

            <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="fas fa-chart-pie mr-1"></i>
                  차트
                </h3>
                <div class="card-tools">
                  <ul class="nav nav-pills ml-auto">
                    <li class="nav-item">
                      <a class="nav-link active" href="#revenue-chart" data-toggle="tab">날짜별</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="#sales-chart" data-toggle="tab">종류별</a>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="card-body">
              	<div class="tab-content p-0">
                  <div class="chart tab-pane active" id="revenue-chart"
                       style="position: relative; height: 400px;">
                      <canvas id="myChart" width="400" height="400"></canvas>
                   </div>
                  <div class="chart tab-pane" id="sales-chart" style="position: relative; height: 430px;">
                  	<canvas id="myChart2" width="400" height="400"></canvas>
                  </div>
                </div>
  
              </div>
            </div>

          </section>
        </div>
      </div>
    </section>
</div>

</body>
</html>