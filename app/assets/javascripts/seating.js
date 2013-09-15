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
            htmlClass: "seating-panel-table",
            tableList: []
        },
        chairs: {
            number: {
                startNumber: 1,
                htmlClass: "seating-table-number"
            },
            htmlClass: "seating-panel-chair"
        }
    };

    var init = function () {
        enableGuestsMoving();
        createNewIconTable();
    };

    var enableGuestsMoving = function () {
        $(".seating-quest-icon").draggable({
            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
            revert: "invalid"
        });

    };

    var createNewIconTable = function () {
        var tableID = settings.tables.htmlClass + "-" + settings.tables.number.startNumber;
        $(settings.htmlTags.emptyDiv).
            addClass(settings.tables.htmlClass).
            attr("id", tableID).
            draggable({
                grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
                containment: settings.drawArea.name,
                create: function () {
                    settings.drawArea.name.append(this);
                },
                start: function (event) {
                    var $this = $(this);
                    if (!$this.hasClass("active")) {
                        $this.addClass("active");
                        var currentTable = createNewTable({}, $(this));
                        createNewIconTable();
                        $this.resizable({
                            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
                            resize: function () {
                                currentTable.resizeTable();
                            }
                        });
                    }
                },
                stop: function () {

                }
            });
    };

    var createNewTable = function (tableGuests, tableHTML) {
        var table = new Table(settings.tables.number.startNumber++, tableGuests, tableHTML);
        table.init();
        return table;
    };

    function Table(tableNumber, guests, tableHTML) {
        this.chairs = [];
        this.tableNumber = tableNumber;
        this.tableHTML = tableHTML;
        this.tableWidth = tableHTML.width();
        this.init = function () {
            this.drawTableNumber();
            this.addChairs();
            settings.tables.tableList.push(this);
            console.log(this.getTableChairs());
        };
        this.initTable = function () {
            for (var i = 0; i < guests.length; i++) {
                var currentGuest = guests[i];
                var currentChair = new Chair(i, currentGuest);
                this.chairs.push(currentChair);
            }
        };
        this.resizeTable = function () {
            console.log("dfgdfg");
        };
        this.drawTableNumber = function () {
            var tableNumberClass = settings.tables.htmlClass + settings.number.htmlClassPart,
                tableNumberDivId = settings.tables.htmlClass + "-" + this.tableNumber + settings.number.htmlClassPart;
            $(settings.htmlTags.emptyDiv).appendTo(this.tableHTML).addClass(tableNumberClass).attr("id", tableNumberDivId).text(this.tableNumber);

        };
        this.getTableWidth = function () {
            return this.tableHTML.width();
        };
        this.getTableHeight = function () {
            return this.tableHTML.height();
        };
        this.getTableChairs = function () {
            return (this.getTableWidth() / settings.drawArea.gridWidth) * 2 + (this.getTableHeight() / settings.drawArea.gridWidth) * 2;
        }
        this.addChairs = function () {
            var chairIndex = 1,
                self = this;
            for (var i = 0; i < this.getTableWidth() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.tableHTML.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", settings.drawArea.gridWidth * i);
                newChair.init();
            }
            for (var i = 0; i < this.getTableWidth() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.tableHTML.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", settings.drawArea.gridWidth * i).css("top", self.getTableHeight());
                newChair.init();
            }
            for (var i = 0; i < this.getTableHeight() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.tableHTML.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", -settings.drawArea.gridWidth).css("top", settings.drawArea.gridWidth * i);
                newChair.init();
            }
            for (var i = 0; i < this.getTableHeight() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.tableHTML.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", self.getTableWidth()).css("top", settings.drawArea.gridWidth * i);
                newChair.init();
            }
        };
    }

    function Chair(chairNumber, tableNumber, guest) {
        this.chairNumber = chairNumber;
        this.tableNumber = tableNumber;
        this.guest = guest;
        this.id = settings.tables.htmlClass + "-" + this.tableNumber + "-" + settings.chairs.htmlClass + "-" + this.chairNumber;
        this.chairHTML = $(settings.htmlTags.emptyDiv).addClass(settings.chairs.htmlClass).attr("id", this.id);
        this.init = function () {
            this.drawChairNumber();
            this.makeDroppable();
        };
        this.drawChairNumber = function () {
            //    chairNumberDivId = settings.tables.htmlClass + "-" + this.tableNumber + settings.tables.htmlClass + "-" + this.tableNumber + settings.number.htmlClassPart;
            //$(settings.htmlTags.emptyDiv).appendTo(this.tableHTML).addClass(tableNumberClass).attr("id", tableNumberDivId).text(this.tableNumber);
        };
        this.makeDroppable = function () {
            $("#" + this.id).droppable({
                accept: ".seating-quest-icon",
                drop: function (event, ui) {
                    var seat = $(this),
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

