var Seating = function () {
    var settings = {
        htmlTags: {
            emptyDiv: "<div></div>"
        },
        drawPanel: {
            name: $(".seating-panel")
        },
        drawArea: {
            name: $(".seating-area"),
            gridWidth: 50,
            tableDraggableIcon: "seating-table-"
        },
        number: {
            htmlClassPart: "-number"
        },
        tables: {
            number: {
                startNumber: 1,
                htmlClass: "seating-table-number"
            },
            htmlClass: "seating-table",
            activeClass: "active",
            tableList: []
        },
        chairs: {
            number: {
                startNumber: 1,
                htmlClass: "seating-table-number"
            },
            htmlClass: "seating-chair"
        },
        guests: {
            icon: {
                htmlClass: "seating-quest-icon",
                $htmlClass: ""
            }
        }
    };

    var init = function () {
        enableGuestsMoving();
        createNewTable();
    };

    var enableGuestsMoving = function () {
        settings.guests.icon.$htmlClass = $("." + settings.guests.icon.htmlClass);
        settings.guests.icon.$htmlClass.draggable({
            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
            revert: "invalid"
        });

    };

    var createNewTable = function () {
        var table = new Table(settings.tables.number.startNumber++).init();
        return table;
    };

    function Table(tableNumber) {
        this.chairs = [];
        this.tableNumber = tableNumber;
        this.id = settings.tables.htmlClass + "-" + this.tableNumber;
        this.$id = $("#" + this.id);
        this.init = function () {
            this.createHTMLTable();
            this.makeDraggable();
        };
        this.activateTable = function () {
            this.drawTableNumber();
            this.addChairs();
            settings.tables.tableList.push(this);
        };
        this.createHTMLTable = function () {
            $(settings.htmlTags.emptyDiv).addClass(settings.tables.htmlClass).attr("id", this.id).appendTo(settings.drawArea.name);
            this.$id = $("#" + this.id);
        };
        this.drawTableNumber = function () {
            var tableNumberClass = settings.tables.htmlClass + settings.number.htmlClassPart,
                tableNumberDivId = settings.tables.htmlClass + "-" + this.tableNumber + settings.number.htmlClassPart;
            $(settings.htmlTags.emptyDiv).appendTo(this.$id).addClass(tableNumberClass).attr("id", tableNumberDivId).text(this.tableNumber);
        };
        this.makeDraggable = function () {
            var self = this;
            self.$id.draggable({
                grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
                containment: settings.drawArea.name,
                start: function (event) {
                    var $this = $(this);
                    if (!$this.hasClass(settings.tables.activeClass)) {
                        $this.addClass(settings.tables.activeClass);
                        self.activateTable();
                        createNewTable();
                        $this.resizable({
                            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
                            resize: function () {
                                $this.resizeTable();
                            }
                        });
                    }
                }
            });
        };
        this.getTableWidth = function () {
            return this.$id.width();
        };
        this.getTableHeight = function () {
            return this.$id.height();
        };
        this.getTableChairs = function () {
            return (this.getTableWidth() / settings.drawArea.gridWidth) * 2 + (this.getTableHeight() / settings.drawArea.gridWidth) * 2;
        };
        this.resizeTable = function () {
            console.log("dfgdfg");
        };
        this.addChairs = function () {
            var chairIndex = 1,
                self = this;
            new Chair(chairIndex++, this, "").init();
            console.log(this.getTableWidth());
            console.log(this.getTableHeight());

//            var chairIndex = 1,
//                self = this;
//            for (var i = 0; i < this.getTableWidth() / settings.drawArea.gridWidth; i++) {
//                var newChair = new Chair(chairIndex++, this, "");
//                this.$id.append(newChair.chairHTML);
//                $("#" + newChair.id).css("left", settings.drawArea.gridWidth * i);
//                newChair.init();
//            }
//            for (var i = 0; i < this.getTableWidth() / settings.drawArea.gridWidth; i++) {
//                var newChair = new Chair(chairIndex++, this, "");
//                this.$id.append(newChair.chairHTML);
//                $("#" + newChair.id).css("left", settings.drawArea.gridWidth * i).css("top", self.getTableHeight());
//                newChair.init();
//            }
//            for (var i = 0; i < this.getTableHeight() / settings.drawArea.gridWidth; i++) {
//                var newChair = new Chair(chairIndex++, this., "");
//                this.$id.append(newChair.chairHTML);
//                $("#" + newChair.id).css("left", -settings.drawArea.gridWidth).css("top", settings.drawArea.gridWidth * i);
//                newChair.init();
//            }
//            for (var i = 0; i < this.getTableHeight() / settings.drawArea.gridWidth; i++) {
//                var newChair = new Chair(chairIndex++, this, "");
//                this.$id.append(newChair.chairHTML);
//                $("#" + newChair.id).css("left", self.getTableWidth()).css("top", settings.drawArea.gridWidth * i);
//                newChair.init();
//            }
        };
    }

    function Chair(chairNumber, table, guest) {
        this.chairNumber = chairNumber;
        this.tableNumber = table.tableNumber;
        this.guest = guest;
        this.id = settings.tables.htmlClass + "-" + this.tableNumber + "-" + settings.chairs.htmlClass + "-" + this.chairNumber;
        this.$id = $("#" + this.id);
        this.init = function () {
            this.createHTMLChair();
            this.drawChairNumber();
            this.makeDroppable();
        };
        this.createHTMLChair = function () {
            $(settings.htmlTags.emptyDiv).addClass(settings.chairs.htmlClass).attr("id", this.id).appendTo(table.$id);
            this.$id = $("#" + this.id);
        };
        this.drawChairNumber = function () {
            var chairNumberClass = settings.chairs.htmlClass + settings.number.htmlClassPart,
                chairNumberDivId = this.id + settings.number.htmlClassPart;
            $(settings.htmlTags.emptyDiv).appendTo(this.$id).addClass(chairNumberClass).attr("id", chairNumberDivId).text(this.chairNumber);
        };
        this.makeDroppable = function () {
            this.$id.droppable({
                accept: "." + settings.guests.icon.htmlClass,
                drop: function (event, ui) {
                    var seat = this,
                        guestIcon = ui.draggable,
                        guestName = guestIcon.data("guest");
                    guestIcon.appendTo(seat).css("left", settings.drawArea.gridWidth / 2).css("top", settings.drawArea.gridWidth / 2).text(guestName);
                }
            });
        };
    }

    return {
        "initSeating": init
    }
}();

Seating.initSeating();

