<html>
	<head>
	</head>
	<body>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	    
	    $(document).ready(function() {	        
            $('.level_elem').on("click",function(event){
                elem_pos =  $(this).attr("id");
                level = $("#level").text()
                request_url = "/follow_element/" + level + "/" + elem_pos
                $.ajax({
                    url: request_url,
                    context: document.body
                }).done(function(data) {
                    alert(JSON.stringify(data))
                 
                }).fail(function(data){
                    alert("Error calling:"+request_url)
                });
                alert("At level:" + level + " and elem pos:" + elem_pos);
            })
         });
    
	
	</script>
	
		<p>Elements prensent in: {{url}}</p>
            
		<p>Level: <span id="level">{{level}}</span></p>
		
		    <table>
            %for i,e in enumerate(element_list[0]):         
                <tr>
                    <td> <p> <a class="level_elem" id="{{i}}" href="javascript:void(0)">{{e.tag_name}}</a></p> </td>
                <tr>    
            </table>
	</body>


<html>
