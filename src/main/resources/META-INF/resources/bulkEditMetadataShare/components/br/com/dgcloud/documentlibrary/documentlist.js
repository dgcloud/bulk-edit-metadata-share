window.RPLP = window.RPLP || {};
window.RPLP.globalNodeRefs = [];

var $html = Alfresco.util.encodeHTML,
$combine = Alfresco.util.combinePaths,
$siteURL = Alfresco.util.siteURL,
$isValueSet = Alfresco.util.isValueSet;

YAHOO.Bubbling.fire("registerAction", {
    actionName: "onActionEditMultipleDocumentMetadata",
    fn: function rplp_onActionEditMultipleDocumentMetadata(record) {
        var type = record[0].jsNode.type;

        // Check that all the nodes are of same type
        var allSame = true;
        var nodeRefs = [];
        for (var i = 0, ii = record.length; i < ii; i++) {
            jsNode = record[i].jsNode;
            if (type !== jsNode.type) {
                allSame = false;
                break;
            }
            nodeRefs.push(record[i].nodeRef);
        }
        window.RPLP.globalNodeRefs = nodeRefs;

        if (allSame === false) {
            Alfresco.util.PopupManager.displayMessage({
                text: this.msg("rplp.actions.editMultipleDocumentMetadata.multipleTypes"),
                displayTime: 2.0
            });
        } else { // All are of same type

            // Spawn form
            var scope = this,
                nodeRef = record[0].nodeRef,
                jsNode = record[0].jsNode;

            // Intercept before dialog show
            var doBeforeDialogShow = function dlA_onActionDetails_doBeforeDialogShow(p_form, p_dialog) {
                // Dialog title
                var fileSpan = '<span class="light">' + this.msg("rplp.actions.editMultipleDocumentMetadata.dialogTitle") + '</span>';

                Alfresco.util.populateHTML(
                    [p_dialog.id + "-dialogTitle", scope.msg("edit-details.title", fileSpan)]
                );

                // Edit metadata link button
                this.widgets.editMetadata = Alfresco.util.createYUIButton(p_dialog, "editMetadata", null, {
                    type: "link",
                    label: scope.msg("edit-details.label.edit-metadata"),
                    href: $siteURL("edit-metadata?nodeRef=" + nodeRef)
                });
            };

            //var templateUrl = YAHOO.lang.substitute(Alfresco.constants.URL_SERVICECONTEXT + "components/form?itemKind={itemKind}&itemId={itemId}&destination={destination}&mode={mode}&submitType={submitType}&formId={formId}&showCancelButton=true", {
            var templateUrl = YAHOO.lang.substitute(Alfresco.constants.URL_SERVICECONTEXT + "components/form?itemKind={itemKind}&itemId={itemId}&mode={mode}&submitType={submitType}&formId={formId}&showCancelButton=true", {            	
                itemKind: "node",
                itemId: nodeRef,
                mode: "edit",
                submitType: "json",
                formId: "multiple-edit-metadata"
            });

            // Using Forms Service, so always create new instance
            var editDetails = new Alfresco.module.SimpleDialog(this.id + "-editDetails-" + Alfresco.util.generateDomId());

            editDetails.setOptions({
                width: "auto",
                templateUrl: templateUrl,
                actionUrl: null,
                destroyOnHide: true,
                doBeforeDialogShow: {
                    fn: doBeforeDialogShow,
                    scope: this
                },
                onSuccess: {
                    fn: function dlA_onActionDetails_success(response) {
                        // Reload the node's metadata
                        var webscriptPath = "components/documentlibrary/data";
                        if ($isValueSet(this.options.siteId)) {
                            webscriptPath += "/site/" + encodeURIComponent(this.options.siteId)
                        }
                        Alfresco.util.Ajax.request({
                            url: $combine(Alfresco.constants.URL_SERVICECONTEXT, webscriptPath, "/node/", jsNode.nodeRef.uri) + "?view=" + this.actionsView,
                            successCallback: {
                                fn: function dlA_onActionDetails_refreshSuccess(response) {

                                    // Display success message
                                    Alfresco.util.PopupManager.displayMessage({
                                        text: this.msg("message.details.success")
                                    });

                                    // Refresh the document list...
                                    YAHOO.Bubbling.fire("metadataRefresh");
                                },
                                scope: this
                            },
                            failureCallback: {
                                fn: function dlA_onActionDetails_refreshFailure(response) {
                                    Alfresco.util.PopupManager.displayMessage({
                                        text: this.msg("message.details.failure")
                                    });
                                },
                                scope: this
                            }
                        });
                    },
                    scope: this
                },
                onFailure: {
                    fn: function dLA_onActionDetails_failure(response) {
                        var failureMsg = this.msg("message.details.failure");
                        if (response.json && response.json.message.indexOf("Failed to persist field 'prop_cm_name'") !== -1) {
                            failureMsg = this.msg("message.details.failure.name");
                        }
                        Alfresco.util.PopupManager.displayMessage({
                            text: failureMsg
                        });
                    },
                    scope: this
                }
            }).show();
        }
    }
});