
var replyService = (function(){
	
	function add(reply, callback, error){
		console.log("add reply...");
		
		$.ajax({
			type: 'post',
			url: '/replies/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error) {
		var num = param.num;
		
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+num+"/"+page+".json", 
		function(data){
			if(callback){
				callback(data.replyCnt,data.list);
			}
		}).fail(function(xhr, status, err){
			error();
		})
	}
	
	function remove(repnum, callback, error) {
		$.ajax({
			type: 'delete',
			url: '/replies/'+repnum,
			success: function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function update(reply, callback, error){
		console.log("repnum"+reply.repnum);
		
		$.ajax({
			type:'put',
			url:'/replies/'+reply.repnum,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				error(er);
			}
		})
	}
	
	function get(repnum, callback, error){
		$.get("/replies/"+repnum+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		})
	}
	
	function time(gap,todayvalue){
			if(gap <(1000 * 60 * 60 * 24)) {
					var hh = todayvalue.getHours();
					var mi = todayvalue.getMinutes();
					var ss = todayvalue.getSeconds();
					
					return [(hh>9 ? '' : '0')+hh, ':',(mi>9 ? '':'0')+mi,':',
					(ss >9 ? '' : '0')+ss].join('');
				} else {
					var yy = todayvalue.getFullYear();
					var mm = todayvalue.getMonth() + 1;
					var dd = todayvalue.getDate();
					
					return [yy,'/',(mm >9 ?'':'0')+mm,'/',(dd>9 ? '':'0')+dd].join('');
				}
	}

	return {
		add : add,
		getList:getList,
		remove : remove,
		update: update,
		get: get,
		time:time
	}
})();