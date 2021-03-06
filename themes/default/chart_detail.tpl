<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<form name="frm" method="post" action="index.php?route=<?php echo $_GET['route'] ?>&token=<?php echo $_GET['token'] ?>" enctype="multipart/form-data">
	<input type="hidden" name="id" value="<?php echo (isset($_GET['id']))?$_GET['id']:''; ?>" />
	<table class="list">
		<tr>
			<td><?php echo $this->label_category_name; ?> : </td>
			<td><input class="required" type="text" name="req_name" value="<?php echo stripslashes($this->category['name']); ?>" /></td>
		</tr>

		<tr>
			<td><?php echo $this->label_category_parent_id; ?></td>
			<td><input class="required" type="text" name="reqnum_parent_id" value="<?php echo $this->category['parent_id']; ?>" /></td>
		</tr>
		

		<tr><td colspan="2"><input type="button" onclick="validate();" name="btnSubmit" value="Opslaan" /></td></tr>
		<tr><td colspan="2"><input type="button" name="btnBack" value="Annuleren" onclick="document.location.href='index.php?route=category/overview&token=<?php echo $_GET['token']; ?>'" /></td></tr>
	</table>
	</form>
</div>
<script>
	$(document).ready(function(){
		$('input[name^="req"]').each(function(){
			$(this).after('<span>*</span>');
		});
                $('input[class="datepicker"]').datepicker({
			dateFormat: 'yy-mm-dd', 
		});
	});
	
	function validate(){
       
		error = false;
		
		$('input[name^="req"]').each(function(){
			$(this).parent().find('span').html('*');
			
			if($(this).val() == ''){
				$(this).css('border', '1px solid #f00');
				$(this).parent().find('span').append('   Dit veld is verplicht!');
				error = true;
			}
		});
		
		if(isNaN($('input[name^="reqnum"]').val())){
			$('input[name="req_price"]').css('border', '1px solid #f00');
			$('input[name="req_price"]').parent().find('span').append('   Dit moet een getal zijn!');
			error = true;
		}

		location_array = [];
		
		$('select[name="location[]"]').each(function(){
                        
			if($.inArray($(this).val(), location_array) != -1){
				error = true;
				$(this).css('border', '1px solid #f00');
			}else{
				location_array.push($(this).val());
			}
		});
                
		resource_array = [];
		
		$('select[name="resource[]"]').each(function(){
                        
			if($.inArray($(this).val(), resource_array) != -1){
				error = true;
				$(this).css('border', '1px solid #f00');
			}else{
				resource_array.push($(this).val());
			}
		});
                

                if(error == false)
                    $('form').submit();
                
		
	}

	function addLocation(){
		html = '';
		
		html += '<tr>';
		html += '<td>Locatie:</td>';
		html += '<td>';
		html += '<select name="location[]">';
		html += '<option value="">-- Selecteer een locatie --</option>';
		<?php foreach($this->locations as $location){ ?>
		html += '<option value="<?php echo $location['location_id'] ?>"><?php echo $location['name'] ?></option>';
		<?php } ?>
		html += '</select>';
		html += '  <img src="./themes/<?php echo THEME ?>/images/remove.png" onclick="deleteLocation(this);" />';
		html += '</td>';
		html += '</tr>';

		$('.location_placeholder').before(html);
	}
	function addResource(){
		html = '';
		
		html += '<tr>';
		html += '<td>Resource:</td>';
		html += '<td>';
		html += '<select name="resource[]">';
		html += '<option value="">-- Selecteer een resource --</option>';
		<?php foreach($this->resources as $resource){ ?>
		html += '<option value="<?php echo $resource['resource_id'] ?>"><?php echo $resource['name'] ?></option>';
		<?php } ?>
		html += '</select>';
		html += '  <img src="./themes/<?php echo THEME ?>/images/remove.png" onclick="deleteResource(this);" />';
		html += '</td>';
		html += '</tr>';

		$('.resource_placeholder').before(html);
	}
        

        
	

	function deleteLocation(location){
		$(location).parent().parent().remove();
	}	
	function deleteResource(resource){
		$(resource).parent().parent().remove();
	}	
	
	
</script>














