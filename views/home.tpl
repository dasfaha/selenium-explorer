<html>
	<head>
	</head>
	<body>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	    function clearCellBackground(elem_level){
            $('[id^=elem_level]').each(function(){
                $(this).css("background-color", "")
            })
        }                  
        
        


	    $(document).ready(function() {	        
            $('.level_elem').on("click",function(event){
                elem_level_pos =  $(this).attr("id").split("-");
                assertTrue(elem_level_pos.length==2)
                elem_level = elem_level_pos[0]
                elem_pos = elem_level_pos[1]
                clearCellBackground(elem_level);
                //highlight element selected
                $(this).css("background-color", "#C5F55D");
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
    
        function getConsole(){
            $.get('/get_console', function(data) {
        });

            alert("here");
        }
	</script>
	
		<p>Elements prensent in: {{url}}</p>
            
		<p>Level: <span id="level">{{level}}</span></p>
        HERE!!!!!
        <p><a href="javascript:getConsole()">Get Console</a></p>		
		    <table id="elems">
            %for i,e in enumerate(element_list[0]):         
                <tr>
                    <td> <p> <a class="level_elem" id="{{level}}-{{i}}" href="javascript:void(0)">{{e.tag_name}}</a></p> </td>
                <tr>    
            </table>
	</body>


<html>
