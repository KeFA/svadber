function Table(tableNumber, guests, HTMLTable, tableLength) {
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
    this.initEmptyTable = function () {
        for (var i = 0; i < tableLength; i++) {
            var currentChair = new Chair(i, {});
            this.chairs.push(currentChair);
        }
    };
}

function Chair(number, guest) {
    this.number = number;
    this.guest = guest;
}

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
        }
    };

    var init = function() {
        enableGuestsMoving();
        createNewIconTable();
    };

    var enableGuestsMoving = function() {
        $(".seating-quest-icon").draggable({
            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
            revert: 'invalid'
        });

    };

    var enablePanelRectangleTable = function() {
//        var table = "#" + settings.drawArea.tableDraggableIcon + settings.tables.tableStartNumber;
//            console.log(table);
//        $(table).draggable({
//            create: function(){
//                console.log("create");
//                alert("ee");
//                var table1guests = ["Синкевич Мария Сергеевна", "Синкевич Алексей Викторович", "Мисан Андрей Викторович"],
//                    table2guests = ["Синкевич Ольга Борисовна", "Синкевич Виктор Семенович", "Рудько Елена Владимировна", "Рудько Сергей Петрович"];
//                createNewTable(table1guests);
//
//            },
//            start: function(event) {
//                $(this).addClass("active");
//            }
//        });

    };

    var createNewIconTable = function() {
        var tableID = settings.tables.tableStartName + settings.tables.tableStartNumber,
            newHTMLTable = $(settings.tables.tableHTML).attr("id", tableID).draggable({
            grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth],
            create: function(){
                settings.drawArea.name.append(this);
            },
            start: function(event) {
                if (!$(this).hasClass("active")) {

                    var table1guests = ["Синкевич Мария Сергеевна", "Синкевич Алексей Викторович", "Мисан Андрей Викторович"],
                        table2guests = ["Синкевич Ольга Борисовна", "Синкевич Виктор Семенович", "Рудько Елена Владимировна", "Рудько Сергей Петрович"];
                    $(this).addClass("active").resizable({
                        grid: [settings.drawArea.gridWidth, settings.drawArea.gridWidth]
                    });
                    console.log($(this).width());
                    createNewTable(table1guests, $(this));
                    createNewIconTable();
                }
            }
        });
    };

    var createNewTable = function(tableGuests, HTMLTable) {
        var table = new Table(settings.tables.tableStartNumber++, tableGuests, HTMLTable, 8);
        table.initEmptyTable();
        drawEmptyChairs(table);
        settings.tables.tableList.push(table);
        console.log(table);
    };

    var drawEmptyChairs = function(table) {

    };

    return {
        "initSeating" : init
    }
}();

Seating.initSeating();

