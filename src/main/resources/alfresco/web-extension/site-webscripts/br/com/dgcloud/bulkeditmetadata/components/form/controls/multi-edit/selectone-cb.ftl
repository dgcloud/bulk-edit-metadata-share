<#include "/org/alfresco/components/form/controls/common/utils.inc.ftl" />

<#if field.control.params.optionSeparator??>
   <#assign optionSeparator=field.control.params.optionSeparator>
<#else>
   <#assign optionSeparator=",">
</#if>
<#if field.control.params.labelSeparator??>
   <#assign labelSeparator=field.control.params.labelSeparator>
<#else>
   <#assign labelSeparator="|">
</#if>

<#assign fieldValue=field.value>

<#if fieldValue?string == "" && field.control.params.defaultValueContextProperty??>
   <#if context.properties[field.control.params.defaultValueContextProperty]??>
      <#assign fieldValue = context.properties[field.control.params.defaultValueContextProperty]>
   <#elseif args[field.control.params.defaultValueContextProperty]??>
      <#assign fieldValue = args[field.control.params.defaultValueContextProperty]>
   </#if>
</#if>

<div class="yui-gc">
   <div class="yui-u first">
      <div class="form-field">
         <label for="${fieldHtmlId}">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
         <#if field.control.params.options?? && field.control.params.options != "">
            <select id="${fieldHtmlId}" name="${field.name}" tabindex="0"
                  <#if field.description??>title="${field.description}"</#if>
                  <#if field.indexTokenisationMode??>class="non-tokenised"</#if>
                  <#if field.control.params.size??>size="${field.control.params.size}"</#if> 
                  <#if field.control.params.styleClass??>class="${field.control.params.styleClass}"</#if>
                  <#if field.control.params.style??>style="${field.control.params.style}"</#if>
                  disabled="true">
                  <#list field.control.params.options?split(optionSeparator) as nameValue>
                     <#if nameValue?index_of(labelSeparator) == -1>
                        <option value="${nameValue?html}"<#if nameValue == fieldValue?string || (fieldValue?is_number && fieldValue?c == nameValue)> selected="selected"</#if>>${nameValue?html}</option>
                     <#else>
                        <#assign choice=nameValue?split(labelSeparator)>
                        <option value="${choice[0]?html}" <#if choice[0] == fieldValue?string || (fieldValue?is_number && ((fieldValue - choice[0]?number)?string == "0"))> selected="selected"</#if>>${msgValue(choice[1])?html}</option>
                     </#if>
                  </#list>
            </select>
            <@formLib.renderFieldHelp field=field />
         <#else>
            <div id="${fieldHtmlId}" class="missing-options">${msg("form.control.selectone.missing-options")}</div>
         </#if>
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