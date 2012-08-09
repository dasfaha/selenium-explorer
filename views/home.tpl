<html>
	<head>
	</head>
	<body>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	    function clearBackgroundForColumn(elem_level){
            console.debug("here");
            $('[id^='+ elem_level.toString() + ']').each(function(){
                $(this).css("background-color", "")
            })
        }                  
        
        function getCellsInColumn(column){
            var cellsInColumn = new Array();
            $('[id^='+ column.toString() + ']').each(function(eachCell){
                cellsInColumn.push($(this));
            })
            return cellsInColumn;
        }
        


	    $(document).ready(function() {	        
            $('.elem_rows').on("click",".level_elem",function(event){
                elem_level_pos =  $(this).attr("id").split("-");
                //assertTrue(elem_level_pos.length==2)
                elem_level = parseInt(elem_level_pos[0])
                elem_pos = parseInt(elem_level_pos[1])
                clearBackgroundForColumn(elem_level);
                //highlight element selected
                $(this).css("background-color", "#C5F55D");
                level = $("#level").text()
                request_url = "/follow_element/" + elem_level + "/" + elem_pos
                $.ajax({
                    url: request_url,
                    context: document.body
                }).done(function(data) {
                    alert(JSON.stringify(data))
                    new_level = elem_level + 1;
                    //if column already exists - clear it
                    
                    element_list = data["element_list"]
                    rowCount = $("#elems tr").length   
                    columnCount = $(".elem_rows:first > td").length
                    console.log("Current level:" + level + " And new level is:"+new_level)
                    if (element_list.length>0){
                            cellsInNewColumn = getCellsInColumn(new_level);
                            if (cellsInNewColumn.length > 0){
                                $.each(cellsInNewColumn, function (index, cell){
                                    //console.log(cell)
                                    cell.text("");
                                })    
                            } else {
                            //if column doesn't exist - create it
                                $(".elem_rows").each(function(index, row){
                                    $(this).append('<td><a class="level_elem" id="' + new_level + '-' + index + '" href="javascript:void(0)"></a></td>')
                                })
                            }                        
                            /*update the column to the left with the values supplied by the request 
                              starting at the level of th cell that was clicked */
                            //check that there are enough rows, from the row of the element clicked, to add all elements returned
                            rowsNeeded = (elem_pos + element_list.length) - rowCount
                            if (rowsNeeded > 0){
                                rowCounter = rowCount
                                tableHandle = $("#elems")
                                for(j=rowCount; j>0; j--){
                                        //create a row
                                        new_row = ""
                                        for (i=0; i<columnCount; i++){
                                            new_row += '<td><a class="level_elem" id="' + i + '-' + rowCounter + '" href="javascript:void(0)"></a></td>' 
                                        }
                                
                                tableHandle.append(new_row)
                                rowCounter += 1        
                                }
                            } 
                            
                        elementCounter = 0    
                        console.debug(element_list)
                        $(".elem_rows").each(function (index, row){
                        if (index >= elem_pos){
                            if (element_list[elementCounter]){
                                row.cells[new_level].childNodes[0].text = element_list[elementCounter]
                                console.debug(elementCounter)
                                elementCounter++;
                            }
                        }
                        })
                                    

                            
                            //update the level in the user interface
                    $("#level").text(new_level)

                }
                }).fail(function(data){
                    alert("Error calling:"+request_url)
                });
           })
         });
    
        function getConsole(){
            $.get('/get_console', function(data) {
        });

        }
	</script>
	
		<p>Elements prensent in: {{url}}</p>
            
		<p>Level: <span id="level">{{level}}</span></p>
        <p><a href="javascript:getConsole()">Get Console</a></p>		
		    <table id="elems">
            %for i,e in enumerate(element_list[0]):         
                <tr class="elem_rows">
                    <td>  <a class="level_elem" id="{{level}}-{{i}}" href="javascript:void(0)">{{e.tag_name}}</a> </td>
                <tr>
            %end%    
            </table>
	</body>


<html>
