northpoint.components.TimezoneDateTime = CQ.Ext.extend(CQ.Ext.form.Field, {

    /**
     * @cfg {String/Object} defaultAutoCreate DomHelper element spec
     * Let superclass to create hidden field instead of textbox.
     * Hidden will be submitted to server
     */
    defaultAutoCreate:{tag:'input', type:'hidden'},

    /**
     * @cfg {Boolean} hideTime True to hide the time field
     */
    hideTime:false,

    /**
     * @cfg {Number} timeWidth Width of time field in pixels (defaults to 100)
     */
    timeWidth:100,

    /**
     * @cfg {Number} dateWidth Width of date field in pixels (defaults to 200)
     */
    dateWidth:200,

    /**
     * @cfg {Number} labelWidth Width of date field in pixels (defaults to 200)
     */
    labelWidth:160,

    /**
     * @cfg {String} dtSeparator Date - Time separator. Used to split date and time (defaults to ' ' (space))
     */
    dtSeparator:' ',

    /**
     * @cfg {String} hiddenFormat Format of datetime used to store value in hidden field
     * and submitted to server
     * (defaults to 'Y-m-d\\TH:i:sP' that is ISO8601 format)
     */
    //hiddenFormat: 'Y-m-d H:i:s'
    //hiddenFormat: 'd.m.Y H:i:s'
    hiddenFormat: 'Y-m-d\\TH:i:s.000P',

    /**
     * @cfg {String} defaultValue Init time or date field if not explicitly filled in (defaults to "").
  	 * Set to "now" to specify current date as default.
     */
    defaultValue: "",

    /**
     * @cfg {Boolean} allowBlank False to validate that at least one option is selected (defaults to true)
     */
    allowBlank: true,

    /**
     * @cfg {String} timePosition Where the time field should be rendered. 'right' is suitable for forms
     * and 'below' is suitable if the field is used as the grid editor (defaults to 'right')
     */
    timePosition:'right', // valid values:'below', 'right'

    /**
     * @cfg {Boolean} disableTypeHint True to disable the field @TypeHint
     */
    disableTypeHint:false,

    /**
     * @cfg {String} dateFormat Format of DateField. (defaults to CQ.Ext.form.DateField.prototype.format)
     */
    /**
     * @cfg {String} timeFormat Format of TimeField. (defaults to CQ.Ext.form.TimeField.prototype.format)
     */

    /**
     * @cfg {Boolean} valueAsString Returns string value instead of the date object for
     * getValue(). (defaults to false)
     */
    valueAsString: false,

    /**
     * @cfg {String} typeHint The type hint for the server. (defaults to 'Date')
     */
    typeHint: null,

    /**
     * @cfg {Object} dateConfig Config for DateField constructor.
     */
    /**
     * @cfg {Object} timeConfig Config for TimeField constructor.
     */

    /**
     * Taken from CQ.Ext.form.TriggerField. Needed for readOnly case, but before
     * the date or time widgets were created, so calling getTriggerWidth() is not
     * possible. However, the default will mostly be used anyway.
     * @private
     */
    defaultTriggerWidth: 17,

    /**
     * @cfg {String/Function} The Time Zone (defaults to this.defaultTimezone)
     */
    timezone: null,

    /**
     * @cfg {String/Function} The Default Time Zone (defaults to 'America/New_York')
     */
    defaultTimezone: "US/Eastern",

    /**
     * @private
     * creates DateField and TimeField and installs the necessary event handlers
     */
    initComponent:function() {
        // call parent initComponent
        northpoint.components.TimezoneDateTime.superclass.initComponent.call(this);
        
        var timezones = northpoint.functions.getTimezones();
        // Choose the default time zone
        this.timezone = timezones[0].timezone;
        
        // create DateField
        var dateConfig = CQ.Ext.apply({}, {
             id:this.id + '-date',
            format:this.dateFormat || CQ.Ext.form.DateField.prototype.format,
            width: this.readOnly ? this.dateWidth - this.defaultTriggerWidth : this.dateWidth,
            selectOnFocus:this.selectOnFocus,
            allowBlank:this.allowBlank,
            hideTrigger: this.readOnly,
            readOnly: this.readOnly,
            listeners:{
                 blur:{scope:this, fn:this.onBlur},
                 focus:{scope:this, fn:this.onFocus}
            }
        }, this.dateConfig);
        this.df = new CQ.Ext.form.DateField(dateConfig);
        delete(this.dateFormat);

        // create TimeField
        var timeConfig = CQ.Ext.apply({}, {
             id:this.id + '-time',
            format:this.timeFormat || CQ.Ext.form.TimeField.prototype.format,
            width: this.readOnly ? this.timeWidth - this.defaultTriggerWidth : this.timeWidth,
            hideTrigger: this.readOnly,
            minListWidth: this.timeWidth,
            selectOnFocus:this.selectOnFocus,
            allowBlank:this.allowBlank,
            readOnly: this.readOnly,
            listeners:{
                 blur:{scope:this, fn:this.onBlur},
                 focus:{scope:this, fn:this.onFocus}
            }
        }, this.timeConfig);
        this.tf = new CQ.Ext.form.TimeField(timeConfig);
        delete(this.timeFormat);
        
        // create timezone label
        this.lf = new CQ.Ext.form.Label({text: this.timezone});

        // relay events
        this.relayEvents(this.df, ['focus', 'specialkey', 'invalid', 'valid']);
        this.relayEvents(this.tf, ['focus', 'specialkey', 'invalid', 'valid']);
    },

    /**
     * @private
     * Renders underlying DateField and TimeField and provides a workaround for side error icon bug
     */
    onRender:function(ct, position) {
        // don't run more than once
        if(this.isRendered) {
            return;
        }

        // render underlying hidden field
        CQ.form.DateTime.superclass.onRender.call(this, ct, position);

        // render DateField and TimeField
        // create bounding table
        var t;
        if('below' === this.timePosition || 'bellow' === this.timePosition) {
            t = CQ.Ext.DomHelper.append(ct, {tag:'table',style:'border-collapse:collapse',children:[
                 {tag:'tr',children:[{tag:'td', style:'padding-bottom:1px', cls:'ux-datetime-date'}]},
                 {tag:'tr',children:[{tag:'td', style: this.hideTime ? "display:none;" : "", cls:"ux-datetime-time"}]},
                 {tag:'tr',children:[{tag:'td', style: "", cls:"ux-datetime-timezone"}]}
            ]}, true);
        } else {
            t = CQ.Ext.DomHelper.append(ct, {tag:'table',style:'border-collapse:collapse',children:[
                {tag:'tr',children:[
                    {tag:'td', style:'padding-right:' + (this.readOnly ? this.defaultTriggerWidth : '0') + 'px', cls:'ux-datetime-date'},
                    {tag:'td', style: this.hideTime ? "display:none;" : "", cls:"ux-datetime-time"},
                    {tag:'td', style: "padding-left: 10px", cls:"ux-datetime-timezone"}
                ]}
            ]}, true);
        }

        this.tableEl = t;

        this.wrap = t.wrap();
        this.wrap.on("mousedown", this.onMouseDown, this, {delay:10});

        // render DateField & TimeField
        this.df.render(t.child('td.ux-datetime-date'));
        this.tf.render(t.child('td.ux-datetime-time'));
        this.lf.render(t.child('td.ux-datetime-timezone'));

        // workaround for IE trigger misalignment bug
        if(CQ.Ext.isIE && CQ.Ext.isStrict) {
            t.select('input').applyStyles({top:0});
        }

        this.on('specialkey', this.onSpecialKey, this);
        this.df.el.swallowEvent(['keydown', 'keypress']);
        this.tf.el.swallowEvent(['keydown', 'keypress']);
        this.lf.el.swallowEvent(['keydown', 'keypress']);

        // create icon for side invalid errorIcon
        if('side' === this.msgTarget) {
            var elp = this.el.findParent('.x-form-element', 10, true);
            this.errorIcon = elp.createChild({cls:'x-form-invalid-icon'});

            this.df.errorIcon = this.errorIcon;
            this.tf.errorIcon = this.errorIcon;
        }

        // setup name for submit
        this.el.dom.name = this.hiddenName || this.name || this.id;

        // prevent helper fields from being submitted
        this.df.el.dom.removeAttribute("name");
        this.tf.el.dom.removeAttribute("name");
        this.lf.el.dom.removeAttribute("name");

        // add hidden type hint
        if (!this.disableTypeHint) {
            var th = new CQ.Ext.form.Hidden({
                name: this.name + "@TypeHint",
                value: this.typeHint ? this.typeHint : "Date",
                ignoreDate: true,
                renderTo: ct
            });
        }

        // we're rendered flag
        this.isRendered = true;

        // update hidden field
        this.updateHidden();

    },

    /**
     * @private
     */
    adjustSize: CQ.Ext.BoxComponent.prototype.adjustSize,

    /**
     * @private
     */
    alignErrorIcon:function() {
        this.errorIcon.alignTo(this.tableEl, 'tl-tr', [2, 0]);
    },

    /**
     * @private initializes internal dateValue
     */
    initDateValue:function() {
        if (this.defaultValue == "now") {
            this.dateValue = new Date();
        } else if (this.defaultValue) {
            this.dateValue = Date.parseDate(this.defaultValue, this.hiddenFormat);
            if (!this.dateValue) {
                this.dateValue =  new Date();
            }
        } else {
            this.dateValue =  new Date();
        }
    },
    
    /**
     * Calls clearInvalid on the DateField and TimeField
     */
    clearInvalid:function(){
        this.df.clearInvalid();
        this.tf.clearInvalid();
    },
    /**
     * Disable this component.
     * @return {Ext.Component} this
     */
    disable:function() {
        if(this.isRendered) {
            this.onDisable();
            this.df.disabled = this.disabled;
            this.df.onDisable();
            this.tf.onDisable();
        }
        this.disabled = true;
        this.df.disabled = true;
        this.tf.disabled = true;
        this.fireEvent("disable", this);
        return this;
    },
    /**
     * Enable this component.
     * @return {Ext.Component} this
     */
    enable:function() {
        if(this.rendered){
            this.onEnable();
            this.df.onEnable();
            this.tf.onEnable();
        }
        this.disabled = false;
        this.df.disabled = false;
        this.tf.disabled = false;
        this.fireEvent("enable", this);
        return this;
    },
    /**
     * @private Focus date filed
     */
    focus:function() {
        this.df.focus();
    },
    /**
     * @private
     */
    getPositionEl:function() {
        return this.wrap;
    },
    /**
     * @private
     */
    getResizeEl:function() {
        return this.wrap;
    },
    /**
     * Returns value of this field, depending on the config 'valueAsString'.
     * @return {Date/String} Returns value of this field
     */
    getValue:function() {
        // create new instance of date
        if (this.valueAsString) {
            return (this.dateValue && (typeof this.dateValue.format === "function")) ? this.dateValue.format(this.hiddenFormat) : '';
        } else {
            return this.dateValue ? this.dateValue.clone() : '';
        }
    },

    /**
     * Returns the value of this field as date object, regardless of the config 'valueAsString'.
     * @return {Date} value of this field as Date object
     */
    getDateValue: function() {
        return this.dateValue ? this.dateValue.clone() : null;
    },

    /**
     * Converts a value from getValue() or change event to a Date object, regardless of the config 'valueAsString'.
     * @return {Date} the value as Date object
     */
    valueToDate: function(value) {
        return Date.parseDate(value, this.hiddenFormat);
    },

    /**
     * @return {Boolean} True = valid, false = invalid, else false
     * @private Calls isValid methods of underlying DateField and TimeField and returns the result
     */
    isValid:function() {
        return this.df.isValid() && this.tf.isValid();
    },
    /**
     * Returns true if this component is visible
     * @return {Boolean}
     */
    isVisible : function(){
        return this.df.rendered && this.df.getActionEl().isVisible();
    },
    /**
     * @private Handles blur event
     */
    onBlur:function(f) {
        // called by both DateField and TimeField blur events

        // revert focus to previous field if clicked in between
        if(this.wrapClick) {
            f.focus();
            this.wrapClick = false;
        }

        // update underlying value
        if(f === this.df) {
            this.updateDate();
        } else {
            this.updateTime();
        }
        this.updateHidden();

        // fire events later
        (function() {
            if(!this.df.hasFocus && !this.tf.hasFocus) {
                this.checkIfChanged(true);
                this.hasFocus = false;
                this.fireEvent('blur', this);
            }
        }).defer(100, this);

    },

    /**
     * Checks and returns if value has changed and fires
     * "change" event in the case of a modification. If
     * 'skipUpdateValue' is true, it will only check the
     * internal aggregated date+time value against
     * the old value, but not re-get the values from the
     * underlying date and time fields.
     */
    checkIfChanged: function(skipUpdateValue) {
        if (!skipUpdateValue) {
            this.updateValue();
        }
        var v = this.getValue();
        // startValue is undefined if field wasn't focused yet
        if(this.startValue !== undefined && String(v) !== String(this.startValue)) {
            this.fireEvent("change", this, v, this.startValue);
            this.startValue = v;
            return true;
        }
        return false;
    },

    /**
     * @private Handles focus event
     */
    onFocus:function() {
        if(!this.hasFocus){
            this.hasFocus = true;
            this.startValue = this.getValue();
            this.fireEvent("focus", this);
        }
    },
    /**
     * @private Just to prevent blur event when clicked in the middle of fields
     */
    onMouseDown:function(e) {
        if(!this.disabled) {
            this.wrapClick = 'td' === e.target.nodeName.toLowerCase();
        }
    },
    /**
     * @private
     * Handles Tab and Shift-Tab events
     */
    onSpecialKey:function(t, e) {
        var key = e.getKey();
        if(key === e.TAB) {
            if(t === this.df && !e.shiftKey) {
                e.stopEvent();
                this.tf.focus();
            }
            if(t === this.tf && e.shiftKey) {
                e.stopEvent();
                this.df.focus();
            }
        }
        // otherwise it misbehaves in editor grid
        if(key === e.ENTER) {
            this.updateValue();
        }

    },
    /**
     * @private Sets the value of DateField
     */
    setDate:function(date) {
        this.df.setValue(date);
    },
    /**
     * @private Sets the value of TimeField
     */
    setTime:function(date) {
        this.tf.setValue(moment.tz(date, this.timezone).format('HH:mm A'));
    },
    /**
     * @private
     * Sets correct sizes of underlying DateField and TimeField
     * With workarounds for IE bugs
     */
    setSize:function(w, h) {
        if(!w) {
            return;
        }
        if (typeof w == "object") {
            h = w.height;
            w = w.width;
        }
        if('below' === this.timePosition) {
            this.df.setSize(w, h);
            this.tf.setSize(w, h);
            this.lf.setSize(w, h);
            if(CQ.Ext.isIE) {
                this.df.el.up('td').setWidth(w);
                this.tf.el.up('td').setWidth(w);
                this.lf.el.up('td').setWidth(w);
            }
        } else {
            this.df.setSize(w - this.timeWidth - this.labelWidth, h);
            this.tf.setSize(this.timeWidth, h);
            this.lf.setSize(this.labelWidth, h);

            if(CQ.Ext.isIE) {
                this.df.el.up('td').setWidth(w - this.timeWidth - this.labelWidth);
                this.tf.el.up('td').setWidth(this.timeWidth);
                this.lf.el.up('td').setWidth(this.labelWidth);
            }
        }
        this.fireEvent('resize', this, w, h, w, h);
    },
    /**
     * @param {Mixed} val Value to set
     * Sets the value of this field
     */
    setValue:function(val) {
        if (!val) {
            this.setDate('');
            this.setTime('');
            this.updateValue();
            return;
        }
        if ('number' === typeof val) {
          val = new Date(val);
        }

        // todo: date values from content should be automatically converted to Dates
        if ('string' === typeof val) {
            if(val == "now") {
                val = new Date();
  	        } else {
                var v = Date.parse(val);
                if (!v) {
                    v = Date.parseDate(val, this.hiddenFormat);
                }
                if (v) {
                    val = new Date(v);
                }
            }
        }
        val = val ? val : new Date();
        // don't use "val instanceof Date" as that doesn't work between iframes
        if (typeof val.setDate == "function" && typeof val.setTime == "function") {
            this.setDate(val);
            this.setTime(val);
            this.dateValue = val.clone();
        } else {
            var da = val.split(this.dtSeparator);
            this.setDate(da[0]);
            if(da[1]) {
                this.setTime(da[1]);
            }
        }
        this.updateValue();
        this.startValue = this.getValue();
    },
    /**
     * Hide or show this component by boolean
     * @return {Ext.Component} this
     */
    setVisible: function(visible){
        if(visible) {
            this.df.show();
            this.tf.show();
        } else{
            this.df.hide();
            this.tf.hide();
        }
        return this;
    },
    show:function() {
        return this.setVisible(true);
    },
    hide:function() {
        return this.setVisible(false);
    },
    /**
     * @private Updates the date part
     */
    updateDate:function() {

        var d = this.df.getValue();
        if(d) {
            if(!this.isDate(this.dateValue)) {
                this.initDateValue();
                if(!this.tf.getValue()) {
                    this.setTime(this.dateValue);
                }
            }
            this.dateValue.setDate(1); // because of leap years
            this.dateValue.setFullYear(d.getFullYear());
            this.dateValue.setMonth(d.getMonth());
            this.dateValue.setDate(d.getDate());
        } else {
            this.dateValue = '';
            this.setTime('');
        }
    },

	/**
	 * private
	 * Checks if the object is a date by not using instanceof
	 */
	isDate: function(obj) {
        return (typeof(obj)!='undefined') && ((typeof obj.setDate === "function") && (typeof obj.setTime === "function")
		       && (typeof obj.getFirstDateOfMonth === "function") && (typeof obj.getFirstDayOfMonth === "function"));
	},

    /**
     * @private
     * Updates the time part
     */
    updateTime:function() {
        var t = this.tf.getValue();
        if(t && !this.isDate(t)) {
            if(t == "now") {
                t = new Date()
  	        } else {
                t = Date.parseDate(t, this.tf.format);
            }
        }
        if(t && !this.df.getValue()) {
            this.initDateValue();
            this.setDate(this.dateValue);
        }
        if((typeof this.dateValue.setHours === "function")
		    && (typeof this.dateValue.setMinutes === "function")
		    && (typeof this.dateValue.setSeconds === "function")) {
            if(t) {
                this.dateValue.setHours(t.getHours());
                this.dateValue.setMinutes(t.getMinutes());
                this.dateValue.setSeconds(t.getSeconds());
            } else {
                this.dateValue.setHours(0);
                this.dateValue.setMinutes(0);
                this.dateValue.setSeconds(0);
            }
        }
    },
    /**
     * @private Updates the underlying hidden field value
     */
    updateHidden:function() {
        if(this.isRendered) {
            //this.el.dom.value = (this.dateValue && (typeof this.dateValue.format === "function"))
            //        ? this.dateValue.format(this.hiddenFormat)
            //        : '';

        	//////// Customized code
        	// Use Sencha to format the date and then use moment.js to format to the current timezone.
        	// Sencha "submit" action will pick up this value later.
        	this.el.dom.value = this.dateValue ?
        			moment.tz(this.dateValue.format('Y-m-d H:i'), this.timezone).format("YYYY-MM-DDTHH:mm:00.000Z") 
        			: '';
        }
    },
    /**
     * @private Updates all of Date, Time and Hidden
     */
    updateValue:function() {
        this.updateDate();
        this.updateTime();
        this.updateHidden();
    },
    /**
     * @return {Boolean} True = valid, false = invalid, else false
     * calls validate methods of DateField and TimeField
     */
    validate:function() {
        var valid = this.df.validate() && this.tf.validate();

        if(this.validator){
            var result = this.validator.call(this,this.getValue(),this);
            if(result!==true){
                this.df.markInvalid(result);
                this.tf.markInvalid(result);
            }
            valid &= result===true;
        }
        
        return valid;
    },
    /**
     * Returns renderer suitable to render this field
     * @param {Object} Column model config
     */
    renderer: function(field) {
        var format = field.editor.dateFormat || CQ.Ext.form.DateField.prototype.format;
        format += ' ' + (field.editor.timeFormat || CQ.Ext.form.TimeField.prototype.format);
        return function(val) {
            return CQ.Ext.util.Format.date(val, format);
        };
    },
    
    setTimezone: function(timezone) {
    	this.timezone = timezone;
    	this.lf.setText(timezone);
    	this.updateHidden();
    }
    
    
});

// register xtype
CQ.Ext.reg("timezonedatetime", northpoint.components.TimezoneDateTime);
