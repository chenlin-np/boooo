/*
 * Copyright 1997-2010 Day Management AG
 * Barfuesserplatz 6, 4001 Basel, Switzerland
 * All Rights Reserved.
 *
 * This software is the confidential and proprietary information of
 * Day Management AG, ("Confidential Information"). You shall not
 * disclose such Confidential Information and shall use it only in
 * accordance with the terms of the license agreement you entered into
 * with Day.
 */

/**
 * @class Ejst.CustomWidget
 * @extends CQ.form.CompositeField
 * This is a custom widget based on {@link CQ.form.CompositeField}.
 * @constructor
 * Creates a new CustomWidget.
 * @param {Object} config The config object
 */

northpoint.components.FreqAccessForm = CQ.Ext.extend(CQ.form.CompositeField, {

    hiddenField: null,
    pdfTitle: null,
	pathField: null,
    openInNewWindowField: null,
    
    constructor: function(config) {
        config = config || { };
        var defaults = {
            "border": false,
            "layout": "table",
            "columns":2
        };
        config = CQ.Util.applyDefaults(config, defaults);
        northpoint.components.LinkWidget.superclass.constructor.call(this, config);
    },

    // overriding CQ.Ext.Component#initComponent
    initComponent: function() {
        northpoint.components.LinkWidget.superclass.initComponent.call(this);

        this.hiddenField = new CQ.Ext.form.Hidden({
            name: this.name
        });
        this.add(this.hiddenField);

        this.add(new CQ.Ext.form.Label({text: "Pdf Title"}));
        this.pdfTitle = new CQ.Ext.form.TextField({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.pdfTitle);
        
        this.add(new CQ.Ext.form.Label({text: "External Link"}));
        this.externalLabel = new CQ.Ext.form.TextField({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.externalLabel);

        this.add(new CQ.Ext.form.Label({text: "Path"}));
        this.pathField = new CQ.form.PathField({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                },
                dialogselect: {
                    scope:this,
                    fn:this.updateHidden
                }
            } 
        });
        this.add(this.pathField);

        this.add(new CQ.Ext.form.Label({text: "New Window"}));
        this.openInNewWindowField = new CQ.Ext.form.Checkbox({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.openInNewWindowField);
    },

    // overriding CQ.form.CompositeField#setValue
    setValue: function(value) {
        var parts = value.split("|||");
        this.pdfTitle.setValue(parts[0]);
        this.externalLabel.setValue(parts[1]);
		this.pathField.setValue(parts[2]);
        this.openInNewWindowField.setValue(parts[3]);
		this.hiddenField.setValue(value);
    },

    // overriding CQ.form.CompositeField#getValue
    getValue: function() {
        return this.getRawValue();
    },

    // overriding CQ.form.CompositeField#getRawValue
    getRawValue: function() {
        return this.pdfTitle.getValue() + "|||" 
             + this.externalLabel.getValue() + "|||"
        	 + this.pathField.getValue() + "|||"
             +(this.openInNewWindowField.getValue() ? 'true' : 'false');
         
    },

    // private
    updateHidden: function() {
        this.hiddenField.setValue(this.getValue());
    } 

});

// register xtype
CQ.Ext.reg('freqAccessLink', northpoint.components.FreqAccessForm);
