<#if field.control.params.submitTime?? && field.control.params.submitTime == "false"><#assign submitTime=false><#else><#assign submitTime=true></#if>
<#if field.control.params.showTime?? && field.control.params.showTime == "true"><#assign showTime=true><#else><#assign showTime=false></#if>

<#if showTime><#assign viewFormat>${msg("form.control.date-picker.view.time.format")}</#assign><#else><#assign viewFormat>${msg("form.control.date-picker.view.date.format")}</#assign></#if>

<div class="yui-gc">
	<div class="yui-u first">
		<div class="form-field">
			<#assign controlId = fieldHtmlId + "-cntrl">
		     
		    <script type="text/javascript">//<![CDATA[
		    (function()
		    {
		    	new Alfresco.DatePicker("${controlId}", "${fieldHtmlId}").setOptions(
		        {
		           disabled: true,
		           currentValue: "${field.value?js_string}",
		           showTime: ${showTime?string},
		           submitTime: ${submitTime?string},
		           mandatory: ${field.mandatory?string}
		        }).setMessages(
		           ${messages}
		        );
			})();
		    //]]></script>
		  
		    <input id="${fieldHtmlId}" type="hidden" name="${field.name?html}" value="${field.value?html}" />
		  
		    <label for="${controlId}-date">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
		    <input id="${controlId}-date" name="-" type="text" class="date-entry" <#if field.description??>title="${field.description}"</#if> disabled="true" />
		  
		    <a id="${controlId}-icon" tabindex="0" href="#" style="display:none;"><img src="${url.context}/res/components/form/images/calendar.png" class="datepicker-icon"/></a>
		  
		    <div id="${controlId}" class="datepicker"></div>
		  
		    <#if showTime>
		        <input id="${controlId}-time" name="-" type="text" class="time-entry" <#if field.description??>title="${field.description}"</#if> disabled="true" />
		    </#if>
		     
		    <@formLib.renderFieldHelp field=field />
		  
		    <div class="format-info">
		        <span class="date-format">${msg("form.control.date-picker.display.date.format")}</span>
		        <#if showTime><span class="time-format<#if disabled>-disabled</#if>">${msg("form.control.date-picker.display.time.format")}</span></#if>
		    </div>		         
		</div>
	</div>
    <div class="yui-u">
      	<div class="form-field">
        	<br/>
        	<input class="formsCheckBox" id="${fieldHtmlId}-entry" type="checkbox" tabindex="0" 
                   onchange='disableSiblingDateField("${fieldHtmlId}-cntrl");' />
        	<label for="${fieldHtmlId}-entry" class="checkbox">${msg("edit-details.label.edit-metadata")}</label>
      	</div>
 	</div>
</div>

<script type="text/javascript">//<![CDATA[
function disableSiblingDateField(fieldId){
  var fieldToDisable = YAHOO.util.Dom.get(fieldId + '-date');
  if (fieldToDisable.disabled === true){
    fieldToDisable.disabled = false;
  }else {
    fieldToDisable.disabled = true;
  }
  
  fieldToDisable = YAHOO.util.Dom.get(fieldId + '-icon');
  if (fieldToDisable.style.display === "none"){
    fieldToDisable.style.display = "";
  }else {
    fieldToDisable.style.display = "none";
  }
}
//]]></script>