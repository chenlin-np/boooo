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

/**
 * Customize Link widget that does not have medium and small label options
 */
northpoint.components.SimplifiedLinkWidget = CQ.Ext.extend(CQ.form.CompositeField, {

    hiddenField: null,
    labelField: null,
	pathField: null,
    classField: null,
    openInNewWindowField: null,
    displayNavigationInMenuField: null,
    
    constructor: function(config) {
        config = config || { };
        var defaults = {
            "border": false,
            "layout": "table",
            "columns":2
        };
        config = CQ.Util.applyDefaults(config, defaults);
        northpoint.components.SimplifiedLinkWidget.superclass.constructor.call(this, config);
    },

    // overriding CQ.Ext.Component#initComponent
    initComponent: function() {
        northpoint.components.LinkWidget.superclass.initComponent.call(this);

        this.hiddenField = new CQ.Ext.form.Hidden({
            name: this.name
        });
        this.add(this.hiddenField);

        this.add(new CQ.Ext.form.Label({text: "Label"}));
        this.labelField = new CQ.Ext.form.TextField({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.labelField);
        
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
        
        this.add(new CQ.Ext.form.Label({text: "Supress Sub-Menu In Hamburger"}));
        this.displayNavigationInMenuField = new CQ.Ext.form.Checkbox({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.displayNavigationInMenuField);

        this.add(new CQ.Ext.form.Label({text: "Class"}));
        this.classField = new CQ.Ext.form.TextField({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.classField);
    },

    // overriding CQ.form.CompositeField#setValue
    setValue: function(value) {
        var parts = value.split("|||");
        this.labelField.setValue(parts[0]);
        this.pathField.setValue(parts[1]);
		this.classField.setValue(parts[2]);
		this.openInNewWindowField.setValue(parts[3]);
		this.displayNavigationInMenuField.setValue(parts[4]);
		this.hiddenField.setValue(value);
    },

    // overriding CQ.form.CompositeField#getValue
    getValue: function() {
        return this.getRawValue();
    },

    // overriding CQ.form.CompositeField#getRawValue
    getRawValue: function() {
        return this.labelField.getValue() + "|||" 
        	+ this.pathField.getValue() + "|||"
            + this.classField.getValue() + "|||"
            + (this.openInNewWindowField.getValue() ? 'true' : 'false') + "|||"
            + (this.displayNavigationInMenuField.getValue() ? 'true' : 'false');
            
    },

    // private
    updateHidden: function() {
        this.hiddenField.setValue(this.getValue());
    } 

});

// register xtype
CQ.Ext.reg('simplifiedcustomlink', northpoint.components.SimplifiedLinkWidget);
