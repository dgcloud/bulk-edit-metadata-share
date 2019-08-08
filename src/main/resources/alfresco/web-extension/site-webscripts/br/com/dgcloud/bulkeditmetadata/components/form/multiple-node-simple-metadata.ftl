<#if formUI == "true">
   <@formLib.renderFormsRuntime formId=formId />
</#if>
 
<div id="${args.htmlid}-dialog">
   <div id="${args.htmlid}-dialogTitle" class="hd"></div>
   <div class="bd">
 	
 	<#assign el=args.htmlid?html>
 	
	<div style="padding: 1em; border-bottom: 1px solid #ccc">
		<label>
			<a onclick="javascript:checkAll('${formId}', true);" href="javascript:void();">${msg("form.checkAll")}</a> | 
			<a onclick="javascript:checkAll('${formId}', false);" href="javascript:void();">${msg("form.uncheckAll")}</a>
		</label>
    </div>
        
      <div id="${formId}-container" class="form-container">
         <#if form.showCaption?exists && form.showCaption>
            <div id="${formId}-caption" class="caption"><span class="mandatory-indicator">*</span>${msg("form.required.fields")}</div>
         </#if>
       
         <form id="${formId}" method="${form.method}" accept-charset="utf-8" enctype="${form.enctype}" action="${form.submissionUrl}">
            <input type="hidden" id="muliple-edit-nodeRefs" />
            <div id="${formId}-fields" class="form-fields">
               <#list form.structure as item>
                  <#if item.kind == "set">
                     <@formLib.renderSet set=item />
                  <#else>
                     <@formLib.renderField field=form.fields[item.id] />
                  </#if>
               </#list>
            </div>
 
            <div class="bdft">
               <input id="${formId}-submit" type="submit" value="${msg("form.button.submit.label")}" />
               &nbsp;<input id="${formId}-cancel" type="button" value="${msg("form.button.cancel.label")}" />
            </div>
       
         </form>
 
      </div>
   </div>
</div>
 
<script type="text/javascript">
YAHOO.util.Event.onAvailable('muliple-edit-nodeRefs', function(){
  // Set which nodeRefs are involved in the multiple update.
  YAHOO.util.Dom.get('muliple-edit-nodeRefs').value = window.RPLP.globalNodeRefs.join();
});
 
</script>

<script type="text/javascript" language="javascript">// <![CDATA[
function checkAll(formname, checktoggle)
{
  var checkboxes = new Array(); 
  checkboxes = document.getElementById(formname).getElementsByTagName('input');
 
  for (var i=0; i<checkboxes.length; i++)  {
    if (checkboxes[i].type == 'checkbox')   {
      checkboxes[i].checked = checktoggle;
      checkboxes[i].onchange();
    }
  }
}
// ]]></script>