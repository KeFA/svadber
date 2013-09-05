var Seating = function(){
    var settings = {
        drawPanel:{
            name: $(".seating-panel")
        },
        drawArea: {
            name: $(".seating-area"),
            gridWidth: 50,
            tableDraggableIcon: "seating-table-"
        },
        tables: {
            tableStartNumber: 1,
            tableStartName: "seating-table-",
            tableList: [],
            tableHTML: "<div class='seating-panel-table'></div>"
        },
        chairs: {
            chairHTML: "<div class='seating-panel-chair'></div>"
        }
    };

    var init = function() {
        enableGuestsMoving();
        createNewIconTable();
    };

    var enableGuestsMoving = function() {
        $(".seating-quest-icon").draggable({
            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
            revert: "invalid"
        });

    };

    var createNewIconTable = function() {
        var tableID = settings.tables.tableStartName + settings.tables.tableStartNumber,
            newHTMLTable = $(settings.tables.tableHTML).attr("id", tableID).draggable({
            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
            containment: settings.drawArea.name,
            create: function(){
                settings.drawArea.name.append(this);
            },
            start: function(event) {
                if (!$(this).hasClass("active")) {
                    $(this).addClass("active");
                    var currentTable = createNewTable(table1guests, $(this));
                    var table1guests = ["Синкевич Мария Сергеевна", "Синкевич Алексей Викторович", "Мисан Андрей Викторович"],
                        table2guests = ["Синкевич Ольга Борисовна", "Синкевич Виктор Семенович", "Рудько Елена Владимировна", "Рудько Сергей Петрович"];
                    $(this).resizable({
                        grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
                        resize: function() {
                            currentTable.addChairs();
                        }
                    });
                    createNewIconTable();
                }
            },
            stop: function(){

            }
        });
    };

    var createNewTable = function(tableGuests, HTMLTable) {
        var table = new Table(settings.tables.tableStartNumber++, tableGuests, HTMLTable);
        table.addChairs();
        settings.tables.tableList.push(table);
        console.log(table.getTableChairs());
        return table;
    };

    var drawEmptyChairs = function(table) {

    };

    function Table(tableNumber, guests, HTMLTable) {
        this.chairs = [];
        this.tableNumber = tableNumber;
        this.HTMLTable = HTMLTable;
        this.tableWidth = HTMLTable.width();
        this.initTable = function () {
            for (var i = 0; i < guests.length; i++) {
                var currentGuest = guests[i];
                var currentChair = new Chair(i, currentGuest);
                this.chairs.push(currentChair);
            }
        };
        this.getTableWidth = function () {
            return this.HTMLTable.width();
        };
        this.getTableHeight = function () {
            return this.HTMLTable.height();
        };
        this.getTableChairs = function () {
            return (this.getTableWidth() / settings.drawArea.gridWidth) * 2 + (this.getTableHeight() / settings.drawArea.gridWidth) * 2;
        }
        this.addChairs = function () {
            var chairIndex = 1
                self = this;
            for (var i = 0; i < this.getTableWidth() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.HTMLTable.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", settings.drawArea.gridWidth*i);
                newChair.makeDroppable();
            }
            for (var i = 0; i < this.getTableWidth() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.HTMLTable.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", settings.drawArea.gridWidth*i).css("top", self.getTableHeight());
                newChair.makeDroppable();
            }
            for (var i = 0; i < this.getTableHeight() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.HTMLTable.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", -settings.drawArea.gridWidth).css("top", settings.drawArea.gridWidth*i);
                newChair.makeDroppable();
            }
            for (var i = 0; i < this.getTableHeight() / settings.drawArea.gridWidth; i++) {
                var newChair = new Chair(chairIndex++, this.tableNumber, "");
                this.HTMLTable.append(newChair.chairHTML);
                $("#" + newChair.id).css("left", self.getTableWidth()).css("top", settings.drawArea.gridWidth*i);
                newChair.makeDroppable();
            }
        };
        this.resize = function() {

        }
    }

    function Chair(chairNumber, tableNumber, guest) {
        this.number = chairNumber;
        this.guest = guest;
        this.id = "seating-table-" + tableNumber + "-chair-" + chairNumber;
        this.chairHTML = "<div class='seating-panel-chair' id='" + this.id + "'></div>";
        this.makeDroppable = function () {
            $("#" + this.id).droppable({
                accept: ".seating-quest-icon",
                drop: function( event, ui ) {
                    var seat = $(this),
                        guestIcon = ui.draggable;
                    seat.append(guestIcon);
                    guestIcon.css("left", settings.drawArea.gridWidth / 2).css("top", settings.drawArea.gridWidth / 2);
                }
            });
        };
    }

    return {
        "initSeating" : init
    }
}();

Seating.initSeating();

