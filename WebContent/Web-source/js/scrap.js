/*AJAX scrap*/
var request = new XMLHttpRequest();
$(document).ready(function() {

	$(".scrapBtn").click(function() {

		var licenseID = $(this).val();
		var active;
		if ($(this).is(".active")) {
			$(this).removeClass('active');
			active = false;
		}
		else {
			$(this).addClass('active');
			active = true;
		}

		$.ajax({
			url: "licenseScrapAction.do",
			type: "POST",
			data: {
				licenseID: licenseID,
				active: active
			},
			success: function(result) {
				if (result == 1) {
					if (active) {
					}
					else {
					}
				}
				else if (result == 0) {
					alert('잘못된 접근입니다.');
				}
				else if (result == -1) {
					alert('로그인을 해주세요');
					location.href="index.do";
				}
				else { // -1
					alert('DB오류');
				}
			}
		});
	});
});


$(document).ready(function() {
	$(".scrap").click(function() {
		var writingID = $(this).val();
		var active;
		if ($(this).is(".active")) {
			$(this).removeClass('active');
			active = false;
		}
		else {
			$(this).addClass('active');
			active = true;
		}

		$.ajax({
			url: "commuScrapAction.do",
			type: "POST",
			data: {
				writingID: writingID,
				active: active
			},
			success: function(result) {
				if (result == 1) {
					if (active) {
						$("#scrapCount").text(parseInt($("#scrapCount").text())+1);
					}
					else {
						$("#scrapCount").text(parseInt($("#scrapCount").text())-1);
					}
				}
				else if (result == 0) {
					alert('잘못된 접근입니다.');
				}
				else if (result == -1) {
					alert('로그인을 해주세요');
					location.href="../index.do";
				}
				else { // -1
					alert('DB오류');
				}
			}
		});
	});
});