<#if field.control.params.rows??><#assign rows=field.control.params.rows><#else><#assign rows=3></#if>
<#if field.control.params.columns??><#assign columns=field.control.params.columns><#else><#assign columns=60></#if>

<div class="yui-gc">
	<div class="yui-u first">
		<div class="form-field alf-textarea">
		   <label for="${fieldHtmlId}">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
		   <@formLib.renderFieldHelp field=field />
		   <textarea id="${fieldHtmlId}" name="${field.name}" rows="${rows}" cols="${columns}" tabindex="0"
		      <#if field.description??>title="${field.description}"</#if>
		      <#if field.control.params.styleClass??>class="${field.control.params.styleClass}"</#if>
		      <#if field.control.params.style??>style="${field.control.params.style}"</#if>
		      <#if field.control.params.maxLength??>maxlength="${field.control.params.maxLength}"<#else>maxlength="1024"</#if>
		      disabled="true"></textarea>
		</div>
    </div>
	<div class="yui-u">
	  	<div class="form-field">
	    	<br/>
	    	<input class="formsCheckBox" id="${fieldHtmlId}-entry" type="checkbox" tabindex="0" 
	               onchange='disableSiblingInputField("${fieldHtmlId}");' />
	    	<label for="${fieldHtmlId}-entry" class="checkbox">${msg("edit-details.label.edit-metadata")}</label>
	  	</div>
	</div>
</div>
 
<script type="text/javascript">//<![CDATA[
function disableSiblingInputField(fieldId){
  var fieldToDisable = YAHOO.util.Dom.get(fieldId);
  if (fieldToDisable.disabled === true){
    fieldToDisable.disabled = false;
  }else {
    fieldToDisable.disabled = true;
  }
}
//]]></script>