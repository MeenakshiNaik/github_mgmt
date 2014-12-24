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

	$(".commiter_name").click(function(e){
    e.preventDefault();
    var data_attr = $(this).attr("data-class");
    
		$(".commits").hide() 
		$(".commiter_name").removeClass("active")
    $(this).addClass('active')
		$("div[data-name = "+data_attr+"]").show();
	})//show page user wise commit
	 
  $(".commiter_name").first().trigger("click");
});


function user_wise_graph(chart_title ,day_from_week , series_data){
	$('#container').highcharts({
		title: {
			text: chart_title,
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