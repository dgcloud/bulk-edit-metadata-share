  <div class="yui-gc">
    <div class="yui-u first">
      <div class="form-field">
          <label for="${fieldHtmlId}">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
          <input id="${fieldHtmlId}" name="${field.name}" tabindex="0"
                 <#if field.control.params.password??>type="password"<#else>type="text"</#if>
                 <#if field.control.params.styleClass??>class="${field.control.params.styleClass}"</#if>
                 <#if field.control.params.style??>style="${field.control.params.style}"</#if>
                 <#if field.value?is_number>value="${field.value?c}"<#else>value="${field.value?html}"</#if>
                 <#if field.description??>title="${field.description}"</#if>
                 <#if field.control.params.maxLength??>maxlength="${field.control.params.maxLength}"<#else>maxlength="1024"</#if> 
                 <#if field.control.params.size??>size="${field.control.params.size}"</#if> 
                 disabled="true" />
          <@formLib.renderFieldHelp field=field />
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