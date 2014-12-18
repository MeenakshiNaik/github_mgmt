$(document).ready(function () {
	$(document).on('click', '.panel-heading span.clickable', function(e){
		var $this = $(this);
		if(!$this.hasClass('panel-collapsed')) {
			$this.parents('.panel').find('.panel-body').slideUp();
			$this.addClass('panel-collapsed');
			$this.find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
		} else {
			$this.parents('.panel').find('.panel-body').slideDown();
			$this.removeClass('panel-collapsed');
			$this.find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
		}
	})//repo list
});

function chart(graph_label , graph_data){
	data = {

		labels : graph_label,
		datasets : [
		{
			label: "My First dataset",
			fillColor : "rgba(151,187,205,0.5)",
			strokeColor : "rgba(151,187,205,1)",
			pointColor : "rgba(151,187,205,1)",
			scaleLineHeight: 6,
			pointStrokeColor : "#fff",
			data : graph_data
		}
		]
	}
	myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data)
} // chart-js 


function user_wise_graph(day_from_week , series_data){
	$('#container').highcharts({
		title: {
			text: 'Weekly Commits By Users',
			x: -20 //center
		},

		xAxis: {
			categories: day_from_week
		},

		yAxis: {
			title: {
				text: 'Commit(s)'
			},

			plotLines: [{
				value: 0,
				width: 1,
				color: '#808080'
			}]
		},

		tooltip: {
			valueSuffix: ''
		},

		legend: {
			layout: 'vertical',
			align: 'right',
			verticalAlign: 'middle',
			borderWidth: 0
		},
		series: series_data
	});
}//highcharts